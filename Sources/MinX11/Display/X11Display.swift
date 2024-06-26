import Foundation
import CX11

#if false

// Tentative DPI derivation code based on:
// https://stackoverflow.com/a/70827735

/// Returns scaling of the given display, in dots-per-inch (DPI).
func displayScaling(_ display: UnsafeMutablePointer<Display>?) -> Double {
    let screen = XDefaultScreen(display)

    return displayScaling(display, screen: Int(screen))
}

/// Returns scaling of the given display, in dots-per-inch (DPI).
func displayScaling(
    _ display: UnsafeMutablePointer<Display>?,
    screen: Int
) -> Double {

    let width = Double(XDisplayWidth(display, Int32(screen)))
    let widthMM = Double(XDisplayWidthMM(display, Int32(screen)))

    let height = Double(XDisplayHeight(display, Int32(screen)))
    let heightMM = Double(XDisplayHeightMM(display, Int32(screen)))

    /*
     * there are 2.54 centimeters to an inch; so there are 25.4 millimeters.
     *
     *     dpi = N pixels / (M millimeters / (25.4 millimeters / 1 inch))
     *         = N pixels / (M inch / 25.4)
     *         = N * 25.4 pixels / M inch
     */
    let xScale = (width * 25.4) / widthMM + 0.5
    let yScale = (height * 25.4) / heightMM + 0.5

    return (xScale + yScale) / 2
}

#else

// Tentative DPI derivation code based on:
// https://github.com/glfw/glfw/issues/1019#issuecomment-302772498

/// Returns scaling of the given display, in dots-per-inch (DPI).
func displayScaling(_ display: UnsafeMutablePointer<Display>?) -> Double {
    let screen = XDefaultScreen(display)

    return displayScaling(display, screen: Int(screen))
}

/// Returns scaling of the given display, in dots-per-inch (DPI).
func displayScaling(
    _ display: UnsafeMutablePointer<Display>?,
    screen: Int
) -> Double {

    XrmInitialize()

    var dpi: Double = 92.0
    if let resourceString = XResourceManagerString(display) {
        let db = XrmGetStringDatabase(resourceString)

        var type: UnsafeMutablePointer<CChar>?
        var value: XrmValue = .init()
        if XrmGetResource(db, "Xft.dpi", "String", &type, &value) == True {
            dpi = atof(value.addr)
        }
    }

    return dpi
}

#endif
