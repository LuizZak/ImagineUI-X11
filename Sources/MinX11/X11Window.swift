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

    private var _attributes: XWindowAttributes {
        var attributes = XWindowAttributes()
        XGetWindowAttributes(display, window, &attributes)
        return attributes
    }

    private var _windowSize: (width: Int32, height: Int32) {
        let attr = _attributes
        return (attr.width, attr.height)
    }

    private var _redisplayAreas: [Rect] = []

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

    /// X-11 screen pointer.
    public let screen: UnsafeMutablePointer<Screen>

    /// X-11 display pointer.
    public let display: UnsafeMutablePointer<Display>

    /// The handle for the underlying X11 window object.
    public let window: Window

    /// X-11 color map for created window.
    public let colorMap: Colormap

    /// X-11 visual info for created window.
    public let visualInfo: XVisualInfo

    public init(settings: CreationSettings) {
        self.size = settings.size

        display = settings.display

        // Get the default screen
        guard let s = XDefaultScreenOfDisplay(display) else {
            fatalError("Failed to fetch default screen")
        }
        screen = s

        // And the current root window on that screen
        let rootWindow = XRootWindowOfScreen(screen)

        // Create our window
        var visualInfo: XVisualInfo = .init()
        let result = XMatchVisualInfo(
            display,
            XDefaultScreen(display),
            32,
            TrueColor,
            &visualInfo
        )
        if result == 0 {
            fatalError("Failed to resolve 32-bit TrueColor visual information.")
        }
        colorMap = XCreateColormap(display, rootWindow, visualInfo.visual, AllocNone)

        var attr: XSetWindowAttributes = .init()
        attr.colormap = colorMap
        attr.border_pixel = 0
        attr.background_pixel = 0xFFFFFFFF

        window = XCreateWindow(
            display,
            rootWindow,
            10, 10, UInt32(settings.size.width), UInt32(settings.size.height),
            1,
            visualInfo.depth,
            UInt32(InputOutput),
            visualInfo.visual,
            UInt(CWColormap | CWBorderPixel | CWBackPixel),
            &attr
        )
        XStoreName(display, window, settings.title)

        self.visualInfo = visualInfo

        var xim: XIM
        if let _xim = XOpenIM(display, nil, nil, nil) {
            xim = _xim
        } else {
            XSetLocaleModifiers("@im=none")
            xim = XOpenIM(display, nil, nil, nil)
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

        XFreeColormap(display, colorMap)
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
            display,
            window,
            eventsMask
        )
    }

    // MARK: Display

    /// Displays this window on the screen.
    ///
    /// Should not be called if the window has been closed.
    open func show() {
        guard !isDestroyed else {
            X11Logger.warning("Called show() on a \(X11Window.self) after a XDestroyWindow (onClose()) message has been received. The window will not be shown.")
            return
        }

        X11Window._openWindows.withWriteAccess { openWindows in
            if !openWindows.contains(where: { $0 === self }) {
                openWindows.append(self)
            }
        }

        // Display the Window on the X11 Server
        XMapWindow(display, window)
    }

    open func setNeedsLayout() {
        guard needsLayout == false else { return }
        needsLayout = true

        RunLoop.main.perform { [weak self] in
            self?._performLayoutAndDisplay()
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
        guard rect.size.width > 0 && rect.size.height > 0 else {
            return
        }

        self.needsDisplay = true

        // Scale the rectangle appropriately
        let rect = rect.scaled(by: dpiScalingFactor)

        _redisplayAreas.append(rect)
    }

    func _performLayoutAndDisplay() {
        while needsLayout {
            onLayout()
        }

        flushRedisplayAreas()
    }

    /// Flushes all entries of `setNeedsDisplay()` calls made so far into a sequence
    /// of underlying OS messages to be handled on a subsequent draw event operation
    /// on this window.
    func flushRedisplayAreas() {
        guard !self.isDestroyed, let first = _redisplayAreas.first else { return }
        defer { _redisplayAreas.removeAll() }

        let merged = _redisplayAreas.reduce(first) { $0.union($1) }
        _redisplayAreas = [merged]

        for (i, rect) in _redisplayAreas.enumerated() {
            let remaining = _redisplayAreas.count - i - 1
#if true
            var event: XExposeEvent = .init()
            event.window = window
            event.type = Expose
            event.display = display
            event.x = Int32(rect.origin.x)
            event.y = Int32(rect.origin.y)
            event.width = Int32(rect.size.width)
            event.height = Int32(rect.size.height)
            event.count = Int32(remaining)

            // Clamp coordinates
            event.x = max(0, event.x)
            event.y = max(0, event.y)

            var xEvent = XEvent(xexpose: event)
            XSendEvent(
                display,
                window,
                1,
                ExposureMask,
                &xEvent
            )
#else
            _=remaining // Unused
            XClearArea(
                self.display,
                self.window,
                Int32(rect.origin.x),
                Int32(rect.origin.y),
                UInt32(rect.size.width),
                UInt32(rect.size.height),
                1 /* generate Expose event? */
            )
#endif
        }

        XFlush(display)
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

        onDestroy()
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
        size.width = Int(event.width)
        size.height = Int(event.height)

        dpi = Int(displayScaling(display))
    }

    /// Called when the DPI settings for the display the window is hosted on
    /// changes.
    ///
    /// Win32 API reference: https://docs.microsoft.com/en-us/windows/win32/hidpi/wm-dpichanged
    open func onDPIChanged(_ event: XEvent) {
        print(event)
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

private enum _XEventType: Int32 {
    case KeyPress = 2
    case KeyRelease = 3
    case ButtonPress = 4
    case ButtonRelease = 5
    case MotionNotify = 6
    case EnterNotify = 7
    case LeaveNotify = 8
    case FocusIn = 9
    case FocusOut = 10
    case KeymapNotify = 11
    case Expose = 12
    case GraphicsExpose = 13
    case NoExpose = 14
    case VisibilityNotify = 15
    case CreateNotify = 16
    case DestroyNotify = 17
    case UnmapNotify = 18
    case MapNotify = 19
    case MapRequest = 20
    case ReparentNotify = 21
    case ConfigureNotify = 22
    case ConfigureRequest = 23
    case GravityNotify = 24
    case ResizeRequest = 25
    case CirculateNotify = 26
    case CirculateRequest = 27
    case PropertyNotify = 28
    case SelectionClear = 29
    case SelectionRequest = 30
    case SelectionNotify = 31
    case ColormapNotify = 32
    case ClientMessage = 33
    case MappingNotify = 34
    case GenericEvent = 35

    var description: String {
        switch self {
        case .KeyPress:
            return "KeyPress"
        case .KeyRelease:
            return "KeyRelease"
        case .ButtonPress:
            return "ButtonPress"
        case .ButtonRelease:
            return "ButtonRelease"
        case .MotionNotify:
            return "MotionNotify"
        case .EnterNotify:
            return "EnterNotify"
        case .LeaveNotify:
            return "LeaveNotify"
        case .FocusIn:
            return "FocusIn"
        case .FocusOut:
            return "FocusOut"
        case .KeymapNotify:
            return "KeymapNotify"
        case .Expose:
            return "Expose"
        case .GraphicsExpose:
            return "GraphicsExpose"
        case .NoExpose:
            return "NoExpose"
        case .VisibilityNotify:
            return "VisibilityNotify"
        case .CreateNotify:
            return "CreateNotify"
        case .DestroyNotify:
            return "DestroyNotify"
        case .UnmapNotify:
            return "UnmapNotify"
        case .MapNotify:
            return "MapNotify"
        case .MapRequest:
            return "MapRequest"
        case .ReparentNotify:
            return "ReparentNotify"
        case .ConfigureNotify:
            return "ConfigureNotify"
        case .ConfigureRequest:
            return "ConfigureRequest"
        case .GravityNotify:
            return "GravityNotify"
        case .ResizeRequest:
            return "ResizeRequest"
        case .CirculateNotify:
            return "CirculateNotify"
        case .CirculateRequest:
            return "CirculateRequest"
        case .PropertyNotify:
            return "PropertyNotify"
        case .SelectionClear:
            return "SelectionClear"
        case .SelectionRequest:
            return "SelectionRequest"
        case .SelectionNotify:
            return "SelectionNotify"
        case .ColormapNotify:
            return "ColormapNotify"
        case .ClientMessage:
            return "ClientMessage"
        case .MappingNotify:
            return "MappingNotify"
        case .GenericEvent:
            return "GenericEvent"
        }
    }
}
