public struct X11KeyEventArgs {
    public var keyCode: X11Keys
    public var keyChar: String?
    public var modifiers: X11KeyboardModifier

    @_transparent
    public init(keyCode: X11Keys, keyChar: String?, modifiers: X11KeyboardModifier) {
        self.keyCode = keyCode
        self.keyChar = keyChar
        self.modifiers = modifiers
    }
}
