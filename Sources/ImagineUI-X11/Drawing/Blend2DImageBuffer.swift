import Foundation
import CX11
import SwiftBlend2D

class Blend2DImageBuffer {
    private let _display: UnsafeMutablePointer<Display>
    private let _shmInfo: UnsafeMutablePointer<XShmSegmentInfo>?
    private let _imageRectangle: UIRectangle
    private let useXShm: Bool

    let image: UnsafeMutablePointer<XImage>
    let buffer: UnsafeMutablePointer<CChar>
    let blImage: BLImage

    init(
        useXShm: Bool = true,
        size: BLSizeI,
        display: UnsafeMutablePointer<Display>,
        vinfo: XVisualInfo?
    ) {
        _display = display

        precondition(size.w > 0 && size.h > 0, "size.w > 0 && size.h > 0")

        let bpp = 4
        let depth: Int32 = 32

        _imageRectangle = BLRectI(location: .zero, size: size).asRectangle

        self.useXShm = useXShm

        if useXShm {
            let shmInfo: UnsafeMutablePointer<XShmSegmentInfo> = .allocate(capacity: 1)

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
            shmInfo.pointee.shmid = shmget(IPC_PRIVATE, allocSize, IPC_CREAT | 0o777)
            if shmInfo.pointee.shmid == -1 {
                fatalError("Error trying to create image with Xlib shared memory extension.")
            }

            shmInfo.pointee.shmaddr = shmat(shmInfo.pointee.shmid, nil, 0)?.assumingMemoryBound(to: CChar.self)
            if shmInfo.pointee.shmaddr == .init(bitPattern: -1) {
                fatalError("Error trying to create image with Xlib shared memory extension.")
            }

            image.pointee.data = shmInfo.pointee.shmaddr
            buffer = shmInfo.pointee.shmaddr
            shmInfo.pointee.readOnly = True

            if XShmAttach(display, shmInfo) == 0 {
                fatalError("Failed to create image with Xlib shared memory extension.")
            }

            let stride = image.pointee.bytes_per_line
            blImage = BLImage(
                fromUnownedData: shmInfo.pointee.shmaddr,
                stride: Int(stride),
                width: Int(size.w),
                height: Int(size.h),
                format: .xrgb32
            )

            self._shmInfo = shmInfo
        } else {
            self._shmInfo = nil

            let stride = bpp * Int(size.w)
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
        if let _shmInfo {
            if XShmDetach(_display, _shmInfo) == 0 {
                fatalError("Error detaching from Xlib shared memory segment.")
            }

            // Ensure server detaches before proceeding
            XSync(_display, False)

            XDestroyImage(image)

            if shmdt(_shmInfo.pointee.shmaddr) == -1 {
                fatalError("Error detaching from Xlib shared memory segment.")
            }
            if shmctl(_shmInfo.pointee.shmid, IPC_RMID, nil) == -1 {
                fatalError("Error detaching from Xlib shared memory segment.")
            }

            _shmInfo.deallocate()
        } else {
            XDestroyImage(image)
        }
    }

    func pushPixelsToScreen(
        _ display: UnsafeMutablePointer<Display>!,
        _ drawable: Drawable,
        _ GC: GC!,
        rect: BLRectI
    ) {
        // Ensure the rectangle is within the bounds of the image
        guard let intersection = _imageRectangle.intersection(rect.asRectangle) else {
            return
        }

        let properRect = BLRectI(rounding: intersection.asBLRect)

        if self.useXShm {
            XShmPutImage(
                display,
                drawable,
                GC,
                image,
                properRect.x,
                properRect.y,
                properRect.x,
                properRect.y,
                UInt32(properRect.w),
                UInt32(properRect.h),
                1
            )

            // We have to wait until the server finishes rendering the image first
            XFlush(display)
            var eventType = XShmGetEventBase(display) + ShmCompletion
            var event: XEvent = .init()
            XIfEvent(display, &event, { (display, event, data) in
                return event!.pointee.type == data!.pointee ? True : False
            }, &eventType)
        } else {
            XPutImage(
                display,
                drawable,
                GC,
                image,
                properRect.x,
                properRect.y,
                properRect.x,
                properRect.y,
                UInt32(properRect.w),
                UInt32(properRect.h)
            )
        }
    }
}
