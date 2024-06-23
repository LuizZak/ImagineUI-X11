import ImagineUI
import MinX11

extension X11KeyboardModifier {
    var asKeyboardModifier: KeyboardModifier {
        .init(rawValue: rawValue)
    }
}
