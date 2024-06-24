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

    var asKeyPressEventArgs: KeyPressEventArgs? {
        guard let keyChar, let first = keyChar.first, keyChar.count == 1 else {
            return nil
        }
        if first.unicodeScalars.count == 1, let scalar = first.unicodeScalars.first {
            switch scalar.value {
            case 0x0...0x1F, 0x7F:
                return nil
            default:
                break
            }
        }

        return .init(
            keyChar: first,
            modifiers: modifiers.asKeyboardModifier
        )
    }
}
