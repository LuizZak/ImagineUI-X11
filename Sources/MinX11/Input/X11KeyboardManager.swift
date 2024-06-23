import CX11

// Setup and key management based on:
// https://gist.github.com/baines/5a49f1334281b2685af5dcae81a6fa8a

/// Digests keyboard input and invokes a delegate with information about processed
/// input keys.
public class X11KeyboardManager {
    public typealias EventResult = Void

    let xic: XIC
    public weak var delegate: X11KeyboardManagerDelegate?

    public init(xic: XIC) {
        self.xic = xic
    }

    public func onKeyPress(_ event: XKeyPressedEvent) -> EventResult? {
        let event = makeKeyEventArgs(event)
        return delegate?.keyboardManager(self, onKeyPress: event)
    }

    public func onKeyRelease(_ event: XKeyReleasedEvent) -> EventResult? {
        let event = makeKeyEventArgs(event)
        return delegate?.keyboardManager(self, onKeyRelease: event)
    }

    // MARK: Message translation

    private func makeKeyEventArgs(_ event: XKeyEvent) -> X11KeyEventArgs {

        var keyChar: String? = nil
        var event = event
        var status: Int32 = 0
        var text: [CChar] = .init(repeating: 0, count: 32)
        var keySym: KeySym = KeySym(NoSymbol)
        Xutf8LookupString(xic, &event, &text, Int32(text.count - 1), &keySym, &status)

        if status == XLookupChars || status == XLookupBoth {
            keyChar = String(cString: text)
        }

        let xkCode: X11Keys = X11Keys(fromX11KeySym: keySym)
        let modifiers: X11KeyboardModifier = makeKeyboardModifiers(event)

        return X11KeyEventArgs(
            keyCode: xkCode,
            keyChar: keyChar,
            modifiers: modifiers
        )
    }

    private func makeKeyboardModifiers(_ event: XKeyEvent) -> X11KeyboardModifier {
        var modifiers: X11KeyboardModifier = []

        if event.state & UInt32(ControlMask) == ControlMask {
            modifiers.insert(.control)
        }
        if event.state & UInt32(ShiftMask) == ShiftMask {
            modifiers.insert(.shift)
        }
        if event.state & UInt32(Mod1Mask) == Mod1Mask {
            modifiers.insert(.alt)
        }

        return modifiers
    }
}

public protocol X11KeyboardManagerDelegate: AnyObject {
    func keyboardManager(
        _ manager: X11KeyboardManager,
        onKeyPress event: X11KeyEventArgs
    )
    func keyboardManager(
        _ manager: X11KeyboardManager,
        onKeyRelease event: X11KeyEventArgs
    )
}
