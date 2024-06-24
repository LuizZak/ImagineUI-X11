import CX11
import Foundation

/// Handles X11 event loops, forwarding display events to windows.
public class X11EventLoop {
    public private(set) var display: UnsafeMutablePointer<Display>
    var isRunning: Bool = true

    public init() {
        // Try to open the display. Calling this without X11 running will fail
        guard let d = XOpenDisplay(nil) else {
            fatalError("Failed to open display")
        }

        display = d
    }

    /// Runs the main event loop.
    /// Blocks the caller thread until `X11EventLoop.requestEnd()` is called.
    public func run() {
        // The events which X11 generates for us will be stored here
        var e: XEvent = .init()

        while isRunning {
            while XPending(display) > 0 {
                // Wait for the next event
                XNextEvent(display, &e)

                // Find window to forward event to
                let windows = X11Window.openWindows
                for window in windows {
                    if window.window == e.xany.window {
                        window.handleEvent(e)
                    }
                }
            }

            var limitDate: Date? = nil
            repeat {
                // Execute Foundation.RunLoop once and determine the next time
                // the timer fires. At this point handle all Foundation.RunLoop
                // timers, sources and Dispatch.DispatchQueue.main tasks
                limitDate = RunLoop.main.limitDate(forMode: .default)

                // If Foundation.RunLoop doesn't contain any timers or the timers
                // should not be running right now, we interrupt the current loop
                // or otherwise continue to the next iteration.
            } while (limitDate?.timeIntervalSinceNow ?? -1) <= 0

            // Ensure windows are properly invalidated
            for window in X11Window.openWindows {
                window.flushRedisplayAreas()
            }
        }
    }

    /// Requests that the run loop be ended.
    public func requestEnd() {
        guard !isRunning else {
            return
        }

        isRunning = false
    }
}
