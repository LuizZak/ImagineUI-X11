import Foundation
import Logging

/// Main logger with support for file logging when setup with ``setup(logFileUrl:label:)``.
public enum X11Logger {
    public static var logger: Logger = Logger(label: "com.minx11.logging")

    /// Sets up file logging to a specified file URL.
    public static func setup(logFileUrl: URL, label: String) throws {
        let fileLogger = try FileLogging(to: logFileUrl)

        LoggingSystem.bootstrap { label in
            let handlers:[LogHandler] = [
                FileLogHandler(label: label, fileLogger: fileLogger),
                StreamLogHandler.standardOutput(label: label)
            ]

            return MultiplexLogHandler(handlers)
        }

        logger = Logger(label: label)
    }

    /// Convenience for `X11Logger.logger.info(message)`.
    public static func info(
        _ message: @autoclosure () -> Logger.Message,
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {

        logger.info(message(), file: file, function: function, line: line)
    }

    /// Convenience for `X11Logger.logger.warning(message)`.
    public static func warning(
        _ message: @autoclosure () -> Logger.Message,
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {

        logger.warning(message(), file: file, function: function, line: line)
    }

    /// Convenience for `X11Logger.logger.error(message)`.
    public static func error(
        _ message: @autoclosure () -> Logger.Message,
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {

        logger.error(message(), file: file, function: function, line: line)
    }

    /// Convenience for `X11Logger.logger.critical(message)`.
    public static func critical(
        _ message: @autoclosure () -> Logger.Message,
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {

        logger.critical(message(), file: file, function: function, line: line)
    }
}
