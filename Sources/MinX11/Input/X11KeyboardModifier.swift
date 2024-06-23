public struct X11KeyboardModifier: OptionSet {
    public var rawValue: Int

    @_transparent
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let none = Self([])
    public static let shift = Self(rawValue: 0b1)
    public static let control = Self(rawValue: 0b10)
    public static let alt = Self(rawValue: 0b100)
}
