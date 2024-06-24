import Foundation
import ImagineUI
import CX11
import MinX11

public class ImagineUIApp {
    var delegate: ImagineUIAppDelegate
    var eventLoop: X11EventLoop

    public init(delegate: ImagineUIAppDelegate) {
        self.delegate = delegate
        eventLoop = X11EventLoop()
    }

    /// Dispatches a closure to perform on the main thread queue.
    public func dispatchMain(_ block: @escaping () -> Void) {
        RunLoop.main.perform {
            block()
        }
    }

    /// Opens a window to show a given content.
    public func show(content: ImagineUIContentType) {
        let settings = X11Window.CreationSettings(
            title: "ImagineUI-X11 Sample Window",
            size: content.size.asSize,
            display: eventLoop.display
        )
        let window = Blend2DWindow(settings: settings, content: content)

        window.show()
    }

    /// Marks the program as finished executing and quits.
    /// The program is not quit immediately, and may still process events after
    /// the quit request before closing.
    public func requestQuit() {
        X11Logger.info("Application requested termination.")

        eventLoop.requestEnd()
    }

    /// Initializes the main run loop of the application.
    public func run(settings: ImagineUIAppStartupSettings) throws -> Int32 {
        try UISettings.initialize(
            .init(
                fontManager: settings.fontManager,
                defaultFontPath: settings.defaultFontPath,
                timeInSecondsFunction: { Stopwatch.global.timeIntervalSinceStart() }
            )
        )

        try delegate.appDidLaunch()

        eventLoop.run()

        return 0
    }

    internal func didMoveToForeground() {
        delegate.appDidMoveToForeground()
    }

    internal func didMoveToBackground() {
        delegate.appDidMoveToBackground()
    }
}
