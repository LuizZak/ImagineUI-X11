import CX11

extension X11Window {
    /// Settings used to create the window in the X11 APIs.
    public struct CreationSettings {
        /// Window's initial display title.
        public var title: String

        /// Window's initial size on screen.
        public var size: Size

        /// Display connection to X11.
        public var display: UnsafeMutablePointer<Display>

        public init(title: String, size: Size, display: UnsafeMutablePointer<Display>) {
            self.title = title
            self.size = size
            self.display = display
        }
    }
}
