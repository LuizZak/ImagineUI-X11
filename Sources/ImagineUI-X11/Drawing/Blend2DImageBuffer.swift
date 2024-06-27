import Foundation
import CX11
import SwiftBlend2D

private let useXShm = false

class Blend2DImageBuffer {
    private let _display: UnsafeMutablePointer<Display>
    private let _shmInfo: UnsafeMutablePointer<XShmSegmentInfo>?

    let image: UnsafeMutablePointer<XImage>
    let buffer: UnsafeMutablePointer<CChar>
    let blImage: BLImage

    init(
        size: BLSizeI,
        display: UnsafeMutablePointer<Display>,
        vinfo: XVisualInfo?
    ) {
        _display = display

        precondition(size.w > 0 && size.h > 0, "size.w > 0 && size.h > 0")

        let bpp = 4
        let depth: Int32 = 32
        let stride = bpp * Int(size.w)

        if useXShm {
            let shmInfo: UnsafeMutablePointer<XShmSegmentInfo> = .allocate(capacity: 1)
            var _shmInfo: XShmSegmentInfo {
                get { shmInfo.pointee }
                set { shmInfo.pointee = newValue }
            }
            _shmInfo = .init()

            image = XShmCreateImage(
                display,
                vinfo?.visual,
                UInt32(vinfo?.depth ?? depth),
                ZPixmap,
                nil,
                shmInfo,
                UInt32(size.w),
                UInt32(size.h)
            )

            let allocSize = Int(image.pointee.bytes_per_line * image.pointee.height)
            _shmInfo.shmid = shmget(IPC_PRIVATE, allocSize, IPC_CREAT | 0o777)
            if _shmInfo.shmid == -1 {
                fatalError("Error trying to create image with Xlib shared memory extension.")
            }

            _shmInfo.shmaddr = shmat(_shmInfo.shmid, nil, 0)?.assumingMemoryBound(to: CChar.self)
            if _shmInfo.shmaddr == nil {
                fatalError("Error trying to create image with Xlib shared memory extension.")
            }

            image.pointee.data = _shmInfo.shmaddr
            buffer = _shmInfo.shmaddr
            _shmInfo.readOnly = 0

            XShmAttach(display, shmInfo)

            blImage = BLImage(
                fromUnownedData: _shmInfo.shmaddr,
                stride: stride,
                width: Int(size.w),
                height: Int(size.h),
                format: .xrgb32
            )

            self._shmInfo = shmInfo
        } else {
            self._shmInfo = nil

            let bufferLength = Int(size.w * size.h) * bpp
            buffer = .allocate(capacity: bufferLength)

            blImage = BLImage(
                fromUnownedData: buffer,
                stride: stride,
                width: Int(size.w),
                height: Int(size.h),
                format: .xrgb32
            )

            image = XCreateImage(
                display,
                vinfo?.visual,
                UInt32(vinfo?.depth ?? depth),
                ZPixmap,
                0,
                buffer,
                UInt32(size.w),
                UInt32(size.h),
                32,
                0
            )
        }
    }

    deinit {
        buffer.deallocate()

        if let _shmInfo {
            XShmDetach(_display, _shmInfo)
            shmdt(_shmInfo.pointee.shmaddr)
            shmctl(_shmInfo.pointee.shmid, IPC_RMID, nil)
        }
    }

    func pushPixelsToScreen(
        _ display: UnsafeMutablePointer<Display>!,
        _ drawable: Drawable,
        _ GC: GC!,
        rect: BLRectI
    ) {
        let w = rect.right - rect.left
        let h = rect.bottom - rect.top

        if useXShm {
            XShmPutImage(
                display,
                drawable,
                GC,
                image,
                rect.x,
                rect.y,
                rect.x,
                rect.y,
                UInt32(w),
                UInt32(h),
                1
            )
        } else {
            XPutImage(
                display,
                drawable,
                GC,
                image,
                rect.x,
                rect.y,
                rect.x,
                rect.y,
                UInt32(w),
                UInt32(h)
            )
        }
    }
}
