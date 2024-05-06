import Foundation

public protocol WindowType {
    associatedtype CreationSettings
    associatedtype EventResult
    associatedtype EventType

    var size: Size { get }
    var needsDisplay: Bool { get }
    var needsLayout: Bool { get }

    /// DPI, or dots-per-inch- value of the window.
    /// Initializes to `X11Window.defaultDPI` by default.
    var dpi: Int { get }

    /// Returns a value that represents the current DPI scaling factor, which is
    /// `self.dpi / X11Window.defaultDPI`.
    ///
    /// Higher DPI settings lead to higher scaling factors which must be accounted
    /// for by window clients.
    ///
    /// Defaults to 1.0 at instantiation, and changes automatically in response
    /// to changes in `self.dpi`.
    var dpiScalingFactor: Double { get }

    /// Whether the window should automatically invoke `TrackMouseEvent` whenever
    /// the mouse cursor enters the client area to raise a `WM_MOUSELEAVE` event
    /// the next time the mouse cursor leaves the client area.
    ///
    /// Setting this value to `false` stops `TrackMouseEvent` from being called
    /// during `onMouseMove(_:)`.
    ///
    /// Defaults to `true`.
    var trackMouseLeave: Bool { get }

    init(settings: CreationSettings)

    func initialize()

    // MARK: Display

    /// Displays this window on the screen.
    ///
    /// Should not be called if the window has been closed.
    func show()

    func setNeedsLayout()

    func clearNeedsLayout()

    func clearNeedsDisplay()

    func setNeedsDisplay()

    func setNeedsDisplay(_ rect: Rect)

    // MARK: Layout events

    /// Called when the window is updating its layout after a call to
    /// `setNeedsLayout()` has been made recently.
    func onLayout()

    // MARK: Window events

    /// Called when the window has received a `WM_DESTROY` message.
    func onClose(_ event: EventType)

    /// Called when the window has received a a `WM_PAINT` message.
    func onPaint(_ event: EventType)

    /// Called when the window has received a `WM_SIZE` message.
    func onResize(_ event: EventType)

    /// Called when the DPI settings for the display the window is hosted on
    /// changes.
    func onDPIChanged(_ event: EventType)

    // MARK: Mouse events

    /// Called when the mouse leaves the client area of this window.
    func onMouseLeave(_ event: EventType)

    /// Called when the mouse hovers on top of the client area of this window
    /// within a small rectangle for a period of time.
    func onMouseHover(_ event: EventType)

    /// Called when the mouse moves within the client area of this window.
    func onMouseMove(_ event: EventType) -> EventResult?

    /// Called when the mouse scrolls within the client area of this window.
    func onMouseWheel(_ event: EventType) -> EventResult?

    /// Called when the mouse scrolls in the horizontal direction within the
    /// client area of this window.
    func onMouseHWheel(_ event: EventType) -> EventResult?

    /// Called when the user presses down the left mouse button within the client
    /// area of this window.
    func onLeftMouseDown(_ event: EventType) -> EventResult?

    /// Called when the user presses down the middle mouse button within the client
    /// area of this window.
    func onMiddleMouseDown(_ event: EventType) -> EventResult?

    /// Called when the user presses down the right mouse button within the client
    /// area of this window.
    func onRightMouseDown(_ event: EventType) -> EventResult?

    /// Called when the user releases the left mouse button within the client
    /// area of this window.
    func onLeftMouseUp(_ event: EventType) -> EventResult?

    /// Called when the user releases the middle mouse button within the client
    /// area of this window.
    func onMiddleMouseUp(_ event: EventType) -> EventResult?

    /// Called when the user releases the right mouse button within the client
    /// area of this window.
    func onRightMouseUp(_ event: EventType) -> EventResult?

    // MARK: Keyboard events

    /// Called when the user presses a keyboard key while this window has focus.
    func onKeyDown(_ event: EventType) -> EventResult?

    /// Called when the user releases a keyboard key while this window has focus.
    func onKeyUp(_ event: EventType) -> EventResult?

    /// > Posted to the window with the keyboard focus when the user presses the
    /// > F10 key (which activates the menu bar) or holds down the ALT key and
    /// > then presses another key.
    ///
    /// > It also occurs when no window currently has
    /// > the keyboard focus; in this case, the WM_SYSKEYDOWN message is sent to
    /// > the active window. The window that receives the message can distinguish
    /// > between these two contexts by checking the context code in the lParam
    /// > parameter.
    func onSystemKeyDown(_ event: EventType) -> EventResult?

    /// "Posted to the window with the keyboard focus when the user releases a
    /// key that was pressed while the ALT key was held down."
    ///
    /// "It also occurs when no window currently has the keyboard focus; in this
    /// case, the WM_SYSKEYUP message is sent to the active window. The window
    /// that receives the message can distinguish between these two contexts by
    /// checking the context code in the lParam parameter."
    func onSystemKeyUp(_ event: EventType) -> EventResult?

    /// Called when the user presses a keyboard key while this window has focus.
    func onKeyCharDown(_ event: EventType) -> EventResult?

    /// Called when the user presses a keyboard key of a representable character
    /// while this window has focus.
    func onKeyChar(_ event: EventType) -> EventResult?

    /// Called when the user presses a keyboard key of a representable "dead"
    /// character while this window has focus.
    ///
    /// > A dead key is a key that generates a character, such as the umlaut
    /// > (double-dot), that is combined with another character to form a composite
    /// > character. For example, the umlaut-O character ( ) is generated by typing
    /// > the dead key for the umlaut character, and then typing the O key.
    func onKeyDeadChar(_ event: EventType) -> EventResult?
}
