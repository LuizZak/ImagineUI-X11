import Foundation

/// Unix-compatible stopwatch system
public class Stopwatch {
    var start: timespec = timespec()

    /// A global stopwatch that starts counting from the moment this variable is
    /// first accessed.
    public static let global = Stopwatch.start()

    private init() {
        if #available(OSX 10.12, *) {
            clock_gettime(CLOCK_MONOTONIC_RAW, &start)
        } else {
            fatalError()
        }
    }

    public func timeIntervalSinceStart() -> TimeInterval {
        var end: timespec = timespec()
        if #available(OSX 10.12, *) {
            clock_gettime(CLOCK_MONOTONIC_RAW, &end)
        } else {
            fatalError()
        }

        let delta_us = (end.tv_sec - start.tv_sec) * 1000000 + (end.tv_nsec - start.tv_nsec) / 1000

        return TimeInterval(delta_us) / 1_000_000
    }

    public func restart() {
        if #available(OSX 10.12, *) {
            clock_gettime(CLOCK_MONOTONIC_RAW, &start)
        } else {
            fatalError()
        }
    }

    public static func start() -> Stopwatch {
        Stopwatch()
    }
}
