import Foundation
import CX11
import MinX11
import Blend2DRenderer
import ImagineUI

public class Blend2DWindow: X11Window {
    private var keyboardManager: X11KeyboardManager?
    private var buffer: Blend2DX11DoubleBuffer?
    private var gc: GC?

    /// Returns the computed size for `content`, based on the window's scale
    /// divided by `dpiScalingFactor`.
    var scaledContentSize: UIIntSize {
        size.asUIIntSize.scaled(by: 1.0 / dpiScalingFactor)
    }

    /// Content size, equal to this window's size scaled by the current
    /// `dpiScalingFactor` value.
    var contentSize: UIIntSize {
        size.asUIIntSize.scaled(by: dpiScalingFactor)
    }

    /// Number of rendering threads to use in Blend2D during rendering.
    /// A value of 0 specifies synchronous rendering with no threading.
    public var renderingThreads: UInt32 = 0

    /// Rate of update calls per second.
    /// Affects how much the content.update() function is called each second.
    public var updateRate: Double = 60

    public let updateStopwatch = Stopwatch.start()
    public let content: ImagineUIContentType

    /// Event raised when the window has been closed.
    @EventWithSender<Blend2DWindow, Void>
    public var closed

    public init(settings: CreationSettings, content: ImagineUIContentType) {
        self.content = content

        super.init(settings: settings)
    }

    public override func initialize() {
        super.initialize()

        initializeClipboard()
        initializeKeyboardManager()
        initializeContent()

        recreateBuffers()
    }

    private func initializeKeyboardManager() {
        keyboardManager = X11KeyboardManager(xic: xic)
        keyboardManager?.delegate = self
    }

    private func initializeClipboard() {
        globalTextClipboard = X11TextClipboard()
    }

    private func initializeContent() {
        content.delegate = self
    }

    private func resizeApp() {
        content.resize(scaledContentSize)

        recreateBuffers()

        setNeedsDisplay()
    }

    private func recreateBuffers() {
        buffer = nil

        guard contentSize > .zero else {
            return
        }

        if let gc {
            XFreeGC(display, gc)
        }

        gc = XCreateGC(display, window, 0, nil)
        buffer = .init(
            contentSize: contentSize.asBLSizeI,
            format: .xrgb32,
            display: display,
            vinfo: visualInfo,
            scale: content.preferredRenderScale
        )
    }

    // MARK: Events

    public override func onLayout() {
        super.onLayout()

        content.performLayout()
    }

    public override func onResize(_ event: XConfigureEvent) {
        super.onResize(event)

        resizeApp()
    }

    public override func onDPIChanged(_ event: XEvent) {
        super.onDPIChanged(event)

        resizeApp()

        X11Logger.info("DPI for window changed: \(dpi), new sizes: contentSize: \(contentSize), scaledContentSize: \(scaledContentSize)")
    }

    public override func onClose(_ event: XDestroyWindowEvent) {
        super.onClose(event)

        X11Logger.info("\(self): Closed")
        _closed.publishEvent(sender: self)
        content.didCloseWindow()
    }

    public override func onPaint(_ event: XExposeEvent) {
        guard needsDisplay else {
            return
        }
        defer { clearNeedsDisplay() }

        guard let buffer else {
            return
        }

        let uiRect = UIRectangle(
            x: Double(event.x),
            y: Double(event.y),
            width: Double(event.width),
            height: Double(event.height)
        ).scaled(by: 1 / dpiScalingFactor)

        buffer.renderingToBuffer { (buffer, scale) in
            paintImmediateBuffer(image: buffer, scale: scale, rect: uiRect)
        }

        buffer.renderBufferToScreen(display, window, gc, rect: uiRect, renderingThreads: 4)
    }

    private func paintImmediateBuffer(image: BLImage, scale: UIVector, rect: UIRectangle) {
        let options = BLContext.CreateOptions(threadCount: renderingThreads)
        let ctx = BLContext(image: image, options: options)!

        let clip = UIRegionClipRegion(region: .init(rectangle: rect))

        let renderer = Blend2DRenderer(context: ctx)

        content.render(renderer: renderer, renderScale: scale * dpiScalingFactor, clipRegion: clip)

        ctx.flush(flags: .sync)
        ctx.end()
    }

    // MARK: Mouse Events

    public override func onMouseLeave(_ event: XLeaveWindowEvent) {
        defer {
            content.mouseLeave()
        }

        super.onMouseLeave(event)
    }

    public override func onMouseMove(_ event: XPointerMovedEvent) -> EventResult? {
        defer {
            let event = makeMouseEventArgs(event, kind: .other)
            content.mouseMoved(event: event)
        }

        return super.onMouseMove(event)
    }

    public override func onMouseWheel(_ event: XButtonPressedEvent) -> EventResult? {
        defer {
            let event = makeMouseEventArgs(event, kind: .mouseWheel)
            content.mouseScroll(event: event)
        }

        return super.onMouseWheel(event)
    }

    public override func onMouseHWheel(_ event: XButtonPressedEvent) -> EventResult? {
        defer {
            let event = makeMouseEventArgs(event, kind: .mouseHWheel)
            content.mouseScroll(event: event)
        }

        return super.onMouseHWheel(event)
    }

    public override func onLeftMouseDown(_ event: XButtonPressedEvent) -> EventResult? {
        defer {
            let event = makeMouseEventArgs(event, kind: .other, button: .left)
            content.mouseDown(event: event)
        }

        return super.onLeftMouseDown(event)
    }

    public override func onMiddleMouseDown(_ event: XButtonPressedEvent) -> EventResult? {
        defer {
            let event = makeMouseEventArgs(event, kind: .other, button: .middle)
            content.mouseDown(event: event)
        }

        return super.onMiddleMouseDown(event)
    }

    public override func onRightMouseDown(_ event: XButtonPressedEvent) -> EventResult? {
        defer {
            let event = makeMouseEventArgs(event, kind: .other, button: .right)
            content.mouseDown(event: event)
        }

        return super.onRightMouseDown(event)
    }

    public override func onLeftMouseUp(_ event: XButtonReleasedEvent) -> EventResult? {
        defer {
            let event = makeMouseEventArgs(event, kind: .other, button: .left)
            content.mouseUp(event: event)
        }

        return super.onLeftMouseUp(event)
    }

    public override func onMiddleMouseUp(_ event: XButtonReleasedEvent) -> EventResult? {
        defer {
            let event = makeMouseEventArgs(event, kind: .other, button: .middle)
            content.mouseUp(event: event)
        }

        return super.onMiddleMouseUp(event)
    }

    public override func onRightMouseUp(_ event: XButtonReleasedEvent) -> EventResult? {
        defer {
            let event = makeMouseEventArgs(event, kind: .other, button: .right)
            content.mouseUp(event: event)
        }

        return super.onRightMouseUp(event)
    }

    // MARK: Keyboard events

    public override func onKeyDown(_ event: XKeyPressedEvent) -> EventResult? {
        guard let keyboardManager = keyboardManager else {
            return super.onKeyDown(event)
        }

        return keyboardManager.onKeyPress(event)
    }

   public  override func onKeyUp(_ event: XKeyReleasedEvent) -> EventResult? {
        guard let keyboardManager = keyboardManager else {
            return super.onKeyUp(event)
        }

        return keyboardManager.onKeyRelease(event)
    }

    // MARK: Message translation

    private func makeMouseEventArgs(
        _ event: XButtonPressedEvent,
        kind: MouseMessageKind,
        button: MouseButton = []
    ) -> MouseEventArgs {
        // TODO: Handle mouse events

        let result = MouseEventArgs(
            location: .zero,
            buttons: .none,
            delta: .zero,
            clicks: 0,
            modifiers: []
        )

        return result
    }

    private func makeMouseEventArgs(
        _ event: XPointerMovedEvent,
        kind: MouseMessageKind,
        button: MouseButton = []
    ) -> MouseEventArgs {
        // TODO: Handle mouse events

        let result = MouseEventArgs(
            location: .zero,
            buttons: .none,
            delta: .zero,
            clicks: 0,
            modifiers: []
        )

        return result
    }

    /*
    private func makeMouseEventArgs(
        _ event: XEvent,
        kind: MouseMessageKind,
        button: MouseButton = []
    ) -> MouseEventArgs {

        var x = GET_X_LPARAM(message.lParam)
        var y = GET_Y_LPARAM(message.lParam)

        // Mouse wheel events receive screen space coordinates instead of client
        // space, so we need to convert to client space before proceeding.
        if kind.isWheelMessage {
            var point = POINT(x: LONG(x), y: LONG(y))
            ScreenToClient(hwnd, &point)
            x = Int16(point.x)
            y = Int16(point.y)
        }

        let location = UIVector(x: Double(x), y: Double(y)) / dpiScalingFactor
        var buttons: MouseButton = button
        var modifiers: KeyboardModifier = []
        var delta = UIVector.zero

        // Extract mouse wheel scroll and virtual key parameters
        let keyParam: WPARAM
        if kind.isWheelMessage {
            // TODO: Expose this property for customization.
            let wheelMultiplier = 5.0

            let amount = Double(Int32(GET_WHEEL_DELTA_WPARAM(message.wParam)) / WHEEL_DELTA) * wheelMultiplier

            switch kind {
            case .mouseWheel:
                delta.y = amount
            case .mouseHWheel:
                delta.x = amount
            case .other:
                break
            }

            keyParam = WPARAM(GET_KEYSTATE_WPARAM(message.wParam))
        } else {
            keyParam = WPARAM(message.wParam)
        }

        // Buttons
        if IS_BIT_ON(keyParam, MK_LBUTTON) {
            buttons.insert(.left)
        }
        if IS_BIT_ON(keyParam, MK_MBUTTON) {
            buttons.insert(.middle)
        }
        if IS_BIT_ON(keyParam, MK_RBUTTON) {
            buttons.insert(.right)
        }

        // Modifiers
        if IS_BIT_ON(keyParam, MK_CONTROL) {
            modifiers.insert(.control)
        }
        if IS_BIT_ON(keyParam, MK_SHIFT) {
            modifiers.insert(.shift)
        }

        let event = MouseEventArgs(
            location: location,
            buttons: buttons,
            delta: delta,
            clicks: 0,
            modifiers: modifiers
        )

        return event
    }
    */

    private enum MouseMessageKind {
        /// WM_MOUSEWHEEL message.
        case mouseWheel

        /// WM_MOUSEHWHEEL message.
        case mouseHWheel

        /// Any other mouse message.
        case other

        var isWheelMessage: Bool {
            switch self {
            case .mouseWheel, .mouseHWheel:
                return true
            case .other:
                return false
            }
        }
    }
}

extension Blend2DWindow: X11KeyboardManagerDelegate {
    public func keyboardManager(
        _ manager: X11KeyboardManager,
        onKeyRelease event: X11KeyEventArgs
    ) {
        content.keyDown(event: event.asKeyEventArgs)
    }

    public func keyboardManager(
        _ manager: X11KeyboardManager,
        onKeyPress event: X11KeyEventArgs
    ) {
        content.keyUp(event: event.asKeyEventArgs)
    }
}

extension Blend2DWindow: ImagineUIContentDelegate {
    public func needsLayout(_ content: ImagineUIContentType, _ view: View) {
        setNeedsLayout()
    }

    public func invalidate(_ content: ImagineUIContentType, bounds: UIRectangle) {
        assert(!bounds.x.isNaN, "!bounds.x.isNaN")
        assert(!bounds.y.isNaN, "!bounds.y.isNaN")
        assert(!bounds.width.isNaN, "!bounds.width.isNaN")
        assert(!bounds.height.isNaN, "!bounds.height.isNaN")

        let screenBounds = bounds
            .inflatedBy(.init(repeating: 3.0))
            .scaled(by: dpiScalingFactor)
            .roundedToLargest()

        setNeedsDisplay(screenBounds.asRect)
    }

    public func setMouseCursor(
        _ content: ImagineUIContentType,
        cursor: MouseCursorKind
    ) {

            /*!SECTION
        var hCursor: HCURSOR?

        // TODO: Implement cursor change
        switch cursor {
        case .arrow:
            hCursor = LoadCursorW(nil, IDC_ARROW)

        case .iBeam:
            hCursor = LoadCursorW(nil, IDC_IBEAM)

        case .resizeUpDown:
            hCursor = LoadCursorW(nil, IDC_SIZENS)

        case .resizeLeftRight:
            hCursor = LoadCursorW(nil, IDC_SIZEWE)

        case .resizeTopLeftBottomRight:
            hCursor = LoadCursorW(nil, IDC_SIZENWSE)

        case .resizeTopRightBottomLeft:
            hCursor = LoadCursorW(nil, IDC_SIZENESW)

        case .resizeAll:
            hCursor = LoadCursorW(nil, IDC_SIZEALL)

        case .custom(let imagePath, let hotspot):
            // TODO: Implement custom cursor

            break
        }

        if let hCursor = hCursor {
            SetCursor(hCursor)
            SetClassLongPtrW(hwnd, GCLP_HCURSOR, hCursorToLONG_PTR(hCursor))
        }
        */
    }

    public func setMouseHiddenUntilMouseMoves(_ content: ImagineUIContentType) {
        // TODO: Implement cursor hiding
    }

    public func firstResponderChanged(
        _ content: ImagineUIContentType,
        _ newFirstResponder: KeyboardEventHandler?
    ) {

        if newFirstResponder != nil {
            //SetFocus(hwnd)
            XSetICFocus(xic)
        }
    }

    public func preferredRenderScaleChanged(
        _ content: ImagineUIContentType,
        renderScale: UIVector
    ) {

        recreateBuffers()
        setNeedsDisplay()
    }

    public func windowDpiScalingFactor(_ content: ImagineUIContentType) -> Double {
        return dpiScalingFactor
    }
}
