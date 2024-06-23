import ImagineUI
import MinX11

extension X11KeyEventArgs {
    var asKeyEventArgs: KeyEventArgs {
        .init(
            keyCode: keyCode.asKeys,
            keyChar: keyChar,
            modifiers: modifiers.asKeyboardModifier
        )
    }
}
