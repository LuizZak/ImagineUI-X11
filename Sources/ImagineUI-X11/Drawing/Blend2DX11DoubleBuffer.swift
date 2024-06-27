import CX11
import SwiftBlend2D
import ImagineUI

class Blend2DX11DoubleBuffer {
    private(set) internal var contentSize: BLSizeI
    private var scale: UIVector
    private let format: BLFormat
    private let useXShm: Bool

    private var buffer: BufferKind

    /// - precondition: contentSize.w > 0 && contentSize.h > 0 && scale > .zero
    init(
        contentSize: BLSizeI,
        format: BLFormat,
        display: UnsafeMutablePointer<Display>,
        vinfo: XVisualInfo?,
        useXShm: Bool,
        scale: UIVector = .init(repeating: 1)
    ) {

        precondition(contentSize.w > 0 && contentSize.h > 0 && scale > .zero)
        self.contentSize = contentSize
        self.scale = scale
        self.format = format
        self.useXShm = useXShm
        self.buffer = .makeBuffer(
            useXShm: useXShm,
            size: contentSize,
            format: format,
            scale: scale,
            display: display,
            vinfo: vinfo
        )
    }

    /// - precondition: scale > .zero
    func setPrimaryBufferScale(_ scale: UIVector) {
        precondition(scale > .zero)
        self.scale = scale
    }

    /// - precondition: `primary > .zero && scale > .zero`
    func resizeBuffer(
        primary: BLSizeI,
        scale: UIVector,
        display: UnsafeMutablePointer<Display>,
        vinfo: XVisualInfo?
    ) {
        guard contentSize != primary || self.scale != scale else { return }

        buffer = .makeBuffer(
            useXShm: useXShm,
            size: primary,
            format: format,
            scale: scale,
            display: display,
            vinfo: vinfo
        )
    }

    func renderingToBuffer(_ block: (BLImage, _ renderScale: UIVector) -> Void) {
        block(buffer.immediateBuffer, scale)
    }

    func renderBufferToScreen(
        _ display: UnsafeMutablePointer<Display>!,
        _ drawable: Drawable,
        _ GC: GC!,
        rect: UIRectangle?,
        renderingThreads: UInt32
    ) {
        renderBufferToScreen(
            display,
            drawable,
            GC,
            rect: (rect?.asBLRect).map(BLRectI.init(rounding:)),
            renderingThreads: renderingThreads
        )
    }

    func renderBufferToScreen(
        _ display: UnsafeMutablePointer<Display>!,
        _ drawable: Drawable,
        _ GC: GC!,
        rect: BLRectI? = nil,
        renderingThreads: UInt32
    ) {

        let screenBuffer = buffer.screenBuffer

        let rect = rect ?? BLRectI(
            location: .zero,
            size: screenBuffer.blImage.size
        )

        buffer.pushPixelsToScreenBuffer(rect: rect, renderingThreads: renderingThreads)
        buffer.pushPixelsToScreen(display, drawable, GC, rect: rect)
    }
}

private enum BufferKind {
    case singleBuffer(Blend2DImageBuffer)
    case doubleBuffer(primaryBuffer: BLImage, primaryBufferScale: UIVector, secondaryBuffer: Blend2DImageBuffer)

    var immediateBuffer: BLImage {
        switch self {
        case .singleBuffer(let buffer):
            return buffer.blImage

        case .doubleBuffer(let primaryBuffer, _, _):
            return primaryBuffer
        }
    }

    var screenBuffer: Blend2DImageBuffer {
        switch self {
        case .singleBuffer(let b),
             .doubleBuffer(_, _, let b):
            return b
        }
    }

    func pushPixelsToScreenBuffer(
        rect: BLRectI,
        renderingThreads: UInt32
    ) {
        switch self {
        case .singleBuffer:
            break

        case .doubleBuffer(let primaryBuffer, let primaryBufferScale, let secondaryBuffer):
            let options = BLContext.CreateOptions(threadCount: renderingThreads)
            let ctx = BLContext(image: secondaryBuffer.blImage, options: options)!

            ctx.clipToRect(rect)

            let sizeI = primaryBuffer.size.scaled(by: 1 / primaryBufferScale)
            let size = BLSize(w: Double(sizeI.w), h: Double(sizeI.h))
            ctx.blitScaledImage(primaryBuffer, rectangle: BLRect(location: .zero, size: size))

            ctx.flush(flags: .sync)
            ctx.end()
        }
    }

    func pushPixelsToScreen(
        _ display: UnsafeMutablePointer<Display>!,
        _ drawable: Drawable,
        _ GC: GC!,
        rect: BLRectI
    ) {
        screenBuffer.pushPixelsToScreen(display, drawable, GC, rect: rect)
    }

    static func makeBuffer(
        useXShm: Bool,
        size: BLSizeI,
        format: BLFormat,
        scale: UIVector,
        display: UnsafeMutablePointer<Display>,
        vinfo: XVisualInfo?
    ) -> Self {

        let secondary = Blend2DImageBuffer(
            useXShm: useXShm,
            size: size,
            display: display,
            vinfo: vinfo
        )

        if scale == 1.0 {
            return .singleBuffer(secondary)
        } else {
            let primary = BLImage(size: size.scaled(by: scale), format: format)
            return .doubleBuffer(
                primaryBuffer: primary,
                primaryBufferScale: scale,
                secondaryBuffer: secondary
            )
        }
    }
}
