import Foundation
import CX11
import MinX11
import Blend2DRenderer
import ImagineUI

public class Blend2DWindow: X11Window {
    private var keyboardManager: X11KeyboardManager?
    private var buffer: Blend2DX11DoubleBuffer?
    private var gc: GC?
    private var isMouseHidden = false

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

        var color: XColor = .init()
        color.red = 32000
        color.flags = CChar(truncatingIfNeeded: DoRed)
        XAllocColor(display, colorMap, &color)
        XSetForeground(display, gc, color.pixel)

        buffer = .init(
            contentSize: contentSize.asBLSizeI,
            format: .xrgb32,
            display: display,
            vinfo: visualInfo,
            scale: content.preferredRenderScale
        )

        setNeedsDisplay()
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

    public override func onDPIChanged(_ event: XConfigureEvent) {
        super.onDPIChanged(event)

        resizeApp()

        X11Logger.info("DPI for window changed: \(dpi), new sizes: contentSize: \(contentSize), scaledContentSize: \(scaledContentSize)")
    }

    public override func onCreate(_ event: XConfigureEvent) {
        super.onCreate(event)

        resizeApp()
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
        defer {
            // Only clear needsDisplay flag when last expose event is received.
            if event.count == 0 {
                clearNeedsDisplay()
            }
        }

        let uiRect = UIRectangle(
            x: Double(event.x),
            y: Double(event.y),
            width: Double(event.width),
            height: Double(event.height)
        )

        _internalRedraw(uiRect: uiRect)
    }

    public override func coalescedRedrawRegion(_ rects: [Rect]) -> [Rect] {
        let region = UIRegion(rectangles: rects.map(\.asUIRectangle))

        return region.allRectangles().map({ $0.inflatedBy(x: 5, y: 5) }).map(\.asRect)
    }

    private func _internalRedraw(uiRect: UIRectangle) {
        guard let buffer else {
            return
        }

        buffer.renderingToBuffer { (buffer, scale) in
            paintImmediateBuffer(image: buffer, scale: scale, rect: uiRect)
        }

        let drawTarget = window

        buffer.renderBufferToScreen(display, drawTarget, gc, rect: uiRect, renderingThreads: 4)
    }

    private func paintImmediateBuffer(image: BLImage, scale: UIVector, rect: UIRectangle) {
        let options = BLContext.CreateOptions(threadCount: renderingThreads)
        let ctx = BLContext(image: image, options: options)!

        let clip = UIRegionClipRegion(
            region: .init(
                rectangle: rect.scaled(by: 1 / dpiScalingFactor)
            )
        )

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

        if isMouseHidden {
            XFixesShowCursor(display, window)
            isMouseHidden = false
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

        let location = UIVector(x: Double(event.x), y: Double(event.y))

        let modifiers = keyboardModifiersFromState(event.state)

        var delta: UIVector = .zero
        if event.button == Button4 {
            delta = .init(x: 0, y: 10)
        } else if event.button == Button5 {
            delta = .init(x: 0, y: -10)
        }

        let result = MouseEventArgs(
            location: location / dpiScalingFactor,
            buttons: button,
            delta: delta,
            clicks: 0,
            modifiers: modifiers
        )

        return result
    }

    private func makeMouseEventArgs(
        _ event: XPointerMovedEvent,
        kind: MouseMessageKind,
        button: MouseButton = []
    ) -> MouseEventArgs {

        // TODO: Handle mouse events
        let location = UIVector(x: Double(event.x), y: Double(event.y))

        let buttons = mouseButtonsFromState(event.state)
        let modifiers = keyboardModifiersFromState(event.state)

        let result = MouseEventArgs(
            location: location / dpiScalingFactor,
            buttons: buttons,
            delta: .zero,
            clicks: 0,
            modifiers: modifiers
        )

        return result
    }

    private func mouseButtonsFromState(_ state: UInt32) -> MouseButton {
        let state = Int32(state)

        var buttons: MouseButton = []
        if (state & Button1Mask) == Button1Mask {
            buttons.insert(.left)
        }
        if (state & Button2Mask) == Button2Mask {
            buttons.insert(.middle)
        }
        if (state & Button3Mask) == Button3Mask {
            buttons.insert(.right)
        }

        return buttons
    }

    private func keyboardModifiersFromState(_ state: UInt32) -> KeyboardModifier {
        let state = Int32(state)

        var modifiers: KeyboardModifier = []
        if (state & ShiftMask) == ShiftMask {
            modifiers.insert(.shift)
        }
        if (state & ControlMask) == ControlMask {
            modifiers.insert(.control)
        }
        if (state & Mod1Mask) == Mod1Mask {
            modifiers.insert(.alt)
        }

        return modifiers
    }

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
        onKeyPress event: X11KeyEventArgs
    ) {
        if let keyPress = event.asKeyPressEventArgs {
            content.keyPress(event: keyPress)
        } else {
            content.keyDown(event: event.asKeyEventArgs)
        }
    }

    public func keyboardManager(
        _ manager: X11KeyboardManager,
        onKeyRelease event: X11KeyEventArgs
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
            .roundedToLargest()

        setNeedsDisplay(screenBounds.asRect)
    }

    public func setMouseCursor(
        _ content: ImagineUIContentType,
        cursor: MouseCursorKind
    ) {

        var xCursor: Cursor?

        switch cursor {
        case .arrow:
            xCursor = XCreateFontCursor(display, UInt32(XC_arrow))

        case .iBeam:
            xCursor = XCreateFontCursor(display, UInt32(XC_xterm))

        case .resizeUpDown:
            xCursor = XCreateFontCursor(display, UInt32(XC_sb_v_double_arrow))

        case .resizeLeftRight:
            xCursor = XCreateFontCursor(display, UInt32(XC_sb_h_double_arrow))

        case .resizeTopLeftBottomRight:
            xCursor = XCreateFontCursor(display, UInt32(XC_top_left_corner))

        case .resizeTopRightBottomLeft:
            xCursor = XCreateFontCursor(display, UInt32(XC_top_right_corner))

        case .resizeAll:
            xCursor = XCreateFontCursor(display, UInt32(XC_fleur))

        case .custom(let imagePath, let hotspot):
            // TODO: Implement custom cursor
            break
        }

        if let xCursor = xCursor {
            XDefineCursor(display, window, xCursor)
        }
    }

    public func setMouseHiddenUntilMouseMoves(_ content: ImagineUIContentType) {
        if !isMouseHidden {
            XFixesHideCursor(display, window)
        }

        isMouseHidden = true
    }

    public func firstResponderChanged(
        _ content: ImagineUIContentType,
        _ newFirstResponder: KeyboardEventHandler?
    ) {

        if newFirstResponder != nil {
            XSetICFocus(xic)
        }
    }

    public func preferredRenderScaleChanged(
        _ content: ImagineUIContentType,
        renderScale: UIVector
    ) {

        recreateBuffers()
    }

    public func windowDpiScalingFactor(_ content: ImagineUIContentType) -> Double {
        return dpiScalingFactor
    }
}
