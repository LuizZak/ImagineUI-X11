import ImagineUI
import MinX11

class X11TextClipboard: TextClipboard {
    func getText() -> String? {
        // TODO: Implement text clipboard
        return nil
    }

    func setText(_ text: String) {
        // TODO: Implement text clipboard
    }

    func containsText() -> Bool {
        return getText() != nil
    }
}
