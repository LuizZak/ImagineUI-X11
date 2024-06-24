
// MARK: Type defs

public struct Point: CustomStringConvertible {
    public static let zero: Self = .init(x: 0, y: 0)

    public var x: Int
    public var y: Int

    public var description: String {
        "Point(x: \(x), y: \(y))"
    }

    @_transparent
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    @_transparent
    func scaled(
        byX factorX: Double,
        y factorY: Double,
        roundingRule: FloatingPointRoundingRule = .toNearestOrAwayFromZero
    ) -> Self {

        let x = Int((Double(x) * factorX).rounded(roundingRule))
        let y = Int((Double(y) * factorY).rounded(roundingRule))

        return .init(x: x, y: y)
    }

    @_transparent
    func scaled(
        by factor: Double,
        roundingRule: FloatingPointRoundingRule = .toNearestOrAwayFromZero
    ) -> Self {

        scaled(byX: factor, y: factor, roundingRule: roundingRule)
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

    @_transparent
    func scaled(
        byX factorX: Double,
        y factorY: Double,
        roundingRule: FloatingPointRoundingRule = .toNearestOrAwayFromZero
    ) -> Self {

        let width = Int((Double(width) * factorX).rounded(roundingRule))
        let height = Int((Double(height) * factorY).rounded(roundingRule))

        return .init(width: width, height: height)
    }

    @_transparent
    func scaled(
        by factor: Double,
        roundingRule: FloatingPointRoundingRule = .toNearestOrAwayFromZero
    ) -> Self {

        scaled(byX: factor, y: factor, roundingRule: roundingRule)
    }
}

public struct Rect {
    public var origin: Point
    public var size: Size

    var left: Int {
        origin.x
    }
    var top: Int {
        origin.y
    }
    var right: Int {
        origin.x + size.width
    }
    var bottom: Int {
        origin.y + size.height
    }

    @_transparent
    public init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }

    @_transparent
    public init(left: Int, top: Int, right: Int, bottom: Int) {
        self.origin = .init(x: left, y: top)
        self.size = .init(width: right - left, height: bottom - top)
    }

    func union(_ other: Self) -> Self {
        let left = min(self.left, other.left)
        let top = min(self.top, other.top)
        let right = max(self.right, other.right)
        let bottom = max(self.bottom, other.bottom)

        return .init(left: left, top: top, right: right, bottom: bottom)
    }

    @_transparent
    func scaled(
        byX factorX: Double,
        y factorY: Double,
        roundingRule: FloatingPointRoundingRule = .toNearestOrAwayFromZero
    ) -> Self {

        let origin = origin.scaled(byX: factorX, y: factorY, roundingRule: roundingRule)
        let size = size.scaled(byX: factorX, y: factorY, roundingRule: roundingRule)

        return .init(origin: origin, size: size)
    }

    @_transparent
    func scaled(
        by factor: Double,
        roundingRule: FloatingPointRoundingRule = .toNearestOrAwayFromZero
    ) -> Self {

        scaled(byX: factor, y: factor, roundingRule: roundingRule)
    }
}
