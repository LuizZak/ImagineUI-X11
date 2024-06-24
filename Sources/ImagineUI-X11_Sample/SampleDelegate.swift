import ImagineUI_X11

class SampleDelegate: ImagineUIAppDelegate {
    var main: ImagineUIContentType?

    func appDidLaunch() throws {
        // Disable bitmap caching to smoothen out UI and prevent stuttering on
        // full screen
        ControlView.globallyCacheAsBitmap = false

        let main = SampleWindow()
        app.show(content: main)

        self.main = main
    }
}
