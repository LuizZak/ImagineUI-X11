
// MARK: Type defs

public struct Point {
    public static let zero: Self = .init(x: 0, y: 0)

    public var x: Int
    public var y: Int

    @_transparent
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

public struct Size {
    public static let zero: Self = .init(width: 0, height: 0)

    public var width: Int
    public var height: Int

    @_transparent
    public init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
}

public struct Rect {
    public var origin: Point
    public var size: Size

    @_transparent
    public init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
}
