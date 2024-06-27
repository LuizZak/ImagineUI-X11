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
    private var _state: XWindowState = .pending

    private let minSize: Size = Size(width: 200, height: 150)

    /// Set to `true` when a `DestroyNotify` event has been received.
    private var isDestroyed: Bool {
        _state == .destroyed
    }

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
        self.size = .init(width: settings.size.width, height: settings.size.height)

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

        // Pre-scale window size
        let dpiScale = displayScaling(settings.display) / 92.0
        let scaledWidth = Double(settings.size.width) * dpiScale
        let scaledHeight = Double(settings.size.height) * dpiScale

        window = XCreateWindow(
            display,
            rootWindow,
            0, 0, UInt32(scaledWidth), UInt32(scaledHeight),
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

    private func _onDestroy() {
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
            // Open/close, resizing events, and misc.
            StructureNotifyMask | SubstructureNotifyMask |
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

    public func setWindowAttributes(
        _ attributes: XSetWindowAttributes,
        valueMask: some FixedWidthInteger
    ) {
        var attributes = attributes
        XChangeWindowAttributes(display, window, UInt(truncatingIfNeeded: valueMask), &attributes)
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

    /// Performs coalescing of redraw region rectangles, by merging/splitting/union
    /// of a given input set of rectangles.
    open func coalescedRedrawRegion(_ rects: [Rect]) -> [Rect] {
        guard let first = rects.first else { return [] }

        let merged = rects.reduce(first) { $0.union($1) }
        return [merged]
    }

    /// Flushes all entries of `setNeedsDisplay()` calls made so far into a sequence
    /// of underlying OS messages to be handled on a subsequent draw event operation
    /// on this window.
    func flushRedisplayAreas() {
        guard !self.isDestroyed else { return }
        guard !_redisplayAreas.isEmpty else { return }

        let areas = coalescedRedrawRegion(_redisplayAreas)
        _redisplayAreas.removeAll()

        for (i, rect) in areas.enumerated() {
            let remaining = areas.count - i - 1
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
            event.width = min(Int32(size.width), event.width)
            event.height = min(Int32(size.height), event.height)

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

    /// Called when the window has received an initial `ConfigureNotify` event.
    ///
    /// Always call `super.onCreate(event)` when overriding this method.
    ///
    /// X11 API reference: https://www.x.org/releases/current/doc/libX11/libX11/libX11.html#ConfigureNotify_Events
    open func onCreate(_ event: XConfigureEvent) {
        _state = .created

        onResize(event)
    }

    /// Called when the window has received a `DestroyNotify` event.
    ///
    /// Always call `super.onClose(event)` when overriding this method.
    ///
    /// X11 API reference: https://www.x.org/releases/current/doc/libX11/libX11/libX11.html#DestroyNotify_Events
    open func onClose(_ event: XDestroyWindowEvent) {
        _state = .destroyed

        _onDestroy()
    }

    /// Called when the window has received a a `ExposureNotify` event.
    ///
    /// Classes that override this method should handle updating needsDisplay and
    /// should not call `super.onPaint()` if GDI draw calls where made.
    ///
    /// X11 API reference: https://www.x.org/releases/current/doc/libX11/libX11/libX11.html#Expose_Events
    open func onPaint(_ event: XExposeEvent) {
        clearNeedsDisplay()
    }

    /// Called when the window has received a `ConfigureNotify` event.
    ///
    /// X11 API reference: https://www.x.org/releases/current/doc/libX11/libX11/libX11.html#ConfigureNotify_Events
    open func onResize(_ event: XConfigureEvent) {
        size.width = Int(event.width)
        size.height = Int(event.height)
    }

    /// Called when the DPI settings for the display the window is hosted on
    /// changes.
    ///
    /// X11 API reference: https://www.x.org/releases/current/doc/libX11/libX11/libX11.html#ConfigureNotify_Events
    open func onDPIChanged(_ event: XConfigureEvent) {
        dpi = Int(displayScaling(display))
    }

    // MARK: Mouse events

    /// Called when the mouse leaves the client area of this window.
    ///
    /// X11 API reference: https://www.x.org/releases/current/doc/libX11/libX11/libX11.html#Window_EntryExit_Events
    open func onMouseLeave(_ event: XLeaveWindowEvent) {
        isMouseTrackingOn = false
    }

    /// Called when the mouse hovers on top of the client area of this window
    /// within a small rectangle for a period of time.
    ///
    /// This event is not setup automatically and `TrackMouseEvent` needs to be
    /// invoked in order to setup this type of tracking behaviour.
    ///
    /// X11 API reference: ??? (not tied to any event currently)
    open func onMouseHover(_ event: XEvent) {
        isMouseTrackingOn = false
    }

    /// Called when the mouse moves within the client area of this window.
    ///
    /// Also sets up mouse tracking so `onMouseLeave(_:)` can be raised next time
    /// the mouse leaves the control area of this window.
    ///
    /// X11 API reference: https://www.x.org/releases/current/doc/libX11/libX11/libX11.html#Keyboard_and_Pointer_Events
    open func onMouseMove(_ event: XPointerMovedEvent) -> EventResult? {
        if trackMouseLeave {
            setupMouseTracking()
        }

        return nil
    }

    /// Called when the mouse scrolls within the client area of this window.
    ///
    /// Equivalent to Buttons 4 and 5.
    ///
    /// X11 API reference: https://www.x.org/releases/current/doc/libX11/libX11/libX11.html#Pointer_Button_Events
    open func onMouseWheel(_ event: XButtonPressedEvent) -> EventResult? {
        return nil
    }

    /// Called when the mouse scrolls in the horizontal direction within the
    /// client area of this window.
    ///
    /// Equivalent to Buttons 6 and 7.
    ///
    /// X11 API reference: https://www.x.org/releases/current/doc/libX11/libX11/libX11.html#Pointer_Button_Events
    open func onMouseHWheel(_ event: XButtonPressedEvent) -> EventResult? {
        return nil
    }

    /// Called when the user presses down the left mouse button within the client
    /// area of this window.
    ///
    /// X11 API reference: https://www.x.org/releases/current/doc/libX11/libX11/libX11.html#Pointer_Button_Events
    open func onLeftMouseDown(_ event: XButtonPressedEvent) -> EventResult? {
        return nil
    }

    /// Called when the user presses down the middle mouse button within the client
    /// area of this window.
    ///
    /// X11 API reference: https://www.x.org/releases/current/doc/libX11/libX11/libX11.html#Pointer_Button_Events
    open func onMiddleMouseDown(_ event: XButtonPressedEvent) -> EventResult? {
        return nil
    }

    /// Called when the user presses down the right mouse button within the client
    /// area of this window.
    ///
    /// X11 API reference: https://www.x.org/releases/current/doc/libX11/libX11/libX11.html#Pointer_Button_Events
    open func onRightMouseDown(_ event: XButtonPressedEvent) -> EventResult? {
        return nil
    }

    /// Called when the user releases the left mouse button within the client
    /// area of this window.
    ///
    /// X11 API reference: https://www.x.org/releases/current/doc/libX11/libX11/libX11.html#Pointer_Button_Events
    open func onLeftMouseUp(_ event: XButtonReleasedEvent) -> EventResult? {
        return nil
    }

    /// Called when the user releases the middle mouse button within the client
    /// area of this window.
    ///
    /// X11 API reference: https://www.x.org/releases/current/doc/libX11/libX11/libX11.html#Pointer_Button_Events
    open func onMiddleMouseUp(_ event: XButtonReleasedEvent) -> EventResult? {
        return nil
    }

    /// Called when the user releases the right mouse button within the client
    /// area of this window.
    ///
    /// X11 API reference: https://www.x.org/releases/current/doc/libX11/libX11/libX11.html#Pointer_Button_Events
    open func onRightMouseUp(_ event: XButtonReleasedEvent) -> EventResult? {
        return nil
    }

    // MARK: Keyboard events

    /// Called when the user presses a keyboard key while this window has focus.
    ///
    /// X11 API reference: https://www.x.org/releases/current/doc/libX11/libX11/libX11.html#Keyboard_and_Pointer_Events
    open func onKeyDown(_ event: XKeyPressedEvent) -> EventResult? {
        return nil
    }

    /// Called when the user releases a keyboard key while this window has focus.
    ///
    /// X11 API reference: https://www.x.org/releases/current/doc/libX11/libX11/libX11.html#Keyboard_and_Pointer_Events
    open func onKeyUp(_ event: XKeyReleasedEvent) -> EventResult? {
        return nil
    }

    /// State of the window associated with an X11Window.
    private enum XWindowState {
        /// Window is pending being created; a `CreateNotify` event is still
        /// pending before the window is considered created.
        case pending

        /// The window has received a `CreateNotify` event.
        case created

        /// The window has received a `DestroyNotify` event.
        case destroyed
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
                let event = event.xconfigure

                if _state == .pending {
                    return onCreate(event)
                }

                if event.width != size.width || event.height != size.height {
                    return onResize(event)
                }

                let newDpi = Int(displayScaling(display))
                if dpi != newDpi {
                    return onDPIChanged(event)
                }

                return ()

            case DestroyNotify:
                return onClose(event.xdestroywindow)

            default:
                return nil
        }
    }
}
