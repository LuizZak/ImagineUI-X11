import MinX11
import ImagineUI
import Blend2DRenderer

// MARK: ImagineUI <-> App Conversions

extension UIRectangle {
    @_transparent
    var asRect: Rect {
        let origin = Point(x: Int(self.x), y: Int(self.y))
        let size = Size(width: Int(self.width),
                        height: Int(self.height))

        return .init(origin: origin, size: size)
    }
}

extension BLPoint {
    @_transparent
    var asUIPoint: UIPoint {
        UIPoint(x: x, y: y)
    }

    @_transparent
    var asUIVector: UIVector {
        UIVector(x: x, y: y)
    }
}

extension UIIntSize {
    @_transparent
    var asSize: Size {
        Size(width: width, height: height)
    }

    @_transparent
    var asBLSizeI: BLSizeI {
        BLSizeI(w: Int32(width), h: Int32(height))
    }
}

extension Size {
    @_transparent
    var asUIIntSize: UIIntSize {
        .init(width: width, height: height)
    }

    @_transparent
    var asUISize: UISize {
        .init(width: Double(width), height: Double(height))
    }

    @_transparent
    var asBLPoint: BLPoint {
        .init(x: Double(width), y: Double(height))
    }

    @_transparent
    var asBLPointI: BLPointI {
        .init(x: Int32(width), y: Int32(height))
    }

    @_transparent
    var asBLSize: BLSize {
        .init(w: Double(width), h: Double(height))
    }

    @_transparent
    var asBLSizeI: BLSizeI {
        .init(w: Int32(width), h: Int32(height))
    }
}
