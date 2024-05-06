import CX11

/// Handles X11 event loops, forwarding display events to windows.
public class X11EventLoop {
    private(set) public var display: UnsafeMutablePointer<Display>
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
    }

    /// Requests that the run loop be ended.
    public func requestEnd() {
        guard !isRunning else {
            return
        }

        isRunning = false
    }
}
