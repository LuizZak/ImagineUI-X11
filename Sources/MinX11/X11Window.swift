import CX11
import Foundation

/// An X11 window.
open class X11Window {
    public typealias EventResult = Void

    /// Array with references to currently opened windows.
    /// Used to keep `X11Window` instances alive for at least as long as the
    /// X11 window.
    @ConcurrentValue
    internal static var openWindows: [X11Window] = []

    /// X-11 display pointer.
    private var _display: UnsafeMutablePointer<Display>
    /// X-11 screen pointer.
    private var _screen: UnsafeMutablePointer<Screen>

    private var _attributes: XWindowAttributes {
        var attributes = XWindowAttributes()
        XGetWindowAttributes(_display, window, &attributes)
        return attributes
    }

    private var _windowSize: (width: Int32, height: Int32) {
        let attr = _attributes
        return (attr.width, attr.height)
    }

    private let minSize: Size = Size(width: 200, height: 150)

    /// Set to `true` when a `WM_DESTROY` message has been received.
    private var isDestroyed: Bool = false

    /// Whether `TrackMouseEvent` is activated for this window.
    private var isMouseTrackingOn: Bool = false

    /// The default screen DPI constant.
    /// Usually defined as 96 on Windows versions that support it.
    public static let defaultDPI = 96

    public private(set) var size: Size
    public private(set) var needsDisplay: Bool = false
    public private(set) var needsLayout: Bool = false

    /// X11 XIC.
    public private(set) var xic: XIC

    /// DPI, or dots-per-inch- value of the window.
    /// Initializes to `X11Window.defaultDPI` by default.
    public var dpi: Int = X11Window.defaultDPI {
        didSet {
            dpiScalingFactor = Double(dpi) / Double(Self.defaultDPI)
        }
    }

    /// Returns a value that represents the current DPI scaling factor, which is
    /// `self.dpi / X11Window.defaultDPI`.
    ///
    /// Higher DPI settings lead to higher scaling factors which must be accounted
    /// for by window clients.
    ///
    /// Defaults to 1.0 at instantiation, and changes automatically in response
    /// to changes in `self.dpi`.
    public private(set) var dpiScalingFactor: Double = 1.0

    /// Whether the window should automatically invoke `TrackMouseEvent` whenever
    /// the mouse cursor enters the client area to raise a `WM_MOUSELEAVE` event
    /// the next time the mouse cursor leaves the client area.
    ///
    /// Setting this value to `false` stops `TrackMouseEvent` from being called
    /// during `onMouseMove(_:)`.
    ///
    /// Defaults to `true`.
    public var trackMouseLeave: Bool = true

    /// The handle for the underlying X11 window object.
    public let window: Window

    public init(settings: CreationSettings) {
        self.size = settings.size

        _display = settings.display

        // Get the default screen
        guard let s = XDefaultScreenOfDisplay(_display) else {
            fatalError("Failed to fetch default screen")
        }
        _screen = s

        // And the current root window on that screen
        let rootWindow = _screen.pointee.root

        // Create our window
        window = XCreateSimpleWindow(
            _display,
            rootWindow,
            10, 10, UInt32(settings.size.width), UInt32(settings.size.height),
            1,
            _screen.pointee.black_pixel,
            _screen.pointee.white_pixel
        )
        XStoreName(_display, window, settings.title)

        var xim: XIM
        if let _xim = XOpenIM(_display, nil, nil, nil) {
            xim = _xim
        } else {
            XSetLocaleModifiers("@im=none")
            xim = XOpenIM(_display, nil, nil, nil)
        }

        xic = _XCreateIC(xim, window)
        XSetICFocus(xic)

        initialize()
    }

    private func onDestroy() {
        X11Window._openWindows.withWriteAccess { openWindows in
            if let index = openWindows.firstIndex(where: { $0 === self }) {
                openWindows.remove(at: index)
            }
        }
    }

    /// Configures mouse tracking for the current window so mouse leave events
    /// can be properly raised.
    private func setupMouseTracking() {
        guard !isMouseTrackingOn else { return }
    }

    open func initialize() {
        let eventsMask =
            // Resizing events and misc.
            StructureNotifyMask |
            // Drawing
            ExposureMask |
            // Keyboard
            KeyPressMask | KeyReleaseMask |
            // Mouse
            ButtonPressMask | ButtonReleaseMask | PointerMotionMask |
            ButtonMotionMask | EnterWindowMask | LeaveWindowMask

        XSelectInput(
            _display,
            window,
            eventsMask
        )
    }

    // MARK: Display

    /// Displays this window on the screen.
    ///
    /// Should not be called if the window has been closed.
    open func show() {
        X11Window._openWindows.withWriteAccess { openWindows in
            if !openWindows.contains(where: { $0 === self }) {
                openWindows.append(self)
            }
        }

        if isDestroyed {
            //X11Logger.warning("Called show() on a \(X11Window.self) after a WM_DESTROY (onClose()) message has been received. The window will not be shown.")
        }

        // Display the Window on the X11 Server
        XMapWindow(_display, window)

        //ShowWindow(hwnd, SW_RESTORE)
    }

    open func setNeedsLayout() {
        guard needsLayout == false else { return }
        needsLayout = true

        RunLoop.main.perform { [weak self] in
            guard let self = self else { return }

            while self.needsLayout {
                self.onLayout()
            }
        }
    }

    open func clearNeedsLayout() {
        needsLayout = false
    }

    open func clearNeedsDisplay() {
        needsDisplay = false
    }

    open func setNeedsDisplay() {
        setNeedsDisplay(Rect(origin: .zero, size: size))
    }

    open func setNeedsDisplay(_ rect: Rect) {
        let size = _windowSize
        XClearArea(_display, window, 0, 0, UInt32(size.width), UInt32(size.height), 1 /* generate Expose event? */)
        XFlush(_display) // Request an expose event asap

        needsDisplay = true
    }

    // MARK: Layout events

    /// Called when the window is updating its layout after a call to
    /// `setNeedsLayout()` has been made recently.
    open func onLayout() {
        clearNeedsLayout()
    }

    // MARK: Window events

    /// Called when the window has received a `DestroyNotify` event.
    ///
    /// Win32 API reference: https://docs.microsoft.com/en-us/windows/win32/winmsg/wm-destroy
    open func onClose(_ event: XDestroyWindowEvent) {
        isDestroyed = true
    }

    /// Called when the window has received a a `ExposureNotify` event.
    ///
    /// Classes that override this method should handle updating needsDisplay and
    /// should not call `super.onPaint()` if GDI draw calls where made.
    ///
    /// Win32 API reference: https://docs.microsoft.com/en-us/windows/win32/gdi/wm-paint
    open func onPaint(_ event: XExposeEvent) {
        if !needsDisplay {
            return
        }


    }

    /// Called when the window has received a `ConfigureNotify` event.
    ///
    /// Win32 API reference: https://docs.microsoft.com/en-us/windows/win32/winmsg/wm-size
    open func onResize(_ event: XConfigureEvent) {

    }

    /// Called when the DPI settings for the display the window is hosted on
    /// changes.
    ///
    /// Win32 API reference: https://docs.microsoft.com/en-us/windows/win32/hidpi/wm-dpichanged
    open func onDPIChanged(_ event: XEvent) {

    }

    // MARK: Mouse events

    /// Called when the mouse leaves the client area of this window.
    open func onMouseLeave(_ event: XLeaveWindowEvent) {
        isMouseTrackingOn = false
    }

    /// Called when the mouse hovers on top of the client area of this window
    /// within a small rectangle for a period of time.
    ///
    /// This event is not setup automatically and `TrackMouseEvent` needs to be
    /// invoked in order to setup this type of tracking behaviour.
    ///
    /// Win32 API reference: https://learn.microsoft.com/en-us/windows/win32/inputdev/wm-mousehover
    open func onMouseHover(_ event: XEvent) {
        isMouseTrackingOn = false
    }

    /// Called when the mouse moves within the client area of this window.
    ///
    /// Also sets up mouse tracking so `onMouseLeave(_:)` can be raised next time
    /// the mouse leaves the control area of this window.
    open func onMouseMove(_ event: XPointerMovedEvent) -> EventResult? {
        if trackMouseLeave {
            setupMouseTracking()
        }

        return nil
    }

    /// Called when the mouse scrolls within the client area of this window.
    ///
    /// Equivalent to Buttons 4 and 5.
    open func onMouseWheel(_ event: XButtonPressedEvent) -> EventResult? {
        return nil
    }

    /// Called when the mouse scrolls in the horizontal direction within the
    /// client area of this window.
    ///
    /// Equivalent to Buttons 6 and 7.
    open func onMouseHWheel(_ event: XButtonPressedEvent) -> EventResult? {
        return nil
    }

    /// Called when the user presses down the left mouse button within the client
    /// area of this window.
    open func onLeftMouseDown(_ event: XButtonPressedEvent) -> EventResult? {
        return nil
    }

    /// Called when the user presses down the middle mouse button within the client
    /// area of this window.
    open func onMiddleMouseDown(_ event: XButtonPressedEvent) -> EventResult? {
        return nil
    }

    /// Called when the user presses down the right mouse button within the client
    /// area of this window.
    open func onRightMouseDown(_ event: XButtonPressedEvent) -> EventResult? {
        return nil
    }

    /// Called when the user releases the left mouse button within the client
    /// area of this window.
    open func onLeftMouseUp(_ event: XButtonReleasedEvent) -> EventResult? {
        return nil
    }

    /// Called when the user releases the middle mouse button within the client
    /// area of this window.
    open func onMiddleMouseUp(_ event: XButtonReleasedEvent) -> EventResult? {
        return nil
    }

    /// Called when the user releases the right mouse button within the client
    /// area of this window.
    open func onRightMouseUp(_ event: XButtonReleasedEvent) -> EventResult? {
        return nil
    }

    // MARK: Keyboard events

    /// Called when the user presses a keyboard key while this window has focus.
    open func onKeyDown(_ event: XKeyPressedEvent) -> EventResult? {
        return nil
    }

    /// Called when the user releases a keyboard key while this window has focus.
    open func onKeyUp(_ event: XKeyReleasedEvent) -> EventResult? {
        return nil
    }

    /// > Posted to the window with the keyboard focus when the user presses the
    /// > F10 key (which activates the menu bar) or holds down the ALT key and
    /// > then presses another key.
    ///
    /// > It also occurs when no window currently has
    /// > the keyboard focus; in this case, the WM_SYSKEYDOWN message is sent to
    /// > the active window. The window that receives the message can distinguish
    /// > between these two contexts by checking the context code in the lParam
    /// > parameter.
    ///
    /// Return a non-nil value to prevent the window from sending the message to
    /// `DefSubclassProc` or `DefWindowProc`.
    ///
    /// From Win32 API reference: https://docs.microsoft.com/en-us/windows/win32/inputdev/wm-syskeydown
    open func onSystemKeyDown(_ event: XKeyPressedEvent) -> EventResult? {
        return nil
    }

    /// "Posted to the window with the keyboard focus when the user releases a
    /// key that was pressed while the ALT key was held down."
    ///
    /// "It also occurs when no window currently has the keyboard focus; in this
    /// case, the WM_SYSKEYUP message is sent to the active window. The window
    /// that receives the message can distinguish between these two contexts by
    /// checking the context code in the lParam parameter."
    ///
    /// Return a non-nil value to prevent the window from sending the message to
    /// `DefSubclassProc` or `DefWindowProc`.
    ///
    /// From Win32 API reference: https://docs.microsoft.com/en-us/windows/win32/inputdev/wm-syskeyup
    open func onSystemKeyUp(_ event: XKeyReleasedEvent) -> EventResult? {
        return nil
    }

    /// Called when the user presses a keyboard key while this window has focus.
    open func onKeyCharDown(_ event: XKeyPressedEvent) -> EventResult? {
        return nil
    }

    /// Called when the user presses a keyboard key of a representable character
    /// while this window has focus.
    open func onKeyChar(_ event: XKeyPressedEvent) -> EventResult? {
        return nil
    }

    /// Called when the user presses a keyboard key of a representable "dead"
    /// character while this window has focus.
    ///
    /// > A dead key is a key that generates a character, such as the umlaut
    /// > (double-dot), that is combined with another character to form a composite
    /// > character. For example, the umlaut-O character ( ) is generated by typing
    /// > the dead key for the umlaut character, and then typing the O key.
    ///
    /// - Win32 API documentation
    open func onKeyDeadChar(_ event: XKeyPressedEvent) -> EventResult? {
        return nil
    }
}

internal extension X11Window {
    func handleEvent(_ event: XEvent) -> EventResult? {
        switch event.type {
            case Expose:
                return onPaint(event.xexpose)

            // Keyboard
            case KeyPress:
                return onKeyDown(event.xkey)
            case KeyRelease:
                return onKeyUp(event.xkey)

            // Mouse
            case ButtonPress:
                let event = event.xbutton

                switch Int32(event.button) {
                case Button1:
                    return onLeftMouseDown(event)
                case Button2:
                    return onMiddleMouseDown(event)
                case Button3:
                    return onRightMouseDown(event)
                case Button4, Button5:
                    return onMouseWheel(event)
                default:
                    X11Logger.warning("Unknown ButtonPress event button \(event.button)")
                    return nil
                }

            case ButtonRelease:
                let event = event.xbutton

                switch Int32(event.button) {
                case Button1:
                    return onLeftMouseUp(event)
                case Button2:
                    return onMiddleMouseUp(event)
                case Button3:
                    return onRightMouseUp(event)
                case Button4, Button5:
                    return nil // Maps as mouse wheel; only handle as button presses
                default:
                    X11Logger.warning("Unknown ButtonPress event button \(event.button)")
                    return nil
                }

            case MotionNotify:
                return onMouseMove(event.xmotion)

            case EnterNotify:
                return onMouseMove(event.xmotion)

            case LeaveNotify:
                return onMouseLeave(event.xcrossing)

            case ConfigureNotify:
                return onResize(event.xconfigure)

            case DestroyNotify:
                return onClose(event.xdestroywindow)

            default:
                return nil
        }
    }
}