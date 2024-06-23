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

/*
private let pApplicationStateChangeRoutine: PAPPSTATE_CHANGE_ROUTINE = { (quiesced: UInt8, context: PVOID?) in
    guard let app = unsafeBitCast(context, to: AnyObject.self) as? ImagineUIApp else {
        return
    }

    let foregrounding: Bool = quiesced == 0
    if foregrounding {
        app.didMoveToForeground()
    } else {
        app.didMoveToBackground()
    }
}

// Waits for a message on the message queue, returning when either a message has
// arrived or the timeout specified has expired.
private func WaitMessage(limitDate: Date?) -> Bool {
    guard let limitDate = limitDate else {
        return WaitMessage(.max)
    }
    guard limitDate.timeIntervalSinceNow < Double(DWORD.max) else {
        return WaitMessage(.max)
    }

    let milliseconds = DWORD(limitDate.timeIntervalSinceNow * 1000)
    return WaitMessage(milliseconds)
}

// Waits for a message on the message queue, returning when either a message has
// arrived or the timeout specified has expired.
private func WaitMessage(_ dwMilliseconds: UINT) -> Bool {
    let uIDEvent = WinSDK.SetTimer(nil, 0, dwMilliseconds, nil)
    defer { WinSDK.KillTimer(nil, uIDEvent) }

    return WinSDK.WaitMessage()
}
*/
