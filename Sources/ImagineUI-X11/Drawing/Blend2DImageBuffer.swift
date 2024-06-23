import CX11
import SwiftBlend2D

class Blend2DImageBuffer {
    let image: UnsafeMutablePointer<XImage>
    let buffer: UnsafeMutableRawPointer
    let blImage: BLImage

    init(
        size: BLSizeI,
        display: UnsafeMutablePointer<Display>,
        vinfo: XVisualInfo?
    ) {
        precondition(size.w > 0 && size.h > 0, "size.w > 0 && size.h > 0")

        let bpp = 4
        let depth = 32
        let stride = bpp * Int(size.w)

        buffer = UnsafeMutableRawPointer.allocate(byteCount: Int(size.w * size.h) * bpp, alignment: 0)
        blImage = BLImage(
            fromUnownedData: buffer,
            stride: stride,
            width: Int(size.w),
            height: Int(size.h),
            format: .xrgb32
        )

        if let vinfo {
            image = XCreateImage(
                display,
                vinfo.visual,
                UInt32(vinfo.depth),
                ZPixmap,
                0,
                buffer.assumingMemoryBound(to: CChar.self),
                UInt32(size.w),
                UInt32(size.h),
                32,
                0
            )
        } else {
            image = XCreateImage(
                display,
                nil,
                UInt32(depth),
                ZPixmap,
                0,
                buffer.assumingMemoryBound(to: CChar.self),
                UInt32(size.w),
                UInt32(size.h),
                32,
                0
            )
        }
    }

    deinit {
        buffer.deallocate()
    }
}
