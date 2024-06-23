import CX11

public struct X11Keys: Hashable {
    public var rawValue: Int

    @_transparent
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    @_transparent
    public init<T: FixedWidthInteger>(fromX11VK vk: T) {
        self.init(rawValue: Int(vk))
    }

    @_transparent
    public init<T: FixedWidthInteger>(fromX11KeySym keySym: T) {
        self.init(rawValue: Int(keySym))
    }

    @_transparent
    public init(fromX11Event event: XKeyEvent) {
        self.init(rawValue: Int(event.keycode))
    }

    @_transparent
    public func hasModifier(_ key: X11Keys) -> Bool {
        return (rawValue & key.rawValue) == key.rawValue
    }

    @_transparent
    public func hasModifier(_ modifier: X11KeyboardModifier) -> Bool {
        return (rawValue & modifier.rawValue) == modifier.rawValue
    }
}

/*
public extension X11Keys {
    /// The A key.
    static let a = XK_A

    /// The add key.
    static let add = XK_plus

    /// The ALT modifier key.
    static let alt = XK_Alt_L

    /// The application key (Microsoft Natural Keyboard).
    //static let apps = X11Keys(fromX11KeySym: 93)

    /// The ATTN key.
    //static let attn = X11Keys(fromX11KeySym: 246)

    /// The B key.
    static let b = XK_B

    /// The BACKSPACE key.
    static let back = X11Keys(fromX11KeySym: 0xff08)

    /// The browser back key (Windows 2000 or later).
    //static let browserBack = X11Keys(fromX11KeySym: 166)

    /// The browser favorites key (Windows 2000 or later).
    //static let browserFavorites = X11Keys(fromX11KeySym: 171)

    /// The browser forward key (Windows 2000 or later).
    //static let browserForward = X11Keys(fromX11KeySym: 167)

    /// The browser home key (Windows 2000 or later).
    //static let browserHome = X11Keys(fromX11KeySym: 172)

    /// The browser refresh key (Windows 2000 or later).
    //static let browserRefresh = X11Keys(fromX11KeySym: 168)

    /// The browser search key (Windows 2000 or later).
    //static let browserSearch = X11Keys(fromX11KeySym: 170)

    /// The browser stop key (Windows 2000 or later).
    //static let browserStop = X11Keys(fromX11KeySym: 169)

    /// The C key.
    static let c = X11Keys(fromX11KeySym: 0x0043)

    /// The CANCEL key.
    static let cancel = X11Keys(fromX11KeySym: 0xff69)

    /// The CAPS LOCK key.
    static let capital = X11Keys(fromX11KeySym: 0xffe5)

    /// The CAPS LOCK key.
    static let capsLock = X11Keys(fromX11KeySym: 0xffe5)

    /// The CLEAR key.
    static let clear = X11Keys(fromX11KeySym: 0xff0b)

    /// The CTRL modifier key.
    static let control = X11Keys(fromX11KeySym: 0xffe3)

    /// The CTRL key.
    static let controlKey = X11Keys(fromX11KeySym: 0xffe3)

    /// The CRSEL key.
    //static let crsel = X11Keys(fromX11KeySym: 247)

    /// The D key.
    static let d = X11Keys(fromX11KeySym: 0x0044)

    /// The 0 key.
    static let d0 = X11Keys(fromX11KeySym: 0x0030)

    /// The 1 key.
    static let d1 = X11Keys(fromX11KeySym: 0x0031)

    /// The 2 key.
    static let d2 = X11Keys(fromX11KeySym: 0x0032)

    /// The 3 key.
    static let d3 = X11Keys(fromX11KeySym: 0x0033)

    /// The 4 key.
    static let d4 = X11Keys(fromX11KeySym: 0x0034)

    /// The 5 key.
    static let d5 = X11Keys(fromX11KeySym: 0x0035)

    /// The 6 key.
    static let d6 = X11Keys(fromX11KeySym: 0x0036)

    /// The 7 key.
    static let d7 = X11Keys(fromX11KeySym: 0x0037)

    /// The 8 key.
    static let d8 = X11Keys(fromX11KeySym: 0x0038)

    /// The 9 key.
    static let d9 = X11Keys(fromX11KeySym: 0x0039)

    /// The decimal key.
    static let decimal = X11Keys(fromX11KeySym: 0xffae)

    /// The DEL key.
    static let delete = X11Keys(fromX11KeySym: 0xffff)

    /// The divide key.
    static let divide = X11Keys(fromX11KeySym: 0xffaf)

    /// The DOWN ARROW key.
    static let down = X11Keys(fromX11KeySym: 0xff54)

    /// The E key.
    static let e = X11Keys(fromX11KeySym: 69)

    /// The END key.
    static let end = X11Keys(fromX11KeySym: 35)

    /// The ENTER key.
    static let enter = X11Keys(fromX11KeySym: 13)

    /// The ERASE EOF key.
    static let eraseEof = X11Keys(fromX11KeySym: 249)

    /// The ESC key.
    static let escape = X11Keys(fromX11KeySym: 27)

    /// The EXECUTE key.
    static let execute = X11Keys(fromX11KeySym: 43)

    /// The EXSEL key.
    static let exsel = X11Keys(fromX11KeySym: 248)

    /// The F key.
    static let f = X11Keys(fromX11KeySym: 70)

    /// The F1 key.
    static let f1 = X11Keys(fromX11KeySym: 112)

    /// The F10 key.
    static let f10 = X11Keys(fromX11KeySym: 121)

    /// The F11 key.
    static let f11 = X11Keys(fromX11KeySym: 122)

    /// The F12 key.
    static let f12 = X11Keys(fromX11KeySym: 123)

    /// The F13 key.
    static let f13 = X11Keys(fromX11KeySym: 124)

    /// The F14 key.
    static let f14 = X11Keys(fromX11KeySym: 125)

    /// The F15 key.
    static let f15 = X11Keys(fromX11KeySym: 126)

    /// The F16 key.
    static let f16 = X11Keys(fromX11KeySym: 127)

    /// The F17 key.
    static let f17 = X11Keys(fromX11KeySym: 128)

    /// The F18 key.
    static let f18 = X11Keys(fromX11KeySym: 129)

    /// The F19 key.
    static let f19 = X11Keys(fromX11KeySym: 130)

    /// The F2 key.
    static let f2 = X11Keys(fromX11KeySym: 113)

    /// The F20 key.
    static let f20 = X11Keys(fromX11KeySym: 131)

    /// The F21 key.
    static let f21 = X11Keys(fromX11KeySym: 132)

    /// The F22 key.
    static let f22 = X11Keys(fromX11KeySym: 133)

    /// The F23 key.
    static let f23 = X11Keys(fromX11KeySym: 134)

    /// The F24 key.
    static let f24 = X11Keys(fromX11KeySym: 135)

    /// The F3 key.
    static let f3 = X11Keys(fromX11KeySym: 114)

    /// The F4 key.
    static let f4 = X11Keys(fromX11KeySym: 115)

    /// The F5 key.
    static let f5 = X11Keys(fromX11KeySym: 116)

    /// The F6 key.
    static let f6 = X11Keys(fromX11KeySym: 117)

    /// The F7 key.
    static let f7 = X11Keys(fromX11KeySym: 118)

    /// The F8 key.
    static let f8 = X11Keys(fromX11KeySym: 119)

    /// The F9 key.
    static let f9 = X11Keys(fromX11KeySym: 120)

    /// The IME final mode key.
    static let finalMode = X11Keys(fromX11KeySym: 24)

    /// The G key.
    static let g = X11Keys(fromX11KeySym: 71)

    /// The H key.
    static let h = X11Keys(fromX11KeySym: 72)

    /// The IME Hanguel mode key. (maintained for compatibility; use HangulMode)
    static let hanguelMode = X11Keys(fromX11KeySym: 21)

    /// The IME Hangul mode key.
    static let hangulMode = X11Keys(fromX11KeySym: 21)

    /// The IME Hanja mode key.
    static let hanjaMode = X11Keys(fromX11KeySym: 25)

    /// The HELP key.
    static let help = X11Keys(fromX11KeySym: 47)

    /// The HOME key.
    static let home = X11Keys(fromX11KeySym: 36)

    /// The I key.
    static let i = X11Keys(fromX11KeySym: 73)

    /// The IME accept key, replaces IMEAceept.
    static let imeAccept = X11Keys(fromX11KeySym: 30)

    /// The IME accept key. Obsolete, use IMEAccept instead.
    static let imeAceept = X11Keys(fromX11KeySym: 30)

    /// The IME convert key.
    static let imeConvert = X11Keys(fromX11KeySym: 28)

    /// The IME mode change key.
    static let imeModeChange = X11Keys(fromX11KeySym: 31)

    /// The IME nonconvert key.
    static let imeNonconvert = X11Keys(fromX11KeySym: 29)

    /// The INS key.
    static let insert = X11Keys(fromX11KeySym: 45)

    /// The J key.
    static let j = X11Keys(fromX11KeySym: 74)

    /// The IME Junja mode key.
    static let junjaMode = X11Keys(fromX11KeySym: 23)

    /// The K key.
    static let k = X11Keys(fromX11KeySym: 75)

    /// The IME Kana mode key.
    static let kanaMode = X11Keys(fromX11KeySym: 21)

    /// The IME Kanji mode key.
    static let kanjiMode = X11Keys(fromX11KeySym: 25)

    /// The bitmask to extract a key code from a key value.
    static let keyCode = X11Keys(fromX11KeySym: 65535)

    /// The L key.
    static let l = X11Keys(fromX11KeySym: 76)

    /// The start application one key (Windows 2000 or later).
    static let launchApplication1 = X11Keys(fromX11KeySym: 182)

    /// The start application two key (Windows 2000 or later).
    static let launchApplication2 = X11Keys(fromX11KeySym: 183)

    /// The launch mail key (Windows 2000 or later).
    static let launchMail = X11Keys(fromX11KeySym: 180)

    /// The left mouse button.
    static let lButton = X11Keys(fromX11KeySym: 1)

    /// The left CTRL key.
    static let lControlKey = X11Keys(fromX11KeySym: 162)

    /// The LEFT ARROW key.
    static let left = X11Keys(fromX11KeySym: 37)

    /// The LINEFEED key.
    static let lineFeed = X11Keys(fromX11KeySym: 10)

    /// The left ALT key.
    static let lMenu = X11Keys(fromX11KeySym: 164)

    /// The left SHIFT key.
    static let lShiftKey = X11Keys(fromX11KeySym: 160)

    /// The left Windows logo key (Microsoft Natural Keyboard).
    static let lWin = X11Keys(fromX11KeySym: 91)

    /// The M key.
    static let m = X11Keys(fromX11KeySym: 77)

    /// The middle mouse button (three-button mouse).
    static let mButton = X11Keys(fromX11KeySym: 4)

    /// The media next track key (Windows 2000 or later).
    static let mediaNextTrack = X11Keys(fromX11KeySym: 176)

    /// The media play pause key (Windows 2000 or later).
    static let mediaPlayPause = X11Keys(fromX11KeySym: 179)

    /// The media previous track key (Windows 2000 or later).
    static let mediaPreviousTrack = X11Keys(fromX11KeySym: 177)

    /// The media Stop key (Windows 2000 or later).
    static let mediaStop = X11Keys(fromX11KeySym: 178)

    /// The ALT key.
    static let menu = X11Keys(fromX11KeySym: 18)

    /// The bitmask to extract modifiers from a key value.
    static let modifiers = X11Keys(fromX11KeySym: -65536)

    /// The multiply key.
    static let multiply = X11Keys(fromX11KeySym: 106)

    /// The N key.
    static let n = X11Keys(fromX11KeySym: 78)

    /// The PAGE DOWN key.
    static let next = X11Keys(fromX11KeySym: 34)

    /// A constant reserved for future use.
    static let noName = X11Keys(fromX11KeySym: 252)

    /// No key pressed.
    static let none = X11Keys(fromX11KeySym: 0)

    /// The NUM LOCK key.
    static let numLock = X11Keys(fromX11KeySym: 144)

    /// The 0 key on the numeric keypad.
    static let numPad0 = X11Keys(fromX11KeySym: 96)

    /// The 1 key on the numeric keypad.
    static let numPad1 = X11Keys(fromX11KeySym: 97)

    /// The 2 key on the numeric keypad.
    static let numPad2 = X11Keys(fromX11KeySym: 98)

    /// The 3 key on the numeric keypad.
    static let numPad3 = X11Keys(fromX11KeySym: 99)

    /// The 4 key on the numeric keypad.
    static let numPad4 = X11Keys(fromX11KeySym: 100)

    /// The 5 key on the numeric keypad.
    static let numPad5 = X11Keys(fromX11KeySym: 101)

    /// The 6 key on the numeric keypad.
    static let numPad6 = X11Keys(fromX11KeySym: 102)

    /// The 7 key on the numeric keypad.
    static let numPad7 = X11Keys(fromX11KeySym: 103)

    /// The 8 key on the numeric keypad.
    static let numPad8 = X11Keys(fromX11KeySym: 104)

    /// The 9 key on the numeric keypad.
    static let numPad9 = X11Keys(fromX11KeySym: 105)

    /// The O key.
    static let o = X11Keys(fromX11KeySym: 79)

    /// The OEM 1 key.
    static let oem1 = X11Keys(fromX11KeySym: 186)

    /// The OEM 102 key.
    static let oem102 = X11Keys(fromX11KeySym: 226)

    /// The OEM 2 key.
    static let oem2 = X11Keys(fromX11KeySym: 191)

    /// The OEM 3 key.
    static let oem3 = X11Keys(fromX11KeySym: 192)

    /// The OEM 4 key.
    static let oem4 = X11Keys(fromX11KeySym: 219)

    /// The OEM 5 key.
    static let oem5 = X11Keys(fromX11KeySym: 220)

    /// The OEM 6 key.
    static let oem6 = X11Keys(fromX11KeySym: 221)

    /// The OEM 7 key.
    static let oem7 = X11Keys(fromX11KeySym: 222)

    /// The OEM 8 key.
    static let oem8 = X11Keys(fromX11KeySym: 223)

    /// The OEM angle bracket or backslash key on the RT 102 key keyboard
    /// (Windows 2000 or later).
    static let oemBackslash = X11Keys(fromX11KeySym: 226)

    /// The CLEAR key.
    static let oemClear = X11Keys(fromX11KeySym: 254)

    /// The OEM close bracket key on a US standard keyboard (Windows 2000 or later).
    static let oemCloseBrackets = X11Keys(fromX11KeySym: 221)

    /// The OEM comma key on any country/region keyboard (Windows 2000 or later).
    static let oemcomma = X11Keys(fromX11KeySym: 188)

    /// The OEM minus key on any country/region keyboard (Windows 2000 or later).
    static let oemMinus = X11Keys(fromX11KeySym: 189)

    /// The OEM open bracket key on a US standard keyboard (Windows 2000 or later).
    static let oemOpenBrackets = X11Keys(fromX11KeySym: 219)

    /// The OEM period key on any country/region keyboard (Windows 2000 or later).
    static let oemPeriod = X11Keys(fromX11KeySym: 190)

    /// The OEM pipe key on a US standard keyboard (Windows 2000 or later).
    static let oemPipe = X11Keys(fromX11KeySym: 220)

    /// The OEM plus key on any country/region keyboard (Windows 2000 or later).
    static let oemplus = X11Keys(fromX11KeySym: 187)

    /// The OEM question mark key on a US standard keyboard (Windows 2000 or later).
    static let oemQuestion = X11Keys(fromX11KeySym: 191)

    /// The OEM singled/double quote key on a US standard keyboard (Windows 2000
    /// or later).
    static let oemQuotes = X11Keys(fromX11KeySym: 222)

    /// The OEM Semicolon key on a US standard keyboard (Windows 2000 or later).
    static let oemSemicolon = X11Keys(fromX11KeySym: 186)

    /// The OEM tilde key on a US standard keyboard (Windows 2000 or later).
    static let oemtilde = X11Keys(fromX11KeySym: 192)

    /// The P key.
    static let p = X11Keys(fromX11KeySym: 80)

    /// The PA1 key.
    static let pa1 = X11Keys(fromX11KeySym: 253)

    /// Used to pass Unicode characters as if they were keystrokes. The Packet
    /// /key value is the low word of a 32-bit virtual-key value used for
    /// non-keyboard input methods.
    static let packet = X11Keys(fromX11KeySym: 231)

    /// The PAGE DOWN key.
    static let pageDown = X11Keys(fromX11KeySym: 34)

    /// The PAGE UP key.
    static let pageUp = X11Keys(fromX11KeySym: 33)

    /// The PAUSE key.
    static let pause = X11Keys(fromX11KeySym: 19)

    /// The PLAY key.
    static let play = X11Keys(fromX11KeySym: 250)

    /// The PRINT key.
    static let print = X11Keys(fromX11KeySym: 42)

    /// The PRINT SCREEN key.
    static let printScreen = X11Keys(fromX11KeySym: 44)

    /// The PAGE UP key.
    static let prior = X11Keys(fromX11KeySym: 33)

    /// The PROCESS KEY key.
    static let processKey = X11Keys(fromX11KeySym: 229)

    /// The Q key.
    static let q = X11Keys(fromX11KeySym: 81)

    /// The R key.
    static let r = X11Keys(fromX11KeySym: 82)

    /// The right mouse button.
    static let rButton = X11Keys(fromX11KeySym: 2)

    /// The right CTRL key.
    static let rControlKey = X11Keys(fromX11KeySym: 163)

    /// The RETURN key.
    static let `return` = X11Keys(fromX11KeySym: 13)

    /// The RIGHT ARROW key.
    static let right = X11Keys(fromX11KeySym: 39)

    /// The right ALT key.
    static let rMenu = X11Keys(fromX11KeySym: 165)

    /// The right SHIFT key.
    static let rShiftKey = X11Keys(fromX11KeySym: 161)

    /// The right Windows logo key (Microsoft Natural Keyboard).
    static let rWin = X11Keys(fromX11KeySym: 92)

    /// The S key.
    static let s = X11Keys(fromX11KeySym: 83)

    /// The SCROLL LOCK key.
    static let scroll = X11Keys(fromX11KeySym: 145)

    /// The SELECT key.
    static let select = X11Keys(fromX11KeySym: 41)

    /// The select media key (Windows 2000 or later).
    static let selectMedia = X11Keys(fromX11KeySym: 181)

    /// The separator key.
    static let separator = X11Keys(fromX11KeySym: 108)

    /// The SHIFT modifier key.
    static let shift = X11Keys(fromX11KeySym: 65536)

    /// The SHIFT key.
    static let shiftKey = X11Keys(fromX11KeySym: 16)

    /// The computer sleep key.
    static let sleep = X11Keys(fromX11KeySym: 95)

    /// The PRINT SCREEN key.
    static let snapshot = X11Keys(fromX11KeySym: 44)

    /// The SPACEBAR key.
    static let space = X11Keys(fromX11KeySym: 32)

    /// The subtract key.
    static let subtract = X11Keys(fromX11KeySym: 109)

    /// The T key.
    static let t = X11Keys(fromX11KeySym: 84)

    /// The TAB key.
    static let tab = X11Keys(fromX11KeySym: 9)

    /// The U key.
    static let u = X11Keys(fromX11KeySym: 85)

    /// The UP ARROW key.
    static let up = X11Keys(fromX11KeySym: 38)

    /// The V key.
    static let v = X11Keys(fromX11KeySym: 86)

    /// The volume down key (Windows 2000 or later).
    static let volumeDown = X11Keys(fromX11KeySym: 174)

    /// The volume mute key (Windows 2000 or later).
    static let volumeMute = X11Keys(fromX11KeySym: 173)

    /// The volume up key (Windows 2000 or later).
    static let volumeUp = X11Keys(fromX11KeySym: 175)

    /// The W key.
    static let w = X11Keys(fromX11KeySym: 87)

    /// The X key.
    static let x = X11Keys(fromX11KeySym: 88)

    /// The first x mouse button (five-button mouse).
    static let xButton1 = X11Keys(fromX11KeySym: 5)

    /// The second x mouse button (five-button mouse).
    static let xButton2 = X11Keys(fromX11KeySym: 6)

    /// The Y key.
    static let y = X11Keys(fromX11KeySym: 89)

    /// The Z key.
    static let z = X11Keys(fromX11KeySym: 90)

    /// The ZOOM key.
    static let zoom = X11Keys(fromX11KeySym: 251)
}
*/

public extension X11Keys {
    static let XK_VoidSymbol = X11Keys(fromX11KeySym: 0xffffff)  /* Void symbol */

    /*
    * TTY function keys, cleverly chosen to map to ASCII, for convenience of
    * programming, but could have been arbitrary (at the cost of lookup
    * tables in client code).
    */

    static let XK_BackSpace = X11Keys(fromX11KeySym: 0xff08)  /* Back space, back char */
    static let XK_Tab = X11Keys(fromX11KeySym: 0xff09)
    static let XK_Linefeed = X11Keys(fromX11KeySym: 0xff0a)  /* Linefeed, LF */
    static let XK_Clear = X11Keys(fromX11KeySym: 0xff0b)
    static let XK_Return = X11Keys(fromX11KeySym: 0xff0d)  /* Return, enter */
    static let XK_Pause = X11Keys(fromX11KeySym: 0xff13)  /* Pause, hold */
    static let XK_Scroll_Lock = X11Keys(fromX11KeySym: 0xff14)
    static let XK_Sys_Req = X11Keys(fromX11KeySym: 0xff15)
    static let XK_Escape = X11Keys(fromX11KeySym: 0xff1b)
    static let XK_Delete = X11Keys(fromX11KeySym: 0xffff)  /* Delete, rubout */


    /* International & multi-key character composition */

    static let XK_Multi_key = X11Keys(fromX11KeySym: 0xff20)  /* Multi-key character compose */
    static let XK_Codeinput = X11Keys(fromX11KeySym: 0xff37)
    static let XK_SingleCandidate = X11Keys(fromX11KeySym: 0xff3c)
    static let XK_MultipleCandidate = X11Keys(fromX11KeySym: 0xff3d)
    static let XK_PreviousCandidate = X11Keys(fromX11KeySym: 0xff3e)

    /* Japanese keyboard support */

    static let XK_Kanji = X11Keys(fromX11KeySym: 0xff21)  /* Kanji, Kanji convert */
    static let XK_Muhenkan = X11Keys(fromX11KeySym: 0xff22)  /* Cancel Conversion */
    static let XK_Henkan_Mode = X11Keys(fromX11KeySym: 0xff23)  /* Start/Stop Conversion */
    static let XK_Henkan = X11Keys(fromX11KeySym: 0xff23)  /* Alias for Henkan_Mode */
    static let XK_Romaji = X11Keys(fromX11KeySym: 0xff24)  /* to Romaji */
    static let XK_Hiragana = X11Keys(fromX11KeySym: 0xff25)  /* to Hiragana */
    static let XK_Katakana = X11Keys(fromX11KeySym: 0xff26)  /* to Katakana */
    static let XK_Hiragana_Katakana = X11Keys(fromX11KeySym: 0xff27)  /* Hiragana/Katakana toggle */
    static let XK_Zenkaku = X11Keys(fromX11KeySym: 0xff28)  /* to Zenkaku */
    static let XK_Hankaku = X11Keys(fromX11KeySym: 0xff29)  /* to Hankaku */
    static let XK_Zenkaku_Hankaku = X11Keys(fromX11KeySym: 0xff2a)  /* Zenkaku/Hankaku toggle */
    static let XK_Touroku = X11Keys(fromX11KeySym: 0xff2b)  /* Add to Dictionary */
    static let XK_Massyo = X11Keys(fromX11KeySym: 0xff2c)  /* Delete from Dictionary */
    static let XK_Kana_Lock = X11Keys(fromX11KeySym: 0xff2d)  /* Kana Lock */
    static let XK_Kana_Shift = X11Keys(fromX11KeySym: 0xff2e)  /* Kana Shift */
    static let XK_Eisu_Shift = X11Keys(fromX11KeySym: 0xff2f)  /* Alphanumeric Shift */
    static let XK_Eisu_toggle = X11Keys(fromX11KeySym: 0xff30)  /* Alphanumeric toggle */
    static let XK_Kanji_Bangou = X11Keys(fromX11KeySym: 0xff37)  /* Codeinput */
    static let XK_Zen_Koho = X11Keys(fromX11KeySym: 0xff3d)  /* Multiple/All Candidate(s) */
    static let XK_Mae_Koho = X11Keys(fromX11KeySym: 0xff3e)  /* Previous Candidate */

    /* 0xff31 thru 0xff3f are under XK_KOREAN */

    /* Cursor control & motion */

    static let XK_Home = X11Keys(fromX11KeySym: 0xff50)
    static let XK_Left = X11Keys(fromX11KeySym: 0xff51)  /* Move left, left arrow */
    static let XK_Up = X11Keys(fromX11KeySym: 0xff52)  /* Move up, up arrow */
    static let XK_Right = X11Keys(fromX11KeySym: 0xff53)  /* Move right, right arrow */
    static let XK_Down = X11Keys(fromX11KeySym: 0xff54)  /* Move down, down arrow */
    static let XK_Prior = X11Keys(fromX11KeySym: 0xff55)  /* Prior, previous */
    static let XK_Page_Up = X11Keys(fromX11KeySym: 0xff55)
    static let XK_Next = X11Keys(fromX11KeySym: 0xff56)  /* Next */
    static let XK_Page_Down = X11Keys(fromX11KeySym: 0xff56)
    static let XK_End = X11Keys(fromX11KeySym: 0xff57)  /* EOL */
    static let XK_Begin = X11Keys(fromX11KeySym: 0xff58)  /* BOL */


    /* Misc functions */

    static let XK_Select = X11Keys(fromX11KeySym: 0xff60)  /* Select, mark */
    static let XK_Print = X11Keys(fromX11KeySym: 0xff61)
    static let XK_Execute = X11Keys(fromX11KeySym: 0xff62)  /* Execute, run, do */
    static let XK_Insert = X11Keys(fromX11KeySym: 0xff63)  /* Insert, insert here */
    static let XK_Undo = X11Keys(fromX11KeySym: 0xff65)
    static let XK_Redo = X11Keys(fromX11KeySym: 0xff66)  /* Redo, again */
    static let XK_Menu = X11Keys(fromX11KeySym: 0xff67)
    static let XK_Find = X11Keys(fromX11KeySym: 0xff68)  /* Find, search */
    static let XK_Cancel = X11Keys(fromX11KeySym: 0xff69)  /* Cancel, stop, abort, exit */
    static let XK_Help = X11Keys(fromX11KeySym: 0xff6a)  /* Help */
    static let XK_Break = X11Keys(fromX11KeySym: 0xff6b)
    static let XK_Mode_switch = X11Keys(fromX11KeySym: 0xff7e)  /* Character set switch */
    static let XK_script_switch = X11Keys(fromX11KeySym: 0xff7e)  /* Alias for mode_switch */
    static let XK_Num_Lock = X11Keys(fromX11KeySym: 0xff7f)

    /* Keypad functions, keypad numbers cleverly chosen to map to ASCII */

    static let XK_KP_Space = X11Keys(fromX11KeySym: 0xff80)  /* Space */
    static let XK_KP_Tab = X11Keys(fromX11KeySym: 0xff89)
    static let XK_KP_Enter = X11Keys(fromX11KeySym: 0xff8d)  /* Enter */
    static let XK_KP_F1 = X11Keys(fromX11KeySym: 0xff91)  /* PF1, KP_A, ... */
    static let XK_KP_F2 = X11Keys(fromX11KeySym: 0xff92)
    static let XK_KP_F3 = X11Keys(fromX11KeySym: 0xff93)
    static let XK_KP_F4 = X11Keys(fromX11KeySym: 0xff94)
    static let XK_KP_Home = X11Keys(fromX11KeySym: 0xff95)
    static let XK_KP_Left = X11Keys(fromX11KeySym: 0xff96)
    static let XK_KP_Up = X11Keys(fromX11KeySym: 0xff97)
    static let XK_KP_Right = X11Keys(fromX11KeySym: 0xff98)
    static let XK_KP_Down = X11Keys(fromX11KeySym: 0xff99)
    static let XK_KP_Prior = X11Keys(fromX11KeySym: 0xff9a)
    static let XK_KP_Page_Up = X11Keys(fromX11KeySym: 0xff9a)
    static let XK_KP_Next = X11Keys(fromX11KeySym: 0xff9b)
    static let XK_KP_Page_Down = X11Keys(fromX11KeySym: 0xff9b)
    static let XK_KP_End = X11Keys(fromX11KeySym: 0xff9c)
    static let XK_KP_Begin = X11Keys(fromX11KeySym: 0xff9d)
    static let XK_KP_Insert = X11Keys(fromX11KeySym: 0xff9e)
    static let XK_KP_Delete = X11Keys(fromX11KeySym: 0xff9f)
    static let XK_KP_Equal = X11Keys(fromX11KeySym: 0xffbd)  /* Equals */
    static let XK_KP_Multiply = X11Keys(fromX11KeySym: 0xffaa)
    static let XK_KP_Add = X11Keys(fromX11KeySym: 0xffab)
    static let XK_KP_Separator = X11Keys(fromX11KeySym: 0xffac)  /* Separator, often comma */
    static let XK_KP_Subtract = X11Keys(fromX11KeySym: 0xffad)
    static let XK_KP_Decimal = X11Keys(fromX11KeySym: 0xffae)
    static let XK_KP_Divide = X11Keys(fromX11KeySym: 0xffaf)

    static let XK_KP_0 = X11Keys(fromX11KeySym: 0xffb0)
    static let XK_KP_1 = X11Keys(fromX11KeySym: 0xffb1)
    static let XK_KP_2 = X11Keys(fromX11KeySym: 0xffb2)
    static let XK_KP_3 = X11Keys(fromX11KeySym: 0xffb3)
    static let XK_KP_4 = X11Keys(fromX11KeySym: 0xffb4)
    static let XK_KP_5 = X11Keys(fromX11KeySym: 0xffb5)
    static let XK_KP_6 = X11Keys(fromX11KeySym: 0xffb6)
    static let XK_KP_7 = X11Keys(fromX11KeySym: 0xffb7)
    static let XK_KP_8 = X11Keys(fromX11KeySym: 0xffb8)
    static let XK_KP_9 = X11Keys(fromX11KeySym: 0xffb9)

    /*
    * Auxiliary functions; note the duplicate definitions for left and right
    * function keys;  Sun keyboards and a few other manufacturers have such
    * function key groups on the left and/or right sides of the keyboard.
    * We've not found a keyboard with more than 35 function keys total.
    */

    static let XK_F1 = X11Keys(fromX11KeySym: 0xffbe)
    static let XK_F2 = X11Keys(fromX11KeySym: 0xffbf)
    static let XK_F3 = X11Keys(fromX11KeySym: 0xffc0)
    static let XK_F4 = X11Keys(fromX11KeySym: 0xffc1)
    static let XK_F5 = X11Keys(fromX11KeySym: 0xffc2)
    static let XK_F6 = X11Keys(fromX11KeySym: 0xffc3)
    static let XK_F7 = X11Keys(fromX11KeySym: 0xffc4)
    static let XK_F8 = X11Keys(fromX11KeySym: 0xffc5)
    static let XK_F9 = X11Keys(fromX11KeySym: 0xffc6)
    static let XK_F10 = X11Keys(fromX11KeySym: 0xffc7)
    static let XK_F11 = X11Keys(fromX11KeySym: 0xffc8)
    static let XK_L1 = X11Keys(fromX11KeySym: 0xffc8)
    static let XK_F12 = X11Keys(fromX11KeySym: 0xffc9)
    static let XK_L2 = X11Keys(fromX11KeySym: 0xffc9)
    static let XK_F13 = X11Keys(fromX11KeySym: 0xffca)
    static let XK_L3 = X11Keys(fromX11KeySym: 0xffca)
    static let XK_F14 = X11Keys(fromX11KeySym: 0xffcb)
    static let XK_L4 = X11Keys(fromX11KeySym: 0xffcb)
    static let XK_F15 = X11Keys(fromX11KeySym: 0xffcc)
    static let XK_L5 = X11Keys(fromX11KeySym: 0xffcc)
    static let XK_F16 = X11Keys(fromX11KeySym: 0xffcd)
    static let XK_L6 = X11Keys(fromX11KeySym: 0xffcd)
    static let XK_F17 = X11Keys(fromX11KeySym: 0xffce)
    static let XK_L7 = X11Keys(fromX11KeySym: 0xffce)
    static let XK_F18 = X11Keys(fromX11KeySym: 0xffcf)
    static let XK_L8 = X11Keys(fromX11KeySym: 0xffcf)
    static let XK_F19 = X11Keys(fromX11KeySym: 0xffd0)
    static let XK_L9 = X11Keys(fromX11KeySym: 0xffd0)
    static let XK_F20 = X11Keys(fromX11KeySym: 0xffd1)
    static let XK_L10 = X11Keys(fromX11KeySym: 0xffd1)
    static let XK_F21 = X11Keys(fromX11KeySym: 0xffd2)
    static let XK_R1 = X11Keys(fromX11KeySym: 0xffd2)
    static let XK_F22 = X11Keys(fromX11KeySym: 0xffd3)
    static let XK_R2 = X11Keys(fromX11KeySym: 0xffd3)
    static let XK_F23 = X11Keys(fromX11KeySym: 0xffd4)
    static let XK_R3 = X11Keys(fromX11KeySym: 0xffd4)
    static let XK_F24 = X11Keys(fromX11KeySym: 0xffd5)
    static let XK_R4 = X11Keys(fromX11KeySym: 0xffd5)
    static let XK_F25 = X11Keys(fromX11KeySym: 0xffd6)
    static let XK_R5 = X11Keys(fromX11KeySym: 0xffd6)
    static let XK_F26 = X11Keys(fromX11KeySym: 0xffd7)
    static let XK_R6 = X11Keys(fromX11KeySym: 0xffd7)
    static let XK_F27 = X11Keys(fromX11KeySym: 0xffd8)
    static let XK_R7 = X11Keys(fromX11KeySym: 0xffd8)
    static let XK_F28 = X11Keys(fromX11KeySym: 0xffd9)
    static let XK_R8 = X11Keys(fromX11KeySym: 0xffd9)
    static let XK_F29 = X11Keys(fromX11KeySym: 0xffda)
    static let XK_R9 = X11Keys(fromX11KeySym: 0xffda)
    static let XK_F30 = X11Keys(fromX11KeySym: 0xffdb)
    static let XK_R10 = X11Keys(fromX11KeySym: 0xffdb)
    static let XK_F31 = X11Keys(fromX11KeySym: 0xffdc)
    static let XK_R11 = X11Keys(fromX11KeySym: 0xffdc)
    static let XK_F32 = X11Keys(fromX11KeySym: 0xffdd)
    static let XK_R12 = X11Keys(fromX11KeySym: 0xffdd)
    static let XK_F33 = X11Keys(fromX11KeySym: 0xffde)
    static let XK_R13 = X11Keys(fromX11KeySym: 0xffde)
    static let XK_F34 = X11Keys(fromX11KeySym: 0xffdf)
    static let XK_R14 = X11Keys(fromX11KeySym: 0xffdf)
    static let XK_F35 = X11Keys(fromX11KeySym: 0xffe0)
    static let XK_R15 = X11Keys(fromX11KeySym: 0xffe0)

    /* Modifiers */

    static let XK_Shift_L = X11Keys(fromX11KeySym: 0xffe1)  /* Left shift */
    static let XK_Shift_R = X11Keys(fromX11KeySym: 0xffe2)  /* Right shift */
    static let XK_Control_L = X11Keys(fromX11KeySym: 0xffe3)  /* Left control */
    static let XK_Control_R = X11Keys(fromX11KeySym: 0xffe4)  /* Right control */
    static let XK_Caps_Lock = X11Keys(fromX11KeySym: 0xffe5)  /* Caps lock */
    static let XK_Shift_Lock = X11Keys(fromX11KeySym: 0xffe6)  /* Shift lock */

    static let XK_Meta_L = X11Keys(fromX11KeySym: 0xffe7)  /* Left meta */
    static let XK_Meta_R = X11Keys(fromX11KeySym: 0xffe8)  /* Right meta */
    static let XK_Alt_L = X11Keys(fromX11KeySym: 0xffe9)  /* Left alt */
    static let XK_Alt_R = X11Keys(fromX11KeySym: 0xffea)  /* Right alt */
    static let XK_Super_L = X11Keys(fromX11KeySym: 0xffeb)  /* Left super */
    static let XK_Super_R = X11Keys(fromX11KeySym: 0xffec)  /* Right super */
    static let XK_Hyper_L = X11Keys(fromX11KeySym: 0xffed)  /* Left hyper */
    static let XK_Hyper_R = X11Keys(fromX11KeySym: 0xffee)  /* Right hyper */

    /*
    * Keyboard (XKB) Extension function and modifier keys
    * (from Appendix C of "The X Keyboard Extension: Protocol Specification")
    * Byte 3 = 0xfe
    */

    static let XK_ISO_Lock = X11Keys(fromX11KeySym: 0xfe01)
    static let XK_ISO_Level2_Latch = X11Keys(fromX11KeySym: 0xfe02)
    static let XK_ISO_Level3_Shift = X11Keys(fromX11KeySym: 0xfe03)
    static let XK_ISO_Level3_Latch = X11Keys(fromX11KeySym: 0xfe04)
    static let XK_ISO_Level3_Lock = X11Keys(fromX11KeySym: 0xfe05)
    static let XK_ISO_Level5_Shift = X11Keys(fromX11KeySym: 0xfe11)
    static let XK_ISO_Level5_Latch = X11Keys(fromX11KeySym: 0xfe12)
    static let XK_ISO_Level5_Lock = X11Keys(fromX11KeySym: 0xfe13)
    static let XK_ISO_Group_Shift = X11Keys(fromX11KeySym: 0xff7e)  /* Alias for mode_switch */
    static let XK_ISO_Group_Latch = X11Keys(fromX11KeySym: 0xfe06)
    static let XK_ISO_Group_Lock = X11Keys(fromX11KeySym: 0xfe07)
    static let XK_ISO_Next_Group = X11Keys(fromX11KeySym: 0xfe08)
    static let XK_ISO_Next_Group_Lock = X11Keys(fromX11KeySym: 0xfe09)
    static let XK_ISO_Prev_Group = X11Keys(fromX11KeySym: 0xfe0a)
    static let XK_ISO_Prev_Group_Lock = X11Keys(fromX11KeySym: 0xfe0b)
    static let XK_ISO_First_Group = X11Keys(fromX11KeySym: 0xfe0c)
    static let XK_ISO_First_Group_Lock = X11Keys(fromX11KeySym: 0xfe0d)
    static let XK_ISO_Last_Group = X11Keys(fromX11KeySym: 0xfe0e)
    static let XK_ISO_Last_Group_Lock = X11Keys(fromX11KeySym: 0xfe0f)

    static let XK_ISO_Left_Tab = X11Keys(fromX11KeySym: 0xfe20)
    static let XK_ISO_Move_Line_Up = X11Keys(fromX11KeySym: 0xfe21)
    static let XK_ISO_Move_Line_Down = X11Keys(fromX11KeySym: 0xfe22)
    static let XK_ISO_Partial_Line_Up = X11Keys(fromX11KeySym: 0xfe23)
    static let XK_ISO_Partial_Line_Down = X11Keys(fromX11KeySym: 0xfe24)
    static let XK_ISO_Partial_Space_Left = X11Keys(fromX11KeySym: 0xfe25)
    static let XK_ISO_Partial_Space_Right = X11Keys(fromX11KeySym: 0xfe26)
    static let XK_ISO_Set_Margin_Left = X11Keys(fromX11KeySym: 0xfe27)
    static let XK_ISO_Set_Margin_Right = X11Keys(fromX11KeySym: 0xfe28)
    static let XK_ISO_Release_Margin_Left = X11Keys(fromX11KeySym: 0xfe29)
    static let XK_ISO_Release_Margin_Right = X11Keys(fromX11KeySym: 0xfe2a)
    static let XK_ISO_Release_Both_Margins = X11Keys(fromX11KeySym: 0xfe2b)
    static let XK_ISO_Fast_Cursor_Left = X11Keys(fromX11KeySym: 0xfe2c)
    static let XK_ISO_Fast_Cursor_Right = X11Keys(fromX11KeySym: 0xfe2d)
    static let XK_ISO_Fast_Cursor_Up = X11Keys(fromX11KeySym: 0xfe2e)
    static let XK_ISO_Fast_Cursor_Down = X11Keys(fromX11KeySym: 0xfe2f)
    static let XK_ISO_Continuous_Underline = X11Keys(fromX11KeySym: 0xfe30)
    static let XK_ISO_Discontinuous_Underline = X11Keys(fromX11KeySym: 0xfe31)
    static let XK_ISO_Emphasize = X11Keys(fromX11KeySym: 0xfe32)
    static let XK_ISO_Center_Object = X11Keys(fromX11KeySym: 0xfe33)
    static let XK_ISO_Enter = X11Keys(fromX11KeySym: 0xfe34)

    static let XK_dead_grave = X11Keys(fromX11KeySym: 0xfe50)
    static let XK_dead_acute = X11Keys(fromX11KeySym: 0xfe51)
    static let XK_dead_circumflex = X11Keys(fromX11KeySym: 0xfe52)
    static let XK_dead_tilde = X11Keys(fromX11KeySym: 0xfe53)
    static let XK_dead_perispomeni = X11Keys(fromX11KeySym: 0xfe53)  /* alias for dead_tilde */
    static let XK_dead_macron = X11Keys(fromX11KeySym: 0xfe54)
    static let XK_dead_breve = X11Keys(fromX11KeySym: 0xfe55)
    static let XK_dead_abovedot = X11Keys(fromX11KeySym: 0xfe56)
    static let XK_dead_diaeresis = X11Keys(fromX11KeySym: 0xfe57)
    static let XK_dead_abovering = X11Keys(fromX11KeySym: 0xfe58)
    static let XK_dead_doubleacute = X11Keys(fromX11KeySym: 0xfe59)
    static let XK_dead_caron = X11Keys(fromX11KeySym: 0xfe5a)
    static let XK_dead_cedilla = X11Keys(fromX11KeySym: 0xfe5b)
    static let XK_dead_ogonek = X11Keys(fromX11KeySym: 0xfe5c)
    static let XK_dead_iota = X11Keys(fromX11KeySym: 0xfe5d)
    static let XK_dead_voiced_sound = X11Keys(fromX11KeySym: 0xfe5e)
    static let XK_dead_semivoiced_sound = X11Keys(fromX11KeySym: 0xfe5f)
    static let XK_dead_belowdot = X11Keys(fromX11KeySym: 0xfe60)
    static let XK_dead_hook = X11Keys(fromX11KeySym: 0xfe61)
    static let XK_dead_horn = X11Keys(fromX11KeySym: 0xfe62)
    static let XK_dead_stroke = X11Keys(fromX11KeySym: 0xfe63)
    static let XK_dead_abovecomma = X11Keys(fromX11KeySym: 0xfe64)
    static let XK_dead_psili = X11Keys(fromX11KeySym: 0xfe64)  /* alias for dead_abovecomma */
    static let XK_dead_abovereversedcomma = X11Keys(fromX11KeySym: 0xfe65)
    static let XK_dead_dasia = X11Keys(fromX11KeySym: 0xfe65)  /* alias for dead_abovereversedcomma */
    static let XK_dead_doublegrave = X11Keys(fromX11KeySym: 0xfe66)
    static let XK_dead_belowring = X11Keys(fromX11KeySym: 0xfe67)
    static let XK_dead_belowmacron = X11Keys(fromX11KeySym: 0xfe68)
    static let XK_dead_belowcircumflex = X11Keys(fromX11KeySym: 0xfe69)
    static let XK_dead_belowtilde = X11Keys(fromX11KeySym: 0xfe6a)
    static let XK_dead_belowbreve = X11Keys(fromX11KeySym: 0xfe6b)
    static let XK_dead_belowdiaeresis = X11Keys(fromX11KeySym: 0xfe6c)
    static let XK_dead_invertedbreve = X11Keys(fromX11KeySym: 0xfe6d)
    static let XK_dead_belowcomma = X11Keys(fromX11KeySym: 0xfe6e)
    static let XK_dead_currency = X11Keys(fromX11KeySym: 0xfe6f)

    /* dead vowels for universal syllable entry */
    static let XK_dead_a = X11Keys(fromX11KeySym: 0xfe80)
    static let XK_dead_A = X11Keys(fromX11KeySym: 0xfe81)
    static let XK_dead_e = X11Keys(fromX11KeySym: 0xfe82)
    static let XK_dead_E = X11Keys(fromX11KeySym: 0xfe83)
    static let XK_dead_i = X11Keys(fromX11KeySym: 0xfe84)
    static let XK_dead_I = X11Keys(fromX11KeySym: 0xfe85)
    static let XK_dead_o = X11Keys(fromX11KeySym: 0xfe86)
    static let XK_dead_O = X11Keys(fromX11KeySym: 0xfe87)
    static let XK_dead_u = X11Keys(fromX11KeySym: 0xfe88)
    static let XK_dead_U = X11Keys(fromX11KeySym: 0xfe89)
    static let XK_dead_schwa = X11Keys(fromX11KeySym: 0xfe8a)
    static let XK_dead_SCHWA = X11Keys(fromX11KeySym: 0xfe8b)
    static let XK_dead_small_schwa = X11Keys(fromX11KeySym: 0xfe8a)  /* deprecated, remove in 2025 */
    static let XK_dead_capital_schwa = X11Keys(fromX11KeySym: 0xfe8b)  /* deprecated, remove in 2025 */

    static let XK_dead_greek = X11Keys(fromX11KeySym: 0xfe8c)

    static let XK_First_Virtual_Screen = X11Keys(fromX11KeySym: 0xfed0)
    static let XK_Prev_Virtual_Screen = X11Keys(fromX11KeySym: 0xfed1)
    static let XK_Next_Virtual_Screen = X11Keys(fromX11KeySym: 0xfed2)
    static let XK_Last_Virtual_Screen = X11Keys(fromX11KeySym: 0xfed4)
    static let XK_Terminate_Server = X11Keys(fromX11KeySym: 0xfed5)

    static let XK_AccessX_Enable = X11Keys(fromX11KeySym: 0xfe70)
    static let XK_AccessX_Feedback_Enable = X11Keys(fromX11KeySym: 0xfe71)
    static let XK_RepeatKeys_Enable = X11Keys(fromX11KeySym: 0xfe72)
    static let XK_SlowKeys_Enable = X11Keys(fromX11KeySym: 0xfe73)
    static let XK_BounceKeys_Enable = X11Keys(fromX11KeySym: 0xfe74)
    static let XK_StickyKeys_Enable = X11Keys(fromX11KeySym: 0xfe75)
    static let XK_MouseKeys_Enable = X11Keys(fromX11KeySym: 0xfe76)
    static let XK_MouseKeys_Accel_Enable = X11Keys(fromX11KeySym: 0xfe77)
    static let XK_Overlay1_Enable = X11Keys(fromX11KeySym: 0xfe78)
    static let XK_Overlay2_Enable = X11Keys(fromX11KeySym: 0xfe79)
    static let XK_AudibleBell_Enable = X11Keys(fromX11KeySym: 0xfe7a)

    static let XK_Pointer_Left = X11Keys(fromX11KeySym: 0xfee0)
    static let XK_Pointer_Right = X11Keys(fromX11KeySym: 0xfee1)
    static let XK_Pointer_Up = X11Keys(fromX11KeySym: 0xfee2)
    static let XK_Pointer_Down = X11Keys(fromX11KeySym: 0xfee3)
    static let XK_Pointer_UpLeft = X11Keys(fromX11KeySym: 0xfee4)
    static let XK_Pointer_UpRight = X11Keys(fromX11KeySym: 0xfee5)
    static let XK_Pointer_DownLeft = X11Keys(fromX11KeySym: 0xfee6)
    static let XK_Pointer_DownRight = X11Keys(fromX11KeySym: 0xfee7)
    static let XK_Pointer_Button_Dflt = X11Keys(fromX11KeySym: 0xfee8)
    static let XK_Pointer_Button1 = X11Keys(fromX11KeySym: 0xfee9)
    static let XK_Pointer_Button2 = X11Keys(fromX11KeySym: 0xfeea)
    static let XK_Pointer_Button3 = X11Keys(fromX11KeySym: 0xfeeb)
    static let XK_Pointer_Button4 = X11Keys(fromX11KeySym: 0xfeec)
    static let XK_Pointer_Button5 = X11Keys(fromX11KeySym: 0xfeed)
    static let XK_Pointer_DblClick_Dflt = X11Keys(fromX11KeySym: 0xfeee)
    static let XK_Pointer_DblClick1 = X11Keys(fromX11KeySym: 0xfeef)
    static let XK_Pointer_DblClick2 = X11Keys(fromX11KeySym: 0xfef0)
    static let XK_Pointer_DblClick3 = X11Keys(fromX11KeySym: 0xfef1)
    static let XK_Pointer_DblClick4 = X11Keys(fromX11KeySym: 0xfef2)
    static let XK_Pointer_DblClick5 = X11Keys(fromX11KeySym: 0xfef3)
    static let XK_Pointer_Drag_Dflt = X11Keys(fromX11KeySym: 0xfef4)
    static let XK_Pointer_Drag1 = X11Keys(fromX11KeySym: 0xfef5)
    static let XK_Pointer_Drag2 = X11Keys(fromX11KeySym: 0xfef6)
    static let XK_Pointer_Drag3 = X11Keys(fromX11KeySym: 0xfef7)
    static let XK_Pointer_Drag4 = X11Keys(fromX11KeySym: 0xfef8)
    static let XK_Pointer_Drag5 = X11Keys(fromX11KeySym: 0xfefd)

    static let XK_Pointer_EnableKeys = X11Keys(fromX11KeySym: 0xfef9)
    static let XK_Pointer_Accelerate = X11Keys(fromX11KeySym: 0xfefa)
    static let XK_Pointer_DfltBtnNext = X11Keys(fromX11KeySym: 0xfefb)
    static let XK_Pointer_DfltBtnPrev = X11Keys(fromX11KeySym: 0xfefc)

    /* Single-Stroke Multiple-Character N-Graph Keysyms For The X Input Method */

    static let XK_ch = X11Keys(fromX11KeySym: 0xfea0)
    static let XK_Ch = X11Keys(fromX11KeySym: 0xfea1)
    static let XK_CH = X11Keys(fromX11KeySym: 0xfea2)
    static let XK_c_h = X11Keys(fromX11KeySym: 0xfea3)
    static let XK_C_h = X11Keys(fromX11KeySym: 0xfea4)
    static let XK_C_H = X11Keys(fromX11KeySym: 0xfea5)

    /*
    * 3270 Terminal Keys
    * Byte 3 = 0xfd
    */

    static let XK_3270_Duplicate = X11Keys(fromX11KeySym: 0xfd01)
    static let XK_3270_FieldMark = X11Keys(fromX11KeySym: 0xfd02)
    static let XK_3270_Right2 = X11Keys(fromX11KeySym: 0xfd03)
    static let XK_3270_Left2 = X11Keys(fromX11KeySym: 0xfd04)
    static let XK_3270_BackTab = X11Keys(fromX11KeySym: 0xfd05)
    static let XK_3270_EraseEOF = X11Keys(fromX11KeySym: 0xfd06)
    static let XK_3270_EraseInput = X11Keys(fromX11KeySym: 0xfd07)
    static let XK_3270_Reset = X11Keys(fromX11KeySym: 0xfd08)
    static let XK_3270_Quit = X11Keys(fromX11KeySym: 0xfd09)
    static let XK_3270_PA1 = X11Keys(fromX11KeySym: 0xfd0a)
    static let XK_3270_PA2 = X11Keys(fromX11KeySym: 0xfd0b)
    static let XK_3270_PA3 = X11Keys(fromX11KeySym: 0xfd0c)
    static let XK_3270_Test = X11Keys(fromX11KeySym: 0xfd0d)
    static let XK_3270_Attn = X11Keys(fromX11KeySym: 0xfd0e)
    static let XK_3270_CursorBlink = X11Keys(fromX11KeySym: 0xfd0f)
    static let XK_3270_AltCursor = X11Keys(fromX11KeySym: 0xfd10)
    static let XK_3270_KeyClick = X11Keys(fromX11KeySym: 0xfd11)
    static let XK_3270_Jump = X11Keys(fromX11KeySym: 0xfd12)
    static let XK_3270_Ident = X11Keys(fromX11KeySym: 0xfd13)
    static let XK_3270_Rule = X11Keys(fromX11KeySym: 0xfd14)
    static let XK_3270_Copy = X11Keys(fromX11KeySym: 0xfd15)
    static let XK_3270_Play = X11Keys(fromX11KeySym: 0xfd16)
    static let XK_3270_Setup = X11Keys(fromX11KeySym: 0xfd17)
    static let XK_3270_Record = X11Keys(fromX11KeySym: 0xfd18)
    static let XK_3270_ChangeScreen = X11Keys(fromX11KeySym: 0xfd19)
    static let XK_3270_DeleteWord = X11Keys(fromX11KeySym: 0xfd1a)
    static let XK_3270_ExSelect = X11Keys(fromX11KeySym: 0xfd1b)
    static let XK_3270_CursorSelect = X11Keys(fromX11KeySym: 0xfd1c)
    static let XK_3270_PrintScreen = X11Keys(fromX11KeySym: 0xfd1d)
    static let XK_3270_Enter = X11Keys(fromX11KeySym: 0xfd1e)

    /*
    * Latin 1
    * (ISO/IEC 8859-1 = Unicode U+0020..U+00FF)
    * Byte 3 = 0
    */
    static let XK_space = X11Keys(fromX11KeySym: 0x0020)  /* U+0020 SPACE */
    static let XK_exclam = X11Keys(fromX11KeySym: 0x0021)  /* U+0021 EXCLAMATION MARK */
    static let XK_quotedbl = X11Keys(fromX11KeySym: 0x0022)  /* U+0022 QUOTATION MARK */
    static let XK_numbersign = X11Keys(fromX11KeySym: 0x0023)  /* U+0023 NUMBER SIGN */
    static let XK_dollar = X11Keys(fromX11KeySym: 0x0024)  /* U+0024 DOLLAR SIGN */
    static let XK_percent = X11Keys(fromX11KeySym: 0x0025)  /* U+0025 PERCENT SIGN */
    static let XK_ampersand = X11Keys(fromX11KeySym: 0x0026)  /* U+0026 AMPERSAND */
    static let XK_apostrophe = X11Keys(fromX11KeySym: 0x0027)  /* U+0027 APOSTROPHE */
    static let XK_quoteright = X11Keys(fromX11KeySym: 0x0027)  /* deprecated */
    static let XK_parenleft = X11Keys(fromX11KeySym: 0x0028)  /* U+0028 LEFT PARENTHESIS */
    static let XK_parenright = X11Keys(fromX11KeySym: 0x0029)  /* U+0029 RIGHT PARENTHESIS */
    static let XK_asterisk = X11Keys(fromX11KeySym: 0x002a)  /* U+002A ASTERISK */
    static let XK_plus = X11Keys(fromX11KeySym: 0x002b)  /* U+002B PLUS SIGN */
    static let XK_comma = X11Keys(fromX11KeySym: 0x002c)  /* U+002C COMMA */
    static let XK_minus = X11Keys(fromX11KeySym: 0x002d)  /* U+002D HYPHEN-MINUS */
    static let XK_period = X11Keys(fromX11KeySym: 0x002e)  /* U+002E FULL STOP */
    static let XK_slash = X11Keys(fromX11KeySym: 0x002f)  /* U+002F SOLIDUS */
    static let XK_0 = X11Keys(fromX11KeySym: 0x0030)  /* U+0030 DIGIT ZERO */
    static let XK_1 = X11Keys(fromX11KeySym: 0x0031)  /* U+0031 DIGIT ONE */
    static let XK_2 = X11Keys(fromX11KeySym: 0x0032)  /* U+0032 DIGIT TWO */
    static let XK_3 = X11Keys(fromX11KeySym: 0x0033)  /* U+0033 DIGIT THREE */
    static let XK_4 = X11Keys(fromX11KeySym: 0x0034)  /* U+0034 DIGIT FOUR */
    static let XK_5 = X11Keys(fromX11KeySym: 0x0035)  /* U+0035 DIGIT FIVE */
    static let XK_6 = X11Keys(fromX11KeySym: 0x0036)  /* U+0036 DIGIT SIX */
    static let XK_7 = X11Keys(fromX11KeySym: 0x0037)  /* U+0037 DIGIT SEVEN */
    static let XK_8 = X11Keys(fromX11KeySym: 0x0038)  /* U+0038 DIGIT EIGHT */
    static let XK_9 = X11Keys(fromX11KeySym: 0x0039)  /* U+0039 DIGIT NINE */
    static let XK_colon = X11Keys(fromX11KeySym: 0x003a)  /* U+003A COLON */
    static let XK_semicolon = X11Keys(fromX11KeySym: 0x003b)  /* U+003B SEMICOLON */
    static let XK_less = X11Keys(fromX11KeySym: 0x003c)  /* U+003C LESS-THAN SIGN */
    static let XK_equal = X11Keys(fromX11KeySym: 0x003d)  /* U+003D EQUALS SIGN */
    static let XK_greater = X11Keys(fromX11KeySym: 0x003e)  /* U+003E GREATER-THAN SIGN */
    static let XK_question = X11Keys(fromX11KeySym: 0x003f)  /* U+003F QUESTION MARK */
    static let XK_at = X11Keys(fromX11KeySym: 0x0040)  /* U+0040 COMMERCIAL AT */
    static let XK_A = X11Keys(fromX11KeySym: 0x0041)  /* U+0041 LATIN CAPITAL LETTER A */
    static let XK_B = X11Keys(fromX11KeySym: 0x0042)  /* U+0042 LATIN CAPITAL LETTER B */
    static let XK_C = X11Keys(fromX11KeySym: 0x0043)  /* U+0043 LATIN CAPITAL LETTER C */
    static let XK_D = X11Keys(fromX11KeySym: 0x0044)  /* U+0044 LATIN CAPITAL LETTER D */
    static let XK_E = X11Keys(fromX11KeySym: 0x0045)  /* U+0045 LATIN CAPITAL LETTER E */
    static let XK_F = X11Keys(fromX11KeySym: 0x0046)  /* U+0046 LATIN CAPITAL LETTER F */
    static let XK_G = X11Keys(fromX11KeySym: 0x0047)  /* U+0047 LATIN CAPITAL LETTER G */
    static let XK_H = X11Keys(fromX11KeySym: 0x0048)  /* U+0048 LATIN CAPITAL LETTER H */
    static let XK_I = X11Keys(fromX11KeySym: 0x0049)  /* U+0049 LATIN CAPITAL LETTER I */
    static let XK_J = X11Keys(fromX11KeySym: 0x004a)  /* U+004A LATIN CAPITAL LETTER J */
    static let XK_K = X11Keys(fromX11KeySym: 0x004b)  /* U+004B LATIN CAPITAL LETTER K */
    static let XK_L = X11Keys(fromX11KeySym: 0x004c)  /* U+004C LATIN CAPITAL LETTER L */
    static let XK_M = X11Keys(fromX11KeySym: 0x004d)  /* U+004D LATIN CAPITAL LETTER M */
    static let XK_N = X11Keys(fromX11KeySym: 0x004e)  /* U+004E LATIN CAPITAL LETTER N */
    static let XK_O = X11Keys(fromX11KeySym: 0x004f)  /* U+004F LATIN CAPITAL LETTER O */
    static let XK_P = X11Keys(fromX11KeySym: 0x0050)  /* U+0050 LATIN CAPITAL LETTER P */
    static let XK_Q = X11Keys(fromX11KeySym: 0x0051)  /* U+0051 LATIN CAPITAL LETTER Q */
    static let XK_R = X11Keys(fromX11KeySym: 0x0052)  /* U+0052 LATIN CAPITAL LETTER R */
    static let XK_S = X11Keys(fromX11KeySym: 0x0053)  /* U+0053 LATIN CAPITAL LETTER S */
    static let XK_T = X11Keys(fromX11KeySym: 0x0054)  /* U+0054 LATIN CAPITAL LETTER T */
    static let XK_U = X11Keys(fromX11KeySym: 0x0055)  /* U+0055 LATIN CAPITAL LETTER U */
    static let XK_V = X11Keys(fromX11KeySym: 0x0056)  /* U+0056 LATIN CAPITAL LETTER V */
    static let XK_W = X11Keys(fromX11KeySym: 0x0057)  /* U+0057 LATIN CAPITAL LETTER W */
    static let XK_X = X11Keys(fromX11KeySym: 0x0058)  /* U+0058 LATIN CAPITAL LETTER X */
    static let XK_Y = X11Keys(fromX11KeySym: 0x0059)  /* U+0059 LATIN CAPITAL LETTER Y */
    static let XK_Z = X11Keys(fromX11KeySym: 0x005a)  /* U+005A LATIN CAPITAL LETTER Z */
    static let XK_bracketleft = X11Keys(fromX11KeySym: 0x005b)  /* U+005B LEFT SQUARE BRACKET */
    static let XK_backslash = X11Keys(fromX11KeySym: 0x005c)  /* U+005C REVERSE SOLIDUS */
    static let XK_bracketright = X11Keys(fromX11KeySym: 0x005d)  /* U+005D RIGHT SQUARE BRACKET */
    static let XK_asciicircum = X11Keys(fromX11KeySym: 0x005e)  /* U+005E CIRCUMFLEX ACCENT */
    static let XK_underscore = X11Keys(fromX11KeySym: 0x005f)  /* U+005F LOW LINE */
    static let XK_grave = X11Keys(fromX11KeySym: 0x0060)  /* U+0060 GRAVE ACCENT */
    static let XK_quoteleft = X11Keys(fromX11KeySym: 0x0060)  /* deprecated */
    static let XK_a = X11Keys(fromX11KeySym: 0x0061)  /* U+0061 LATIN SMALL LETTER A */
    static let XK_b = X11Keys(fromX11KeySym: 0x0062)  /* U+0062 LATIN SMALL LETTER B */
    static let XK_c = X11Keys(fromX11KeySym: 0x0063)  /* U+0063 LATIN SMALL LETTER C */
    static let XK_d = X11Keys(fromX11KeySym: 0x0064)  /* U+0064 LATIN SMALL LETTER D */
    static let XK_e = X11Keys(fromX11KeySym: 0x0065)  /* U+0065 LATIN SMALL LETTER E */
    static let XK_f = X11Keys(fromX11KeySym: 0x0066)  /* U+0066 LATIN SMALL LETTER F */
    static let XK_g = X11Keys(fromX11KeySym: 0x0067)  /* U+0067 LATIN SMALL LETTER G */
    static let XK_h = X11Keys(fromX11KeySym: 0x0068)  /* U+0068 LATIN SMALL LETTER H */
    static let XK_i = X11Keys(fromX11KeySym: 0x0069)  /* U+0069 LATIN SMALL LETTER I */
    static let XK_j = X11Keys(fromX11KeySym: 0x006a)  /* U+006A LATIN SMALL LETTER J */
    static let XK_k = X11Keys(fromX11KeySym: 0x006b)  /* U+006B LATIN SMALL LETTER K */
    static let XK_l = X11Keys(fromX11KeySym: 0x006c)  /* U+006C LATIN SMALL LETTER L */
    static let XK_m = X11Keys(fromX11KeySym: 0x006d)  /* U+006D LATIN SMALL LETTER M */
    static let XK_n = X11Keys(fromX11KeySym: 0x006e)  /* U+006E LATIN SMALL LETTER N */
    static let XK_o = X11Keys(fromX11KeySym: 0x006f)  /* U+006F LATIN SMALL LETTER O */
    static let XK_p = X11Keys(fromX11KeySym: 0x0070)  /* U+0070 LATIN SMALL LETTER P */
    static let XK_q = X11Keys(fromX11KeySym: 0x0071)  /* U+0071 LATIN SMALL LETTER Q */
    static let XK_r = X11Keys(fromX11KeySym: 0x0072)  /* U+0072 LATIN SMALL LETTER R */
    static let XK_s = X11Keys(fromX11KeySym: 0x0073)  /* U+0073 LATIN SMALL LETTER S */
    static let XK_t = X11Keys(fromX11KeySym: 0x0074)  /* U+0074 LATIN SMALL LETTER T */
    static let XK_u = X11Keys(fromX11KeySym: 0x0075)  /* U+0075 LATIN SMALL LETTER U */
    static let XK_v = X11Keys(fromX11KeySym: 0x0076)  /* U+0076 LATIN SMALL LETTER V */
    static let XK_w = X11Keys(fromX11KeySym: 0x0077)  /* U+0077 LATIN SMALL LETTER W */
    static let XK_x = X11Keys(fromX11KeySym: 0x0078)  /* U+0078 LATIN SMALL LETTER X */
    static let XK_y = X11Keys(fromX11KeySym: 0x0079)  /* U+0079 LATIN SMALL LETTER Y */
    static let XK_z = X11Keys(fromX11KeySym: 0x007a)  /* U+007A LATIN SMALL LETTER Z */
    static let XK_braceleft = X11Keys(fromX11KeySym: 0x007b)  /* U+007B LEFT CURLY BRACKET */
    static let XK_bar = X11Keys(fromX11KeySym: 0x007c)  /* U+007C VERTICAL LINE */
    static let XK_braceright = X11Keys(fromX11KeySym: 0x007d)  /* U+007D RIGHT CURLY BRACKET */
    static let XK_asciitilde = X11Keys(fromX11KeySym: 0x007e)  /* U+007E TILDE */

    static let XK_nobreakspace = X11Keys(fromX11KeySym: 0x00a0)  /* U+00A0 NO-BREAK SPACE */
    static let XK_exclamdown = X11Keys(fromX11KeySym: 0x00a1)  /* U+00A1 INVERTED EXCLAMATION MARK */
    static let XK_cent = X11Keys(fromX11KeySym: 0x00a2)  /* U+00A2 CENT SIGN */
    static let XK_sterling = X11Keys(fromX11KeySym: 0x00a3)  /* U+00A3 POUND SIGN */
    static let XK_currency = X11Keys(fromX11KeySym: 0x00a4)  /* U+00A4 CURRENCY SIGN */
    static let XK_yen = X11Keys(fromX11KeySym: 0x00a5)  /* U+00A5 YEN SIGN */
    static let XK_brokenbar = X11Keys(fromX11KeySym: 0x00a6)  /* U+00A6 BROKEN BAR */
    static let XK_section = X11Keys(fromX11KeySym: 0x00a7)  /* U+00A7 SECTION SIGN */
    static let XK_diaeresis = X11Keys(fromX11KeySym: 0x00a8)  /* U+00A8 DIAERESIS */
    static let XK_copyright = X11Keys(fromX11KeySym: 0x00a9)  /* U+00A9 COPYRIGHT SIGN */
    static let XK_ordfeminine = X11Keys(fromX11KeySym: 0x00aa)  /* U+00AA FEMININE ORDINAL INDICATOR */
    static let XK_guillemetleft = X11Keys(fromX11KeySym: 0x00ab)  /* U+00AB LEFT-POINTING DOUBLE ANGLE QUOTATION MARK */
    static let XK_guillemotleft = X11Keys(fromX11KeySym: 0x00ab)  /* deprecated misspelling */
    static let XK_notsign = X11Keys(fromX11KeySym: 0x00ac)  /* U+00AC NOT SIGN */
    static let XK_hyphen = X11Keys(fromX11KeySym: 0x00ad)  /* U+00AD SOFT HYPHEN */
    static let XK_registered = X11Keys(fromX11KeySym: 0x00ae)  /* U+00AE REGISTERED SIGN */
    static let XK_macron = X11Keys(fromX11KeySym: 0x00af)  /* U+00AF MACRON */
    static let XK_degree = X11Keys(fromX11KeySym: 0x00b0)  /* U+00B0 DEGREE SIGN */
    static let XK_plusminus = X11Keys(fromX11KeySym: 0x00b1)  /* U+00B1 PLUS-MINUS SIGN */
    static let XK_twosuperior = X11Keys(fromX11KeySym: 0x00b2)  /* U+00B2 SUPERSCRIPT TWO */
    static let XK_threesuperior = X11Keys(fromX11KeySym: 0x00b3)  /* U+00B3 SUPERSCRIPT THREE */
    static let XK_acute = X11Keys(fromX11KeySym: 0x00b4)  /* U+00B4 ACUTE ACCENT */
    static let XK_mu = X11Keys(fromX11KeySym: 0x00b5)  /* U+00B5 MICRO SIGN */
    static let XK_paragraph = X11Keys(fromX11KeySym: 0x00b6)  /* U+00B6 PILCROW SIGN */
    static let XK_periodcentered = X11Keys(fromX11KeySym: 0x00b7)  /* U+00B7 MIDDLE DOT */
    static let XK_cedilla = X11Keys(fromX11KeySym: 0x00b8)  /* U+00B8 CEDILLA */
    static let XK_onesuperior = X11Keys(fromX11KeySym: 0x00b9)  /* U+00B9 SUPERSCRIPT ONE */
    static let XK_ordmasculine = X11Keys(fromX11KeySym: 0x00ba)  /* U+00BA MASCULINE ORDINAL INDICATOR */
    static let XK_masculine = X11Keys(fromX11KeySym: 0x00ba)  /* deprecated inconsistent name */
    static let XK_guillemetright = X11Keys(fromX11KeySym: 0x00bb)  /* U+00BB RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK */
    static let XK_guillemotright = X11Keys(fromX11KeySym: 0x00bb)  /* deprecated misspelling */
    static let XK_onequarter = X11Keys(fromX11KeySym: 0x00bc)  /* U+00BC VULGAR FRACTION ONE QUARTER */
    static let XK_onehalf = X11Keys(fromX11KeySym: 0x00bd)  /* U+00BD VULGAR FRACTION ONE HALF */
    static let XK_threequarters = X11Keys(fromX11KeySym: 0x00be)  /* U+00BE VULGAR FRACTION THREE QUARTERS */
    static let XK_questiondown = X11Keys(fromX11KeySym: 0x00bf)  /* U+00BF INVERTED QUESTION MARK */
    static let XK_Agrave = X11Keys(fromX11KeySym: 0x00c0)  /* U+00C0 LATIN CAPITAL LETTER A WITH GRAVE */
    static let XK_Aacute = X11Keys(fromX11KeySym: 0x00c1)  /* U+00C1 LATIN CAPITAL LETTER A WITH ACUTE */
    static let XK_Acircumflex = X11Keys(fromX11KeySym: 0x00c2)  /* U+00C2 LATIN CAPITAL LETTER A WITH CIRCUMFLEX */
    static let XK_Atilde = X11Keys(fromX11KeySym: 0x00c3)  /* U+00C3 LATIN CAPITAL LETTER A WITH TILDE */
    static let XK_Adiaeresis = X11Keys(fromX11KeySym: 0x00c4)  /* U+00C4 LATIN CAPITAL LETTER A WITH DIAERESIS */
    static let XK_Aring = X11Keys(fromX11KeySym: 0x00c5)  /* U+00C5 LATIN CAPITAL LETTER A WITH RING ABOVE */
    static let XK_AE = X11Keys(fromX11KeySym: 0x00c6)  /* U+00C6 LATIN CAPITAL LETTER AE */
    static let XK_Ccedilla = X11Keys(fromX11KeySym: 0x00c7)  /* U+00C7 LATIN CAPITAL LETTER C WITH CEDILLA */
    static let XK_Egrave = X11Keys(fromX11KeySym: 0x00c8)  /* U+00C8 LATIN CAPITAL LETTER E WITH GRAVE */
    static let XK_Eacute = X11Keys(fromX11KeySym: 0x00c9)  /* U+00C9 LATIN CAPITAL LETTER E WITH ACUTE */
    static let XK_Ecircumflex = X11Keys(fromX11KeySym: 0x00ca)  /* U+00CA LATIN CAPITAL LETTER E WITH CIRCUMFLEX */
    static let XK_Ediaeresis = X11Keys(fromX11KeySym: 0x00cb)  /* U+00CB LATIN CAPITAL LETTER E WITH DIAERESIS */
    static let XK_Igrave = X11Keys(fromX11KeySym: 0x00cc)  /* U+00CC LATIN CAPITAL LETTER I WITH GRAVE */
    static let XK_Iacute = X11Keys(fromX11KeySym: 0x00cd)  /* U+00CD LATIN CAPITAL LETTER I WITH ACUTE */
    static let XK_Icircumflex = X11Keys(fromX11KeySym: 0x00ce)  /* U+00CE LATIN CAPITAL LETTER I WITH CIRCUMFLEX */
    static let XK_Idiaeresis = X11Keys(fromX11KeySym: 0x00cf)  /* U+00CF LATIN CAPITAL LETTER I WITH DIAERESIS */
    static let XK_ETH = X11Keys(fromX11KeySym: 0x00d0)  /* U+00D0 LATIN CAPITAL LETTER ETH */
    static let XK_Eth = X11Keys(fromX11KeySym: 0x00d0)  /* deprecated */
    static let XK_Ntilde = X11Keys(fromX11KeySym: 0x00d1)  /* U+00D1 LATIN CAPITAL LETTER N WITH TILDE */
    static let XK_Ograve = X11Keys(fromX11KeySym: 0x00d2)  /* U+00D2 LATIN CAPITAL LETTER O WITH GRAVE */
    static let XK_Oacute = X11Keys(fromX11KeySym: 0x00d3)  /* U+00D3 LATIN CAPITAL LETTER O WITH ACUTE */
    static let XK_Ocircumflex = X11Keys(fromX11KeySym: 0x00d4)  /* U+00D4 LATIN CAPITAL LETTER O WITH CIRCUMFLEX */
    static let XK_Otilde = X11Keys(fromX11KeySym: 0x00d5)  /* U+00D5 LATIN CAPITAL LETTER O WITH TILDE */
    static let XK_Odiaeresis = X11Keys(fromX11KeySym: 0x00d6)  /* U+00D6 LATIN CAPITAL LETTER O WITH DIAERESIS */
    static let XK_multiply = X11Keys(fromX11KeySym: 0x00d7)  /* U+00D7 MULTIPLICATION SIGN */
    static let XK_Oslash = X11Keys(fromX11KeySym: 0x00d8)  /* U+00D8 LATIN CAPITAL LETTER O WITH STROKE */
    static let XK_Ooblique = X11Keys(fromX11KeySym: 0x00d8)  /* U+00D8 LATIN CAPITAL LETTER O WITH STROKE */
    static let XK_Ugrave = X11Keys(fromX11KeySym: 0x00d9)  /* U+00D9 LATIN CAPITAL LETTER U WITH GRAVE */
    static let XK_Uacute = X11Keys(fromX11KeySym: 0x00da)  /* U+00DA LATIN CAPITAL LETTER U WITH ACUTE */
    static let XK_Ucircumflex = X11Keys(fromX11KeySym: 0x00db)  /* U+00DB LATIN CAPITAL LETTER U WITH CIRCUMFLEX */
    static let XK_Udiaeresis = X11Keys(fromX11KeySym: 0x00dc)  /* U+00DC LATIN CAPITAL LETTER U WITH DIAERESIS */
    static let XK_Yacute = X11Keys(fromX11KeySym: 0x00dd)  /* U+00DD LATIN CAPITAL LETTER Y WITH ACUTE */
    static let XK_THORN = X11Keys(fromX11KeySym: 0x00de)  /* U+00DE LATIN CAPITAL LETTER THORN */
    static let XK_Thorn = X11Keys(fromX11KeySym: 0x00de)  /* deprecated */
    static let XK_ssharp = X11Keys(fromX11KeySym: 0x00df)  /* U+00DF LATIN SMALL LETTER SHARP S */
    static let XK_agrave = X11Keys(fromX11KeySym: 0x00e0)  /* U+00E0 LATIN SMALL LETTER A WITH GRAVE */
    static let XK_aacute = X11Keys(fromX11KeySym: 0x00e1)  /* U+00E1 LATIN SMALL LETTER A WITH ACUTE */
    static let XK_acircumflex = X11Keys(fromX11KeySym: 0x00e2)  /* U+00E2 LATIN SMALL LETTER A WITH CIRCUMFLEX */
    static let XK_atilde = X11Keys(fromX11KeySym: 0x00e3)  /* U+00E3 LATIN SMALL LETTER A WITH TILDE */
    static let XK_adiaeresis = X11Keys(fromX11KeySym: 0x00e4)  /* U+00E4 LATIN SMALL LETTER A WITH DIAERESIS */
    static let XK_aring = X11Keys(fromX11KeySym: 0x00e5)  /* U+00E5 LATIN SMALL LETTER A WITH RING ABOVE */
    static let XK_ae = X11Keys(fromX11KeySym: 0x00e6)  /* U+00E6 LATIN SMALL LETTER AE */
    static let XK_ccedilla = X11Keys(fromX11KeySym: 0x00e7)  /* U+00E7 LATIN SMALL LETTER C WITH CEDILLA */
    static let XK_egrave = X11Keys(fromX11KeySym: 0x00e8)  /* U+00E8 LATIN SMALL LETTER E WITH GRAVE */
    static let XK_eacute = X11Keys(fromX11KeySym: 0x00e9)  /* U+00E9 LATIN SMALL LETTER E WITH ACUTE */
    static let XK_ecircumflex = X11Keys(fromX11KeySym: 0x00ea)  /* U+00EA LATIN SMALL LETTER E WITH CIRCUMFLEX */
    static let XK_ediaeresis = X11Keys(fromX11KeySym: 0x00eb)  /* U+00EB LATIN SMALL LETTER E WITH DIAERESIS */
    static let XK_igrave = X11Keys(fromX11KeySym: 0x00ec)  /* U+00EC LATIN SMALL LETTER I WITH GRAVE */
    static let XK_iacute = X11Keys(fromX11KeySym: 0x00ed)  /* U+00ED LATIN SMALL LETTER I WITH ACUTE */
    static let XK_icircumflex = X11Keys(fromX11KeySym: 0x00ee)  /* U+00EE LATIN SMALL LETTER I WITH CIRCUMFLEX */
    static let XK_idiaeresis = X11Keys(fromX11KeySym: 0x00ef)  /* U+00EF LATIN SMALL LETTER I WITH DIAERESIS */
    static let XK_eth = X11Keys(fromX11KeySym: 0x00f0)  /* U+00F0 LATIN SMALL LETTER ETH */
    static let XK_ntilde = X11Keys(fromX11KeySym: 0x00f1)  /* U+00F1 LATIN SMALL LETTER N WITH TILDE */
    static let XK_ograve = X11Keys(fromX11KeySym: 0x00f2)  /* U+00F2 LATIN SMALL LETTER O WITH GRAVE */
    static let XK_oacute = X11Keys(fromX11KeySym: 0x00f3)  /* U+00F3 LATIN SMALL LETTER O WITH ACUTE */
    static let XK_ocircumflex = X11Keys(fromX11KeySym: 0x00f4)  /* U+00F4 LATIN SMALL LETTER O WITH CIRCUMFLEX */
    static let XK_otilde = X11Keys(fromX11KeySym: 0x00f5)  /* U+00F5 LATIN SMALL LETTER O WITH TILDE */
    static let XK_odiaeresis = X11Keys(fromX11KeySym: 0x00f6)  /* U+00F6 LATIN SMALL LETTER O WITH DIAERESIS */
    static let XK_division = X11Keys(fromX11KeySym: 0x00f7)  /* U+00F7 DIVISION SIGN */
    static let XK_oslash = X11Keys(fromX11KeySym: 0x00f8)  /* U+00F8 LATIN SMALL LETTER O WITH STROKE */
    static let XK_ooblique = X11Keys(fromX11KeySym: 0x00f8)  /* U+00F8 LATIN SMALL LETTER O WITH STROKE */
    static let XK_ugrave = X11Keys(fromX11KeySym: 0x00f9)  /* U+00F9 LATIN SMALL LETTER U WITH GRAVE */
    static let XK_uacute = X11Keys(fromX11KeySym: 0x00fa)  /* U+00FA LATIN SMALL LETTER U WITH ACUTE */
    static let XK_ucircumflex = X11Keys(fromX11KeySym: 0x00fb)  /* U+00FB LATIN SMALL LETTER U WITH CIRCUMFLEX */
    static let XK_udiaeresis = X11Keys(fromX11KeySym: 0x00fc)  /* U+00FC LATIN SMALL LETTER U WITH DIAERESIS */
    static let XK_yacute = X11Keys(fromX11KeySym: 0x00fd)  /* U+00FD LATIN SMALL LETTER Y WITH ACUTE */
    static let XK_thorn = X11Keys(fromX11KeySym: 0x00fe)  /* U+00FE LATIN SMALL LETTER THORN */
    static let XK_ydiaeresis = X11Keys(fromX11KeySym: 0x00ff)  /* U+00FF LATIN SMALL LETTER Y WITH DIAERESIS */

    /*
    * Latin 2
    * Byte 3 = 1
    */

    static let XK_Aogonek = X11Keys(fromX11KeySym: 0x01a1)  /* U+0104 LATIN CAPITAL LETTER A WITH OGONEK */
    static let XK_breve = X11Keys(fromX11KeySym: 0x01a2)  /* U+02D8 BREVE */
    static let XK_Lstroke = X11Keys(fromX11KeySym: 0x01a3)  /* U+0141 LATIN CAPITAL LETTER L WITH STROKE */
    static let XK_Lcaron = X11Keys(fromX11KeySym: 0x01a5)  /* U+013D LATIN CAPITAL LETTER L WITH CARON */
    static let XK_Sacute = X11Keys(fromX11KeySym: 0x01a6)  /* U+015A LATIN CAPITAL LETTER S WITH ACUTE */
    static let XK_Scaron = X11Keys(fromX11KeySym: 0x01a9)  /* U+0160 LATIN CAPITAL LETTER S WITH CARON */
    static let XK_Scedilla = X11Keys(fromX11KeySym: 0x01aa)  /* U+015E LATIN CAPITAL LETTER S WITH CEDILLA */
    static let XK_Tcaron = X11Keys(fromX11KeySym: 0x01ab)  /* U+0164 LATIN CAPITAL LETTER T WITH CARON */
    static let XK_Zacute = X11Keys(fromX11KeySym: 0x01ac)  /* U+0179 LATIN CAPITAL LETTER Z WITH ACUTE */
    static let XK_Zcaron = X11Keys(fromX11KeySym: 0x01ae)  /* U+017D LATIN CAPITAL LETTER Z WITH CARON */
    static let XK_Zabovedot = X11Keys(fromX11KeySym: 0x01af)  /* U+017B LATIN CAPITAL LETTER Z WITH DOT ABOVE */
    static let XK_aogonek = X11Keys(fromX11KeySym: 0x01b1)  /* U+0105 LATIN SMALL LETTER A WITH OGONEK */
    static let XK_ogonek = X11Keys(fromX11KeySym: 0x01b2)  /* U+02DB OGONEK */
    static let XK_lstroke = X11Keys(fromX11KeySym: 0x01b3)  /* U+0142 LATIN SMALL LETTER L WITH STROKE */
    static let XK_lcaron = X11Keys(fromX11KeySym: 0x01b5)  /* U+013E LATIN SMALL LETTER L WITH CARON */
    static let XK_sacute = X11Keys(fromX11KeySym: 0x01b6)  /* U+015B LATIN SMALL LETTER S WITH ACUTE */
    static let XK_caron = X11Keys(fromX11KeySym: 0x01b7)  /* U+02C7 CARON */
    static let XK_scaron = X11Keys(fromX11KeySym: 0x01b9)  /* U+0161 LATIN SMALL LETTER S WITH CARON */
    static let XK_scedilla = X11Keys(fromX11KeySym: 0x01ba)  /* U+015F LATIN SMALL LETTER S WITH CEDILLA */
    static let XK_tcaron = X11Keys(fromX11KeySym: 0x01bb)  /* U+0165 LATIN SMALL LETTER T WITH CARON */
    static let XK_zacute = X11Keys(fromX11KeySym: 0x01bc)  /* U+017A LATIN SMALL LETTER Z WITH ACUTE */
    static let XK_doubleacute = X11Keys(fromX11KeySym: 0x01bd)  /* U+02DD DOUBLE ACUTE ACCENT */
    static let XK_zcaron = X11Keys(fromX11KeySym: 0x01be)  /* U+017E LATIN SMALL LETTER Z WITH CARON */
    static let XK_zabovedot = X11Keys(fromX11KeySym: 0x01bf)  /* U+017C LATIN SMALL LETTER Z WITH DOT ABOVE */
    static let XK_Racute = X11Keys(fromX11KeySym: 0x01c0)  /* U+0154 LATIN CAPITAL LETTER R WITH ACUTE */
    static let XK_Abreve = X11Keys(fromX11KeySym: 0x01c3)  /* U+0102 LATIN CAPITAL LETTER A WITH BREVE */
    static let XK_Lacute = X11Keys(fromX11KeySym: 0x01c5)  /* U+0139 LATIN CAPITAL LETTER L WITH ACUTE */
    static let XK_Cacute = X11Keys(fromX11KeySym: 0x01c6)  /* U+0106 LATIN CAPITAL LETTER C WITH ACUTE */
    static let XK_Ccaron = X11Keys(fromX11KeySym: 0x01c8)  /* U+010C LATIN CAPITAL LETTER C WITH CARON */
    static let XK_Eogonek = X11Keys(fromX11KeySym: 0x01ca)  /* U+0118 LATIN CAPITAL LETTER E WITH OGONEK */
    static let XK_Ecaron = X11Keys(fromX11KeySym: 0x01cc)  /* U+011A LATIN CAPITAL LETTER E WITH CARON */
    static let XK_Dcaron = X11Keys(fromX11KeySym: 0x01cf)  /* U+010E LATIN CAPITAL LETTER D WITH CARON */
    static let XK_Dstroke = X11Keys(fromX11KeySym: 0x01d0)  /* U+0110 LATIN CAPITAL LETTER D WITH STROKE */
    static let XK_Nacute = X11Keys(fromX11KeySym: 0x01d1)  /* U+0143 LATIN CAPITAL LETTER N WITH ACUTE */
    static let XK_Ncaron = X11Keys(fromX11KeySym: 0x01d2)  /* U+0147 LATIN CAPITAL LETTER N WITH CARON */
    static let XK_Odoubleacute = X11Keys(fromX11KeySym: 0x01d5)  /* U+0150 LATIN CAPITAL LETTER O WITH DOUBLE ACUTE */
    static let XK_Rcaron = X11Keys(fromX11KeySym: 0x01d8)  /* U+0158 LATIN CAPITAL LETTER R WITH CARON */
    static let XK_Uring = X11Keys(fromX11KeySym: 0x01d9)  /* U+016E LATIN CAPITAL LETTER U WITH RING ABOVE */
    static let XK_Udoubleacute = X11Keys(fromX11KeySym: 0x01db)  /* U+0170 LATIN CAPITAL LETTER U WITH DOUBLE ACUTE */
    static let XK_Tcedilla = X11Keys(fromX11KeySym: 0x01de)  /* U+0162 LATIN CAPITAL LETTER T WITH CEDILLA */
    static let XK_racute = X11Keys(fromX11KeySym: 0x01e0)  /* U+0155 LATIN SMALL LETTER R WITH ACUTE */
    static let XK_abreve = X11Keys(fromX11KeySym: 0x01e3)  /* U+0103 LATIN SMALL LETTER A WITH BREVE */
    static let XK_lacute = X11Keys(fromX11KeySym: 0x01e5)  /* U+013A LATIN SMALL LETTER L WITH ACUTE */
    static let XK_cacute = X11Keys(fromX11KeySym: 0x01e6)  /* U+0107 LATIN SMALL LETTER C WITH ACUTE */
    static let XK_ccaron = X11Keys(fromX11KeySym: 0x01e8)  /* U+010D LATIN SMALL LETTER C WITH CARON */
    static let XK_eogonek = X11Keys(fromX11KeySym: 0x01ea)  /* U+0119 LATIN SMALL LETTER E WITH OGONEK */
    static let XK_ecaron = X11Keys(fromX11KeySym: 0x01ec)  /* U+011B LATIN SMALL LETTER E WITH CARON */
    static let XK_dcaron = X11Keys(fromX11KeySym: 0x01ef)  /* U+010F LATIN SMALL LETTER D WITH CARON */
    static let XK_dstroke = X11Keys(fromX11KeySym: 0x01f0)  /* U+0111 LATIN SMALL LETTER D WITH STROKE */
    static let XK_nacute = X11Keys(fromX11KeySym: 0x01f1)  /* U+0144 LATIN SMALL LETTER N WITH ACUTE */
    static let XK_ncaron = X11Keys(fromX11KeySym: 0x01f2)  /* U+0148 LATIN SMALL LETTER N WITH CARON */
    static let XK_odoubleacute = X11Keys(fromX11KeySym: 0x01f5)  /* U+0151 LATIN SMALL LETTER O WITH DOUBLE ACUTE */
    static let XK_rcaron = X11Keys(fromX11KeySym: 0x01f8)  /* U+0159 LATIN SMALL LETTER R WITH CARON */
    static let XK_uring = X11Keys(fromX11KeySym: 0x01f9)  /* U+016F LATIN SMALL LETTER U WITH RING ABOVE */
    static let XK_udoubleacute = X11Keys(fromX11KeySym: 0x01fb)  /* U+0171 LATIN SMALL LETTER U WITH DOUBLE ACUTE */
    static let XK_tcedilla = X11Keys(fromX11KeySym: 0x01fe)  /* U+0163 LATIN SMALL LETTER T WITH CEDILLA */
    static let XK_abovedot = X11Keys(fromX11KeySym: 0x01ff)  /* U+02D9 DOT ABOVE */

    /*
    * Latin 3
    * Byte 3 = 2
    */

    static let XK_Hstroke = X11Keys(fromX11KeySym: 0x02a1)  /* U+0126 LATIN CAPITAL LETTER H WITH STROKE */
    static let XK_Hcircumflex = X11Keys(fromX11KeySym: 0x02a6)  /* U+0124 LATIN CAPITAL LETTER H WITH CIRCUMFLEX */
    static let XK_Iabovedot = X11Keys(fromX11KeySym: 0x02a9)  /* U+0130 LATIN CAPITAL LETTER I WITH DOT ABOVE */
    static let XK_Gbreve = X11Keys(fromX11KeySym: 0x02ab)  /* U+011E LATIN CAPITAL LETTER G WITH BREVE */
    static let XK_Jcircumflex = X11Keys(fromX11KeySym: 0x02ac)  /* U+0134 LATIN CAPITAL LETTER J WITH CIRCUMFLEX */
    static let XK_hstroke = X11Keys(fromX11KeySym: 0x02b1)  /* U+0127 LATIN SMALL LETTER H WITH STROKE */
    static let XK_hcircumflex = X11Keys(fromX11KeySym: 0x02b6)  /* U+0125 LATIN SMALL LETTER H WITH CIRCUMFLEX */
    static let XK_idotless = X11Keys(fromX11KeySym: 0x02b9)  /* U+0131 LATIN SMALL LETTER DOTLESS I */
    static let XK_gbreve = X11Keys(fromX11KeySym: 0x02bb)  /* U+011F LATIN SMALL LETTER G WITH BREVE */
    static let XK_jcircumflex = X11Keys(fromX11KeySym: 0x02bc)  /* U+0135 LATIN SMALL LETTER J WITH CIRCUMFLEX */
    static let XK_Cabovedot = X11Keys(fromX11KeySym: 0x02c5)  /* U+010A LATIN CAPITAL LETTER C WITH DOT ABOVE */
    static let XK_Ccircumflex = X11Keys(fromX11KeySym: 0x02c6)  /* U+0108 LATIN CAPITAL LETTER C WITH CIRCUMFLEX */
    static let XK_Gabovedot = X11Keys(fromX11KeySym: 0x02d5)  /* U+0120 LATIN CAPITAL LETTER G WITH DOT ABOVE */
    static let XK_Gcircumflex = X11Keys(fromX11KeySym: 0x02d8)  /* U+011C LATIN CAPITAL LETTER G WITH CIRCUMFLEX */
    static let XK_Ubreve = X11Keys(fromX11KeySym: 0x02dd)  /* U+016C LATIN CAPITAL LETTER U WITH BREVE */
    static let XK_Scircumflex = X11Keys(fromX11KeySym: 0x02de)  /* U+015C LATIN CAPITAL LETTER S WITH CIRCUMFLEX */
    static let XK_cabovedot = X11Keys(fromX11KeySym: 0x02e5)  /* U+010B LATIN SMALL LETTER C WITH DOT ABOVE */
    static let XK_ccircumflex = X11Keys(fromX11KeySym: 0x02e6)  /* U+0109 LATIN SMALL LETTER C WITH CIRCUMFLEX */
    static let XK_gabovedot = X11Keys(fromX11KeySym: 0x02f5)  /* U+0121 LATIN SMALL LETTER G WITH DOT ABOVE */
    static let XK_gcircumflex = X11Keys(fromX11KeySym: 0x02f8)  /* U+011D LATIN SMALL LETTER G WITH CIRCUMFLEX */
    static let XK_ubreve = X11Keys(fromX11KeySym: 0x02fd)  /* U+016D LATIN SMALL LETTER U WITH BREVE */
    static let XK_scircumflex = X11Keys(fromX11KeySym: 0x02fe)  /* U+015D LATIN SMALL LETTER S WITH CIRCUMFLEX */


    /*
    * Latin 4
    * Byte 3 = 3
    */

    static let XK_kra = X11Keys(fromX11KeySym: 0x03a2)  /* U+0138 LATIN SMALL LETTER KRA */
    static let XK_kappa = X11Keys(fromX11KeySym: 0x03a2)  /* deprecated */
    static let XK_Rcedilla = X11Keys(fromX11KeySym: 0x03a3)  /* U+0156 LATIN CAPITAL LETTER R WITH CEDILLA */
    static let XK_Itilde = X11Keys(fromX11KeySym: 0x03a5)  /* U+0128 LATIN CAPITAL LETTER I WITH TILDE */
    static let XK_Lcedilla = X11Keys(fromX11KeySym: 0x03a6)  /* U+013B LATIN CAPITAL LETTER L WITH CEDILLA */
    static let XK_Emacron = X11Keys(fromX11KeySym: 0x03aa)  /* U+0112 LATIN CAPITAL LETTER E WITH MACRON */
    static let XK_Gcedilla = X11Keys(fromX11KeySym: 0x03ab)  /* U+0122 LATIN CAPITAL LETTER G WITH CEDILLA */
    static let XK_Tslash = X11Keys(fromX11KeySym: 0x03ac)  /* U+0166 LATIN CAPITAL LETTER T WITH STROKE */
    static let XK_rcedilla = X11Keys(fromX11KeySym: 0x03b3)  /* U+0157 LATIN SMALL LETTER R WITH CEDILLA */
    static let XK_itilde = X11Keys(fromX11KeySym: 0x03b5)  /* U+0129 LATIN SMALL LETTER I WITH TILDE */
    static let XK_lcedilla = X11Keys(fromX11KeySym: 0x03b6)  /* U+013C LATIN SMALL LETTER L WITH CEDILLA */
    static let XK_emacron = X11Keys(fromX11KeySym: 0x03ba)  /* U+0113 LATIN SMALL LETTER E WITH MACRON */
    static let XK_gcedilla = X11Keys(fromX11KeySym: 0x03bb)  /* U+0123 LATIN SMALL LETTER G WITH CEDILLA */
    static let XK_tslash = X11Keys(fromX11KeySym: 0x03bc)  /* U+0167 LATIN SMALL LETTER T WITH STROKE */
    static let XK_ENG = X11Keys(fromX11KeySym: 0x03bd)  /* U+014A LATIN CAPITAL LETTER ENG */
    static let XK_eng = X11Keys(fromX11KeySym: 0x03bf)  /* U+014B LATIN SMALL LETTER ENG */
    static let XK_Amacron = X11Keys(fromX11KeySym: 0x03c0)  /* U+0100 LATIN CAPITAL LETTER A WITH MACRON */
    static let XK_Iogonek = X11Keys(fromX11KeySym: 0x03c7)  /* U+012E LATIN CAPITAL LETTER I WITH OGONEK */
    static let XK_Eabovedot = X11Keys(fromX11KeySym: 0x03cc)  /* U+0116 LATIN CAPITAL LETTER E WITH DOT ABOVE */
    static let XK_Imacron = X11Keys(fromX11KeySym: 0x03cf)  /* U+012A LATIN CAPITAL LETTER I WITH MACRON */
    static let XK_Ncedilla = X11Keys(fromX11KeySym: 0x03d1)  /* U+0145 LATIN CAPITAL LETTER N WITH CEDILLA */
    static let XK_Omacron = X11Keys(fromX11KeySym: 0x03d2)  /* U+014C LATIN CAPITAL LETTER O WITH MACRON */
    static let XK_Kcedilla = X11Keys(fromX11KeySym: 0x03d3)  /* U+0136 LATIN CAPITAL LETTER K WITH CEDILLA */
    static let XK_Uogonek = X11Keys(fromX11KeySym: 0x03d9)  /* U+0172 LATIN CAPITAL LETTER U WITH OGONEK */
    static let XK_Utilde = X11Keys(fromX11KeySym: 0x03dd)  /* U+0168 LATIN CAPITAL LETTER U WITH TILDE */
    static let XK_Umacron = X11Keys(fromX11KeySym: 0x03de)  /* U+016A LATIN CAPITAL LETTER U WITH MACRON */
    static let XK_amacron = X11Keys(fromX11KeySym: 0x03e0)  /* U+0101 LATIN SMALL LETTER A WITH MACRON */
    static let XK_iogonek = X11Keys(fromX11KeySym: 0x03e7)  /* U+012F LATIN SMALL LETTER I WITH OGONEK */
    static let XK_eabovedot = X11Keys(fromX11KeySym: 0x03ec)  /* U+0117 LATIN SMALL LETTER E WITH DOT ABOVE */
    static let XK_imacron = X11Keys(fromX11KeySym: 0x03ef)  /* U+012B LATIN SMALL LETTER I WITH MACRON */
    static let XK_ncedilla = X11Keys(fromX11KeySym: 0x03f1)  /* U+0146 LATIN SMALL LETTER N WITH CEDILLA */
    static let XK_omacron = X11Keys(fromX11KeySym: 0x03f2)  /* U+014D LATIN SMALL LETTER O WITH MACRON */
    static let XK_kcedilla = X11Keys(fromX11KeySym: 0x03f3)  /* U+0137 LATIN SMALL LETTER K WITH CEDILLA */
    static let XK_uogonek = X11Keys(fromX11KeySym: 0x03f9)  /* U+0173 LATIN SMALL LETTER U WITH OGONEK */
    static let XK_utilde = X11Keys(fromX11KeySym: 0x03fd)  /* U+0169 LATIN SMALL LETTER U WITH TILDE */
    static let XK_umacron = X11Keys(fromX11KeySym: 0x03fe)  /* U+016B LATIN SMALL LETTER U WITH MACRON */

    /*
    * Latin 8
    */
    static let XK_Wcircumflex = X11Keys(fromX11KeySym: 0x1000174)  /* U+0174 LATIN CAPITAL LETTER W WITH CIRCUMFLEX */
    static let XK_wcircumflex = X11Keys(fromX11KeySym: 0x1000175)  /* U+0175 LATIN SMALL LETTER W WITH CIRCUMFLEX */
    static let XK_Ycircumflex = X11Keys(fromX11KeySym: 0x1000176)  /* U+0176 LATIN CAPITAL LETTER Y WITH CIRCUMFLEX */
    static let XK_ycircumflex = X11Keys(fromX11KeySym: 0x1000177)  /* U+0177 LATIN SMALL LETTER Y WITH CIRCUMFLEX */
    static let XK_Babovedot = X11Keys(fromX11KeySym: 0x1001e02)  /* U+1E02 LATIN CAPITAL LETTER B WITH DOT ABOVE */
    static let XK_babovedot = X11Keys(fromX11KeySym: 0x1001e03)  /* U+1E03 LATIN SMALL LETTER B WITH DOT ABOVE */
    static let XK_Dabovedot = X11Keys(fromX11KeySym: 0x1001e0a)  /* U+1E0A LATIN CAPITAL LETTER D WITH DOT ABOVE */
    static let XK_dabovedot = X11Keys(fromX11KeySym: 0x1001e0b)  /* U+1E0B LATIN SMALL LETTER D WITH DOT ABOVE */
    static let XK_Fabovedot = X11Keys(fromX11KeySym: 0x1001e1e)  /* U+1E1E LATIN CAPITAL LETTER F WITH DOT ABOVE */
    static let XK_fabovedot = X11Keys(fromX11KeySym: 0x1001e1f)  /* U+1E1F LATIN SMALL LETTER F WITH DOT ABOVE */
    static let XK_Mabovedot = X11Keys(fromX11KeySym: 0x1001e40)  /* U+1E40 LATIN CAPITAL LETTER M WITH DOT ABOVE */
    static let XK_mabovedot = X11Keys(fromX11KeySym: 0x1001e41)  /* U+1E41 LATIN SMALL LETTER M WITH DOT ABOVE */
    static let XK_Pabovedot = X11Keys(fromX11KeySym: 0x1001e56)  /* U+1E56 LATIN CAPITAL LETTER P WITH DOT ABOVE */
    static let XK_pabovedot = X11Keys(fromX11KeySym: 0x1001e57)  /* U+1E57 LATIN SMALL LETTER P WITH DOT ABOVE */
    static let XK_Sabovedot = X11Keys(fromX11KeySym: 0x1001e60)  /* U+1E60 LATIN CAPITAL LETTER S WITH DOT ABOVE */
    static let XK_sabovedot = X11Keys(fromX11KeySym: 0x1001e61)  /* U+1E61 LATIN SMALL LETTER S WITH DOT ABOVE */
    static let XK_Tabovedot = X11Keys(fromX11KeySym: 0x1001e6a)  /* U+1E6A LATIN CAPITAL LETTER T WITH DOT ABOVE */
    static let XK_tabovedot = X11Keys(fromX11KeySym: 0x1001e6b)  /* U+1E6B LATIN SMALL LETTER T WITH DOT ABOVE */
    static let XK_Wgrave = X11Keys(fromX11KeySym: 0x1001e80)  /* U+1E80 LATIN CAPITAL LETTER W WITH GRAVE */
    static let XK_wgrave = X11Keys(fromX11KeySym: 0x1001e81)  /* U+1E81 LATIN SMALL LETTER W WITH GRAVE */
    static let XK_Wacute = X11Keys(fromX11KeySym: 0x1001e82)  /* U+1E82 LATIN CAPITAL LETTER W WITH ACUTE */
    static let XK_wacute = X11Keys(fromX11KeySym: 0x1001e83)  /* U+1E83 LATIN SMALL LETTER W WITH ACUTE */
    static let XK_Wdiaeresis = X11Keys(fromX11KeySym: 0x1001e84)  /* U+1E84 LATIN CAPITAL LETTER W WITH DIAERESIS */
    static let XK_wdiaeresis = X11Keys(fromX11KeySym: 0x1001e85)  /* U+1E85 LATIN SMALL LETTER W WITH DIAERESIS */
    static let XK_Ygrave = X11Keys(fromX11KeySym: 0x1001ef2)  /* U+1EF2 LATIN CAPITAL LETTER Y WITH GRAVE */
    static let XK_ygrave = X11Keys(fromX11KeySym: 0x1001ef3)  /* U+1EF3 LATIN SMALL LETTER Y WITH GRAVE */

    /*
    * Latin 9
    * Byte 3 = 0x13
    */

    static let XK_OE = X11Keys(fromX11KeySym: 0x13bc)  /* U+0152 LATIN CAPITAL LIGATURE OE */
    static let XK_oe = X11Keys(fromX11KeySym: 0x13bd)  /* U+0153 LATIN SMALL LIGATURE OE */
    static let XK_Ydiaeresis = X11Keys(fromX11KeySym: 0x13be)  /* U+0178 LATIN CAPITAL LETTER Y WITH DIAERESIS */

    /*
    * Katakana
    * Byte 3 = 4
    */

    static let XK_overline = X11Keys(fromX11KeySym: 0x047e)  /* U+203E OVERLINE */
    static let XK_kana_fullstop = X11Keys(fromX11KeySym: 0x04a1)  /* U+3002 IDEOGRAPHIC FULL STOP */
    static let XK_kana_openingbracket = X11Keys(fromX11KeySym: 0x04a2)  /* U+300C LEFT CORNER BRACKET */
    static let XK_kana_closingbracket = X11Keys(fromX11KeySym: 0x04a3)  /* U+300D RIGHT CORNER BRACKET */
    static let XK_kana_comma = X11Keys(fromX11KeySym: 0x04a4)  /* U+3001 IDEOGRAPHIC COMMA */
    static let XK_kana_conjunctive = X11Keys(fromX11KeySym: 0x04a5)  /* U+30FB KATAKANA MIDDLE DOT */
    static let XK_kana_middledot = X11Keys(fromX11KeySym: 0x04a5)  /* deprecated */
    static let XK_kana_WO = X11Keys(fromX11KeySym: 0x04a6)  /* U+30F2 KATAKANA LETTER WO */
    static let XK_kana_a = X11Keys(fromX11KeySym: 0x04a7)  /* U+30A1 KATAKANA LETTER SMALL A */
    static let XK_kana_i = X11Keys(fromX11KeySym: 0x04a8)  /* U+30A3 KATAKANA LETTER SMALL I */
    static let XK_kana_u = X11Keys(fromX11KeySym: 0x04a9)  /* U+30A5 KATAKANA LETTER SMALL U */
    static let XK_kana_e = X11Keys(fromX11KeySym: 0x04aa)  /* U+30A7 KATAKANA LETTER SMALL E */
    static let XK_kana_o = X11Keys(fromX11KeySym: 0x04ab)  /* U+30A9 KATAKANA LETTER SMALL O */
    static let XK_kana_ya = X11Keys(fromX11KeySym: 0x04ac)  /* U+30E3 KATAKANA LETTER SMALL YA */
    static let XK_kana_yu = X11Keys(fromX11KeySym: 0x04ad)  /* U+30E5 KATAKANA LETTER SMALL YU */
    static let XK_kana_yo = X11Keys(fromX11KeySym: 0x04ae)  /* U+30E7 KATAKANA LETTER SMALL YO */
    static let XK_kana_tsu = X11Keys(fromX11KeySym: 0x04af)  /* U+30C3 KATAKANA LETTER SMALL TU */
    static let XK_kana_tu = X11Keys(fromX11KeySym: 0x04af)  /* deprecated */
    static let XK_prolongedsound = X11Keys(fromX11KeySym: 0x04b0)  /* U+30FC KATAKANA-HIRAGANA PROLONGED SOUND MARK */
    static let XK_kana_A = X11Keys(fromX11KeySym: 0x04b1)  /* U+30A2 KATAKANA LETTER A */
    static let XK_kana_I = X11Keys(fromX11KeySym: 0x04b2)  /* U+30A4 KATAKANA LETTER I */
    static let XK_kana_U = X11Keys(fromX11KeySym: 0x04b3)  /* U+30A6 KATAKANA LETTER U */
    static let XK_kana_E = X11Keys(fromX11KeySym: 0x04b4)  /* U+30A8 KATAKANA LETTER E */
    static let XK_kana_O = X11Keys(fromX11KeySym: 0x04b5)  /* U+30AA KATAKANA LETTER O */
    static let XK_kana_KA = X11Keys(fromX11KeySym: 0x04b6)  /* U+30AB KATAKANA LETTER KA */
    static let XK_kana_KI = X11Keys(fromX11KeySym: 0x04b7)  /* U+30AD KATAKANA LETTER KI */
    static let XK_kana_KU = X11Keys(fromX11KeySym: 0x04b8)  /* U+30AF KATAKANA LETTER KU */
    static let XK_kana_KE = X11Keys(fromX11KeySym: 0x04b9)  /* U+30B1 KATAKANA LETTER KE */
    static let XK_kana_KO = X11Keys(fromX11KeySym: 0x04ba)  /* U+30B3 KATAKANA LETTER KO */
    static let XK_kana_SA = X11Keys(fromX11KeySym: 0x04bb)  /* U+30B5 KATAKANA LETTER SA */
    static let XK_kana_SHI = X11Keys(fromX11KeySym: 0x04bc)  /* U+30B7 KATAKANA LETTER SI */
    static let XK_kana_SU = X11Keys(fromX11KeySym: 0x04bd)  /* U+30B9 KATAKANA LETTER SU */
    static let XK_kana_SE = X11Keys(fromX11KeySym: 0x04be)  /* U+30BB KATAKANA LETTER SE */
    static let XK_kana_SO = X11Keys(fromX11KeySym: 0x04bf)  /* U+30BD KATAKANA LETTER SO */
    static let XK_kana_TA = X11Keys(fromX11KeySym: 0x04c0)  /* U+30BF KATAKANA LETTER TA */
    static let XK_kana_CHI = X11Keys(fromX11KeySym: 0x04c1)  /* U+30C1 KATAKANA LETTER TI */
    static let XK_kana_TI = X11Keys(fromX11KeySym: 0x04c1)  /* deprecated */
    static let XK_kana_TSU = X11Keys(fromX11KeySym: 0x04c2)  /* U+30C4 KATAKANA LETTER TU */
    static let XK_kana_TU = X11Keys(fromX11KeySym: 0x04c2)  /* deprecated */
    static let XK_kana_TE = X11Keys(fromX11KeySym: 0x04c3)  /* U+30C6 KATAKANA LETTER TE */
    static let XK_kana_TO = X11Keys(fromX11KeySym: 0x04c4)  /* U+30C8 KATAKANA LETTER TO */
    static let XK_kana_NA = X11Keys(fromX11KeySym: 0x04c5)  /* U+30CA KATAKANA LETTER NA */
    static let XK_kana_NI = X11Keys(fromX11KeySym: 0x04c6)  /* U+30CB KATAKANA LETTER NI */
    static let XK_kana_NU = X11Keys(fromX11KeySym: 0x04c7)  /* U+30CC KATAKANA LETTER NU */
    static let XK_kana_NE = X11Keys(fromX11KeySym: 0x04c8)  /* U+30CD KATAKANA LETTER NE */
    static let XK_kana_NO = X11Keys(fromX11KeySym: 0x04c9)  /* U+30CE KATAKANA LETTER NO */
    static let XK_kana_HA = X11Keys(fromX11KeySym: 0x04ca)  /* U+30CF KATAKANA LETTER HA */
    static let XK_kana_HI = X11Keys(fromX11KeySym: 0x04cb)  /* U+30D2 KATAKANA LETTER HI */
    static let XK_kana_FU = X11Keys(fromX11KeySym: 0x04cc)  /* U+30D5 KATAKANA LETTER HU */
    static let XK_kana_HU = X11Keys(fromX11KeySym: 0x04cc)  /* deprecated */
    static let XK_kana_HE = X11Keys(fromX11KeySym: 0x04cd)  /* U+30D8 KATAKANA LETTER HE */
    static let XK_kana_HO = X11Keys(fromX11KeySym: 0x04ce)  /* U+30DB KATAKANA LETTER HO */
    static let XK_kana_MA = X11Keys(fromX11KeySym: 0x04cf)  /* U+30DE KATAKANA LETTER MA */
    static let XK_kana_MI = X11Keys(fromX11KeySym: 0x04d0)  /* U+30DF KATAKANA LETTER MI */
    static let XK_kana_MU = X11Keys(fromX11KeySym: 0x04d1)  /* U+30E0 KATAKANA LETTER MU */
    static let XK_kana_ME = X11Keys(fromX11KeySym: 0x04d2)  /* U+30E1 KATAKANA LETTER ME */
    static let XK_kana_MO = X11Keys(fromX11KeySym: 0x04d3)  /* U+30E2 KATAKANA LETTER MO */
    static let XK_kana_YA = X11Keys(fromX11KeySym: 0x04d4)  /* U+30E4 KATAKANA LETTER YA */
    static let XK_kana_YU = X11Keys(fromX11KeySym: 0x04d5)  /* U+30E6 KATAKANA LETTER YU */
    static let XK_kana_YO = X11Keys(fromX11KeySym: 0x04d6)  /* U+30E8 KATAKANA LETTER YO */
    static let XK_kana_RA = X11Keys(fromX11KeySym: 0x04d7)  /* U+30E9 KATAKANA LETTER RA */
    static let XK_kana_RI = X11Keys(fromX11KeySym: 0x04d8)  /* U+30EA KATAKANA LETTER RI */
    static let XK_kana_RU = X11Keys(fromX11KeySym: 0x04d9)  /* U+30EB KATAKANA LETTER RU */
    static let XK_kana_RE = X11Keys(fromX11KeySym: 0x04da)  /* U+30EC KATAKANA LETTER RE */
    static let XK_kana_RO = X11Keys(fromX11KeySym: 0x04db)  /* U+30ED KATAKANA LETTER RO */
    static let XK_kana_WA = X11Keys(fromX11KeySym: 0x04dc)  /* U+30EF KATAKANA LETTER WA */
    static let XK_kana_N = X11Keys(fromX11KeySym: 0x04dd)  /* U+30F3 KATAKANA LETTER N */
    static let XK_voicedsound = X11Keys(fromX11KeySym: 0x04de)  /* U+309B KATAKANA-HIRAGANA VOICED SOUND MARK */
    static let XK_semivoicedsound = X11Keys(fromX11KeySym: 0x04df)  /* U+309C KATAKANA-HIRAGANA SEMI-VOICED SOUND MARK */
    static let XK_kana_switch = X11Keys(fromX11KeySym: 0xff7e)  /* Alias for mode_switch */

    /*
    * Arabic
    * Byte 3 = 5
    */

    static let XK_Farsi_0 = X11Keys(fromX11KeySym: 0x10006f0)  /* U+06F0 EXTENDED ARABIC-INDIC DIGIT ZERO */
    static let XK_Farsi_1 = X11Keys(fromX11KeySym: 0x10006f1)  /* U+06F1 EXTENDED ARABIC-INDIC DIGIT ONE */
    static let XK_Farsi_2 = X11Keys(fromX11KeySym: 0x10006f2)  /* U+06F2 EXTENDED ARABIC-INDIC DIGIT TWO */
    static let XK_Farsi_3 = X11Keys(fromX11KeySym: 0x10006f3)  /* U+06F3 EXTENDED ARABIC-INDIC DIGIT THREE */
    static let XK_Farsi_4 = X11Keys(fromX11KeySym: 0x10006f4)  /* U+06F4 EXTENDED ARABIC-INDIC DIGIT FOUR */
    static let XK_Farsi_5 = X11Keys(fromX11KeySym: 0x10006f5)  /* U+06F5 EXTENDED ARABIC-INDIC DIGIT FIVE */
    static let XK_Farsi_6 = X11Keys(fromX11KeySym: 0x10006f6)  /* U+06F6 EXTENDED ARABIC-INDIC DIGIT SIX */
    static let XK_Farsi_7 = X11Keys(fromX11KeySym: 0x10006f7)  /* U+06F7 EXTENDED ARABIC-INDIC DIGIT SEVEN */
    static let XK_Farsi_8 = X11Keys(fromX11KeySym: 0x10006f8)  /* U+06F8 EXTENDED ARABIC-INDIC DIGIT EIGHT */
    static let XK_Farsi_9 = X11Keys(fromX11KeySym: 0x10006f9)  /* U+06F9 EXTENDED ARABIC-INDIC DIGIT NINE */
    static let XK_Arabic_percent = X11Keys(fromX11KeySym: 0x100066a)  /* U+066A ARABIC PERCENT SIGN */
    static let XK_Arabic_superscript_alef = X11Keys(fromX11KeySym: 0x1000670)  /* U+0670 ARABIC LETTER SUPERSCRIPT ALEF */
    static let XK_Arabic_tteh = X11Keys(fromX11KeySym: 0x1000679)  /* U+0679 ARABIC LETTER TTEH */
    static let XK_Arabic_peh = X11Keys(fromX11KeySym: 0x100067e)  /* U+067E ARABIC LETTER PEH */
    static let XK_Arabic_tcheh = X11Keys(fromX11KeySym: 0x1000686)  /* U+0686 ARABIC LETTER TCHEH */
    static let XK_Arabic_ddal = X11Keys(fromX11KeySym: 0x1000688)  /* U+0688 ARABIC LETTER DDAL */
    static let XK_Arabic_rreh = X11Keys(fromX11KeySym: 0x1000691)  /* U+0691 ARABIC LETTER RREH */
    static let XK_Arabic_comma = X11Keys(fromX11KeySym: 0x05ac)  /* U+060C ARABIC COMMA */
    static let XK_Arabic_fullstop = X11Keys(fromX11KeySym: 0x10006d4)  /* U+06D4 ARABIC FULL STOP */
    static let XK_Arabic_0 = X11Keys(fromX11KeySym: 0x1000660)  /* U+0660 ARABIC-INDIC DIGIT ZERO */
    static let XK_Arabic_1 = X11Keys(fromX11KeySym: 0x1000661)  /* U+0661 ARABIC-INDIC DIGIT ONE */
    static let XK_Arabic_2 = X11Keys(fromX11KeySym: 0x1000662)  /* U+0662 ARABIC-INDIC DIGIT TWO */
    static let XK_Arabic_3 = X11Keys(fromX11KeySym: 0x1000663)  /* U+0663 ARABIC-INDIC DIGIT THREE */
    static let XK_Arabic_4 = X11Keys(fromX11KeySym: 0x1000664)  /* U+0664 ARABIC-INDIC DIGIT FOUR */
    static let XK_Arabic_5 = X11Keys(fromX11KeySym: 0x1000665)  /* U+0665 ARABIC-INDIC DIGIT FIVE */
    static let XK_Arabic_6 = X11Keys(fromX11KeySym: 0x1000666)  /* U+0666 ARABIC-INDIC DIGIT SIX */
    static let XK_Arabic_7 = X11Keys(fromX11KeySym: 0x1000667)  /* U+0667 ARABIC-INDIC DIGIT SEVEN */
    static let XK_Arabic_8 = X11Keys(fromX11KeySym: 0x1000668)  /* U+0668 ARABIC-INDIC DIGIT EIGHT */
    static let XK_Arabic_9 = X11Keys(fromX11KeySym: 0x1000669)  /* U+0669 ARABIC-INDIC DIGIT NINE */
    static let XK_Arabic_semicolon = X11Keys(fromX11KeySym: 0x05bb)  /* U+061B ARABIC SEMICOLON */
    static let XK_Arabic_question_mark = X11Keys(fromX11KeySym: 0x05bf)  /* U+061F ARABIC QUESTION MARK */
    static let XK_Arabic_hamza = X11Keys(fromX11KeySym: 0x05c1)  /* U+0621 ARABIC LETTER HAMZA */
    static let XK_Arabic_maddaonalef = X11Keys(fromX11KeySym: 0x05c2)  /* U+0622 ARABIC LETTER ALEF WITH MADDA ABOVE */
    static let XK_Arabic_hamzaonalef = X11Keys(fromX11KeySym: 0x05c3)  /* U+0623 ARABIC LETTER ALEF WITH HAMZA ABOVE */
    static let XK_Arabic_hamzaonwaw = X11Keys(fromX11KeySym: 0x05c4)  /* U+0624 ARABIC LETTER WAW WITH HAMZA ABOVE */
    static let XK_Arabic_hamzaunderalef = X11Keys(fromX11KeySym: 0x05c5)  /* U+0625 ARABIC LETTER ALEF WITH HAMZA BELOW */
    static let XK_Arabic_hamzaonyeh = X11Keys(fromX11KeySym: 0x05c6)  /* U+0626 ARABIC LETTER YEH WITH HAMZA ABOVE */
    static let XK_Arabic_alef = X11Keys(fromX11KeySym: 0x05c7)  /* U+0627 ARABIC LETTER ALEF */
    static let XK_Arabic_beh = X11Keys(fromX11KeySym: 0x05c8)  /* U+0628 ARABIC LETTER BEH */
    static let XK_Arabic_tehmarbuta = X11Keys(fromX11KeySym: 0x05c9)  /* U+0629 ARABIC LETTER TEH MARBUTA */
    static let XK_Arabic_teh = X11Keys(fromX11KeySym: 0x05ca)  /* U+062A ARABIC LETTER TEH */
    static let XK_Arabic_theh = X11Keys(fromX11KeySym: 0x05cb)  /* U+062B ARABIC LETTER THEH */
    static let XK_Arabic_jeem = X11Keys(fromX11KeySym: 0x05cc)  /* U+062C ARABIC LETTER JEEM */
    static let XK_Arabic_hah = X11Keys(fromX11KeySym: 0x05cd)  /* U+062D ARABIC LETTER HAH */
    static let XK_Arabic_khah = X11Keys(fromX11KeySym: 0x05ce)  /* U+062E ARABIC LETTER KHAH */
    static let XK_Arabic_dal = X11Keys(fromX11KeySym: 0x05cf)  /* U+062F ARABIC LETTER DAL */
    static let XK_Arabic_thal = X11Keys(fromX11KeySym: 0x05d0)  /* U+0630 ARABIC LETTER THAL */
    static let XK_Arabic_ra = X11Keys(fromX11KeySym: 0x05d1)  /* U+0631 ARABIC LETTER REH */
    static let XK_Arabic_zain = X11Keys(fromX11KeySym: 0x05d2)  /* U+0632 ARABIC LETTER ZAIN */
    static let XK_Arabic_seen = X11Keys(fromX11KeySym: 0x05d3)  /* U+0633 ARABIC LETTER SEEN */
    static let XK_Arabic_sheen = X11Keys(fromX11KeySym: 0x05d4)  /* U+0634 ARABIC LETTER SHEEN */
    static let XK_Arabic_sad = X11Keys(fromX11KeySym: 0x05d5)  /* U+0635 ARABIC LETTER SAD */
    static let XK_Arabic_dad = X11Keys(fromX11KeySym: 0x05d6)  /* U+0636 ARABIC LETTER DAD */
    static let XK_Arabic_tah = X11Keys(fromX11KeySym: 0x05d7)  /* U+0637 ARABIC LETTER TAH */
    static let XK_Arabic_zah = X11Keys(fromX11KeySym: 0x05d8)  /* U+0638 ARABIC LETTER ZAH */
    static let XK_Arabic_ain = X11Keys(fromX11KeySym: 0x05d9)  /* U+0639 ARABIC LETTER AIN */
    static let XK_Arabic_ghain = X11Keys(fromX11KeySym: 0x05da)  /* U+063A ARABIC LETTER GHAIN */
    static let XK_Arabic_tatweel = X11Keys(fromX11KeySym: 0x05e0)  /* U+0640 ARABIC TATWEEL */
    static let XK_Arabic_feh = X11Keys(fromX11KeySym: 0x05e1)  /* U+0641 ARABIC LETTER FEH */
    static let XK_Arabic_qaf = X11Keys(fromX11KeySym: 0x05e2)  /* U+0642 ARABIC LETTER QAF */
    static let XK_Arabic_kaf = X11Keys(fromX11KeySym: 0x05e3)  /* U+0643 ARABIC LETTER KAF */
    static let XK_Arabic_lam = X11Keys(fromX11KeySym: 0x05e4)  /* U+0644 ARABIC LETTER LAM */
    static let XK_Arabic_meem = X11Keys(fromX11KeySym: 0x05e5)  /* U+0645 ARABIC LETTER MEEM */
    static let XK_Arabic_noon = X11Keys(fromX11KeySym: 0x05e6)  /* U+0646 ARABIC LETTER NOON */
    static let XK_Arabic_ha = X11Keys(fromX11KeySym: 0x05e7)  /* U+0647 ARABIC LETTER HEH */
    static let XK_Arabic_heh = X11Keys(fromX11KeySym: 0x05e7)  /* deprecated */
    static let XK_Arabic_waw = X11Keys(fromX11KeySym: 0x05e8)  /* U+0648 ARABIC LETTER WAW */
    static let XK_Arabic_alefmaksura = X11Keys(fromX11KeySym: 0x05e9)  /* U+0649 ARABIC LETTER ALEF MAKSURA */
    static let XK_Arabic_yeh = X11Keys(fromX11KeySym: 0x05ea)  /* U+064A ARABIC LETTER YEH */
    static let XK_Arabic_fathatan = X11Keys(fromX11KeySym: 0x05eb)  /* U+064B ARABIC FATHATAN */
    static let XK_Arabic_dammatan = X11Keys(fromX11KeySym: 0x05ec)  /* U+064C ARABIC DAMMATAN */
    static let XK_Arabic_kasratan = X11Keys(fromX11KeySym: 0x05ed)  /* U+064D ARABIC KASRATAN */
    static let XK_Arabic_fatha = X11Keys(fromX11KeySym: 0x05ee)  /* U+064E ARABIC FATHA */
    static let XK_Arabic_damma = X11Keys(fromX11KeySym: 0x05ef)  /* U+064F ARABIC DAMMA */
    static let XK_Arabic_kasra = X11Keys(fromX11KeySym: 0x05f0)  /* U+0650 ARABIC KASRA */
    static let XK_Arabic_shadda = X11Keys(fromX11KeySym: 0x05f1)  /* U+0651 ARABIC SHADDA */
    static let XK_Arabic_sukun = X11Keys(fromX11KeySym: 0x05f2)  /* U+0652 ARABIC SUKUN */
    static let XK_Arabic_madda_above = X11Keys(fromX11KeySym: 0x1000653)  /* U+0653 ARABIC MADDAH ABOVE */
    static let XK_Arabic_hamza_above = X11Keys(fromX11KeySym: 0x1000654)  /* U+0654 ARABIC HAMZA ABOVE */
    static let XK_Arabic_hamza_below = X11Keys(fromX11KeySym: 0x1000655)  /* U+0655 ARABIC HAMZA BELOW */
    static let XK_Arabic_jeh = X11Keys(fromX11KeySym: 0x1000698)  /* U+0698 ARABIC LETTER JEH */
    static let XK_Arabic_veh = X11Keys(fromX11KeySym: 0x10006a4)  /* U+06A4 ARABIC LETTER VEH */
    static let XK_Arabic_keheh = X11Keys(fromX11KeySym: 0x10006a9)  /* U+06A9 ARABIC LETTER KEHEH */
    static let XK_Arabic_gaf = X11Keys(fromX11KeySym: 0x10006af)  /* U+06AF ARABIC LETTER GAF */
    static let XK_Arabic_noon_ghunna = X11Keys(fromX11KeySym: 0x10006ba)  /* U+06BA ARABIC LETTER NOON GHUNNA */
    static let XK_Arabic_heh_doachashmee = X11Keys(fromX11KeySym: 0x10006be)  /* U+06BE ARABIC LETTER HEH DOACHASHMEE */
    static let XK_Farsi_yeh = X11Keys(fromX11KeySym: 0x10006cc)  /* U+06CC ARABIC LETTER FARSI YEH */
    static let XK_Arabic_farsi_yeh = X11Keys(fromX11KeySym: 0x10006cc)  /* U+06CC ARABIC LETTER FARSI YEH */
    static let XK_Arabic_yeh_baree = X11Keys(fromX11KeySym: 0x10006d2)  /* U+06D2 ARABIC LETTER YEH BARREE */
    static let XK_Arabic_heh_goal = X11Keys(fromX11KeySym: 0x10006c1)  /* U+06C1 ARABIC LETTER HEH GOAL */
    static let XK_Arabic_switch = X11Keys(fromX11KeySym: 0xff7e)  /* Alias for mode_switch */

    /*
    * Cyrillic
    * Byte 3 = 6
    */
    static let XK_Cyrillic_GHE_bar = X11Keys(fromX11KeySym: 0x1000492)  /* U+0492 CYRILLIC CAPITAL LETTER GHE WITH STROKE */
    static let XK_Cyrillic_ghe_bar = X11Keys(fromX11KeySym: 0x1000493)  /* U+0493 CYRILLIC SMALL LETTER GHE WITH STROKE */
    static let XK_Cyrillic_ZHE_descender = X11Keys(fromX11KeySym: 0x1000496)  /* U+0496 CYRILLIC CAPITAL LETTER ZHE WITH DESCENDER */
    static let XK_Cyrillic_zhe_descender = X11Keys(fromX11KeySym: 0x1000497)  /* U+0497 CYRILLIC SMALL LETTER ZHE WITH DESCENDER */
    static let XK_Cyrillic_KA_descender = X11Keys(fromX11KeySym: 0x100049a)  /* U+049A CYRILLIC CAPITAL LETTER KA WITH DESCENDER */
    static let XK_Cyrillic_ka_descender = X11Keys(fromX11KeySym: 0x100049b)  /* U+049B CYRILLIC SMALL LETTER KA WITH DESCENDER */
    static let XK_Cyrillic_KA_vertstroke = X11Keys(fromX11KeySym: 0x100049c)  /* U+049C CYRILLIC CAPITAL LETTER KA WITH VERTICAL STROKE */
    static let XK_Cyrillic_ka_vertstroke = X11Keys(fromX11KeySym: 0x100049d)  /* U+049D CYRILLIC SMALL LETTER KA WITH VERTICAL STROKE */
    static let XK_Cyrillic_EN_descender = X11Keys(fromX11KeySym: 0x10004a2)  /* U+04A2 CYRILLIC CAPITAL LETTER EN WITH DESCENDER */
    static let XK_Cyrillic_en_descender = X11Keys(fromX11KeySym: 0x10004a3)  /* U+04A3 CYRILLIC SMALL LETTER EN WITH DESCENDER */
    static let XK_Cyrillic_U_straight = X11Keys(fromX11KeySym: 0x10004ae)  /* U+04AE CYRILLIC CAPITAL LETTER STRAIGHT U */
    static let XK_Cyrillic_u_straight = X11Keys(fromX11KeySym: 0x10004af)  /* U+04AF CYRILLIC SMALL LETTER STRAIGHT U */
    static let XK_Cyrillic_U_straight_bar = X11Keys(fromX11KeySym: 0x10004b0)  /* U+04B0 CYRILLIC CAPITAL LETTER STRAIGHT U WITH STROKE */
    static let XK_Cyrillic_u_straight_bar = X11Keys(fromX11KeySym: 0x10004b1)  /* U+04B1 CYRILLIC SMALL LETTER STRAIGHT U WITH STROKE */
    static let XK_Cyrillic_HA_descender = X11Keys(fromX11KeySym: 0x10004b2)  /* U+04B2 CYRILLIC CAPITAL LETTER HA WITH DESCENDER */
    static let XK_Cyrillic_ha_descender = X11Keys(fromX11KeySym: 0x10004b3)  /* U+04B3 CYRILLIC SMALL LETTER HA WITH DESCENDER */
    static let XK_Cyrillic_CHE_descender = X11Keys(fromX11KeySym: 0x10004b6)  /* U+04B6 CYRILLIC CAPITAL LETTER CHE WITH DESCENDER */
    static let XK_Cyrillic_che_descender = X11Keys(fromX11KeySym: 0x10004b7)  /* U+04B7 CYRILLIC SMALL LETTER CHE WITH DESCENDER */
    static let XK_Cyrillic_CHE_vertstroke = X11Keys(fromX11KeySym: 0x10004b8)  /* U+04B8 CYRILLIC CAPITAL LETTER CHE WITH VERTICAL STROKE */
    static let XK_Cyrillic_che_vertstroke = X11Keys(fromX11KeySym: 0x10004b9)  /* U+04B9 CYRILLIC SMALL LETTER CHE WITH VERTICAL STROKE */
    static let XK_Cyrillic_SHHA = X11Keys(fromX11KeySym: 0x10004ba)  /* U+04BA CYRILLIC CAPITAL LETTER SHHA */
    static let XK_Cyrillic_shha = X11Keys(fromX11KeySym: 0x10004bb)  /* U+04BB CYRILLIC SMALL LETTER SHHA */

    static let XK_Cyrillic_SCHWA = X11Keys(fromX11KeySym: 0x10004d8)  /* U+04D8 CYRILLIC CAPITAL LETTER SCHWA */
    static let XK_Cyrillic_schwa = X11Keys(fromX11KeySym: 0x10004d9)  /* U+04D9 CYRILLIC SMALL LETTER SCHWA */
    static let XK_Cyrillic_I_macron = X11Keys(fromX11KeySym: 0x10004e2)  /* U+04E2 CYRILLIC CAPITAL LETTER I WITH MACRON */
    static let XK_Cyrillic_i_macron = X11Keys(fromX11KeySym: 0x10004e3)  /* U+04E3 CYRILLIC SMALL LETTER I WITH MACRON */
    static let XK_Cyrillic_O_bar = X11Keys(fromX11KeySym: 0x10004e8)  /* U+04E8 CYRILLIC CAPITAL LETTER BARRED O */
    static let XK_Cyrillic_o_bar = X11Keys(fromX11KeySym: 0x10004e9)  /* U+04E9 CYRILLIC SMALL LETTER BARRED O */
    static let XK_Cyrillic_U_macron = X11Keys(fromX11KeySym: 0x10004ee)  /* U+04EE CYRILLIC CAPITAL LETTER U WITH MACRON */
    static let XK_Cyrillic_u_macron = X11Keys(fromX11KeySym: 0x10004ef)  /* U+04EF CYRILLIC SMALL LETTER U WITH MACRON */

    static let XK_Serbian_dje = X11Keys(fromX11KeySym: 0x06a1)  /* U+0452 CYRILLIC SMALL LETTER DJE */
    static let XK_Macedonia_gje = X11Keys(fromX11KeySym: 0x06a2)  /* U+0453 CYRILLIC SMALL LETTER GJE */
    static let XK_Cyrillic_io = X11Keys(fromX11KeySym: 0x06a3)  /* U+0451 CYRILLIC SMALL LETTER IO */
    static let XK_Ukrainian_ie = X11Keys(fromX11KeySym: 0x06a4)  /* U+0454 CYRILLIC SMALL LETTER UKRAINIAN IE */
    static let XK_Ukranian_je = X11Keys(fromX11KeySym: 0x06a4)  /* deprecated */
    static let XK_Macedonia_dse = X11Keys(fromX11KeySym: 0x06a5)  /* U+0455 CYRILLIC SMALL LETTER DZE */
    static let XK_Ukrainian_i = X11Keys(fromX11KeySym: 0x06a6)  /* U+0456 CYRILLIC SMALL LETTER BYELORUSSIAN-UKRAINIAN I */
    static let XK_Ukranian_i = X11Keys(fromX11KeySym: 0x06a6)  /* deprecated */
    static let XK_Ukrainian_yi = X11Keys(fromX11KeySym: 0x06a7)  /* U+0457 CYRILLIC SMALL LETTER YI */
    static let XK_Ukranian_yi = X11Keys(fromX11KeySym: 0x06a7)  /* deprecated */
    static let XK_Cyrillic_je = X11Keys(fromX11KeySym: 0x06a8)  /* U+0458 CYRILLIC SMALL LETTER JE */
    static let XK_Serbian_je = X11Keys(fromX11KeySym: 0x06a8)  /* deprecated */
    static let XK_Cyrillic_lje = X11Keys(fromX11KeySym: 0x06a9)  /* U+0459 CYRILLIC SMALL LETTER LJE */
    static let XK_Serbian_lje = X11Keys(fromX11KeySym: 0x06a9)  /* deprecated */
    static let XK_Cyrillic_nje = X11Keys(fromX11KeySym: 0x06aa)  /* U+045A CYRILLIC SMALL LETTER NJE */
    static let XK_Serbian_nje = X11Keys(fromX11KeySym: 0x06aa)  /* deprecated */
    static let XK_Serbian_tshe = X11Keys(fromX11KeySym: 0x06ab)  /* U+045B CYRILLIC SMALL LETTER TSHE */
    static let XK_Macedonia_kje = X11Keys(fromX11KeySym: 0x06ac)  /* U+045C CYRILLIC SMALL LETTER KJE */
    static let XK_Ukrainian_ghe_with_upturn = X11Keys(fromX11KeySym: 0x06ad)  /* U+0491 CYRILLIC SMALL LETTER GHE WITH UPTURN */
    static let XK_Byelorussian_shortu = X11Keys(fromX11KeySym: 0x06ae)  /* U+045E CYRILLIC SMALL LETTER SHORT U */
    static let XK_Cyrillic_dzhe = X11Keys(fromX11KeySym: 0x06af)  /* U+045F CYRILLIC SMALL LETTER DZHE */
    static let XK_Serbian_dze = X11Keys(fromX11KeySym: 0x06af)  /* deprecated */
    static let XK_numerosign = X11Keys(fromX11KeySym: 0x06b0)  /* U+2116 NUMERO SIGN */
    static let XK_Serbian_DJE = X11Keys(fromX11KeySym: 0x06b1)  /* U+0402 CYRILLIC CAPITAL LETTER DJE */
    static let XK_Macedonia_GJE = X11Keys(fromX11KeySym: 0x06b2)  /* U+0403 CYRILLIC CAPITAL LETTER GJE */
    static let XK_Cyrillic_IO = X11Keys(fromX11KeySym: 0x06b3)  /* U+0401 CYRILLIC CAPITAL LETTER IO */
    static let XK_Ukrainian_IE = X11Keys(fromX11KeySym: 0x06b4)  /* U+0404 CYRILLIC CAPITAL LETTER UKRAINIAN IE */
    static let XK_Ukranian_JE = X11Keys(fromX11KeySym: 0x06b4)  /* deprecated */
    static let XK_Macedonia_DSE = X11Keys(fromX11KeySym: 0x06b5)  /* U+0405 CYRILLIC CAPITAL LETTER DZE */
    static let XK_Ukrainian_I = X11Keys(fromX11KeySym: 0x06b6)  /* U+0406 CYRILLIC CAPITAL LETTER BYELORUSSIAN-UKRAINIAN I */
    static let XK_Ukranian_I = X11Keys(fromX11KeySym: 0x06b6)  /* deprecated */
    static let XK_Ukrainian_YI = X11Keys(fromX11KeySym: 0x06b7)  /* U+0407 CYRILLIC CAPITAL LETTER YI */
    static let XK_Ukranian_YI = X11Keys(fromX11KeySym: 0x06b7)  /* deprecated */
    static let XK_Cyrillic_JE = X11Keys(fromX11KeySym: 0x06b8)  /* U+0408 CYRILLIC CAPITAL LETTER JE */
    static let XK_Serbian_JE = X11Keys(fromX11KeySym: 0x06b8)  /* deprecated */
    static let XK_Cyrillic_LJE = X11Keys(fromX11KeySym: 0x06b9)  /* U+0409 CYRILLIC CAPITAL LETTER LJE */
    static let XK_Serbian_LJE = X11Keys(fromX11KeySym: 0x06b9)  /* deprecated */
    static let XK_Cyrillic_NJE = X11Keys(fromX11KeySym: 0x06ba)  /* U+040A CYRILLIC CAPITAL LETTER NJE */
    static let XK_Serbian_NJE = X11Keys(fromX11KeySym: 0x06ba)  /* deprecated */
    static let XK_Serbian_TSHE = X11Keys(fromX11KeySym: 0x06bb)  /* U+040B CYRILLIC CAPITAL LETTER TSHE */
    static let XK_Macedonia_KJE = X11Keys(fromX11KeySym: 0x06bc)  /* U+040C CYRILLIC CAPITAL LETTER KJE */
    static let XK_Ukrainian_GHE_WITH_UPTURN = X11Keys(fromX11KeySym: 0x06bd)  /* U+0490 CYRILLIC CAPITAL LETTER GHE WITH UPTURN */
    static let XK_Byelorussian_SHORTU = X11Keys(fromX11KeySym: 0x06be)  /* U+040E CYRILLIC CAPITAL LETTER SHORT U */
    static let XK_Cyrillic_DZHE = X11Keys(fromX11KeySym: 0x06bf)  /* U+040F CYRILLIC CAPITAL LETTER DZHE */
    static let XK_Serbian_DZE = X11Keys(fromX11KeySym: 0x06bf)  /* deprecated */
    static let XK_Cyrillic_yu = X11Keys(fromX11KeySym: 0x06c0)  /* U+044E CYRILLIC SMALL LETTER YU */
    static let XK_Cyrillic_a = X11Keys(fromX11KeySym: 0x06c1)  /* U+0430 CYRILLIC SMALL LETTER A */
    static let XK_Cyrillic_be = X11Keys(fromX11KeySym: 0x06c2)  /* U+0431 CYRILLIC SMALL LETTER BE */
    static let XK_Cyrillic_tse = X11Keys(fromX11KeySym: 0x06c3)  /* U+0446 CYRILLIC SMALL LETTER TSE */
    static let XK_Cyrillic_de = X11Keys(fromX11KeySym: 0x06c4)  /* U+0434 CYRILLIC SMALL LETTER DE */
    static let XK_Cyrillic_ie = X11Keys(fromX11KeySym: 0x06c5)  /* U+0435 CYRILLIC SMALL LETTER IE */
    static let XK_Cyrillic_ef = X11Keys(fromX11KeySym: 0x06c6)  /* U+0444 CYRILLIC SMALL LETTER EF */
    static let XK_Cyrillic_ghe = X11Keys(fromX11KeySym: 0x06c7)  /* U+0433 CYRILLIC SMALL LETTER GHE */
    static let XK_Cyrillic_ha = X11Keys(fromX11KeySym: 0x06c8)  /* U+0445 CYRILLIC SMALL LETTER HA */
    static let XK_Cyrillic_i = X11Keys(fromX11KeySym: 0x06c9)  /* U+0438 CYRILLIC SMALL LETTER I */
    static let XK_Cyrillic_shorti = X11Keys(fromX11KeySym: 0x06ca)  /* U+0439 CYRILLIC SMALL LETTER SHORT I */
    static let XK_Cyrillic_ka = X11Keys(fromX11KeySym: 0x06cb)  /* U+043A CYRILLIC SMALL LETTER KA */
    static let XK_Cyrillic_el = X11Keys(fromX11KeySym: 0x06cc)  /* U+043B CYRILLIC SMALL LETTER EL */
    static let XK_Cyrillic_em = X11Keys(fromX11KeySym: 0x06cd)  /* U+043C CYRILLIC SMALL LETTER EM */
    static let XK_Cyrillic_en = X11Keys(fromX11KeySym: 0x06ce)  /* U+043D CYRILLIC SMALL LETTER EN */
    static let XK_Cyrillic_o = X11Keys(fromX11KeySym: 0x06cf)  /* U+043E CYRILLIC SMALL LETTER O */
    static let XK_Cyrillic_pe = X11Keys(fromX11KeySym: 0x06d0)  /* U+043F CYRILLIC SMALL LETTER PE */
    static let XK_Cyrillic_ya = X11Keys(fromX11KeySym: 0x06d1)  /* U+044F CYRILLIC SMALL LETTER YA */
    static let XK_Cyrillic_er = X11Keys(fromX11KeySym: 0x06d2)  /* U+0440 CYRILLIC SMALL LETTER ER */
    static let XK_Cyrillic_es = X11Keys(fromX11KeySym: 0x06d3)  /* U+0441 CYRILLIC SMALL LETTER ES */
    static let XK_Cyrillic_te = X11Keys(fromX11KeySym: 0x06d4)  /* U+0442 CYRILLIC SMALL LETTER TE */
    static let XK_Cyrillic_u = X11Keys(fromX11KeySym: 0x06d5)  /* U+0443 CYRILLIC SMALL LETTER U */
    static let XK_Cyrillic_zhe = X11Keys(fromX11KeySym: 0x06d6)  /* U+0436 CYRILLIC SMALL LETTER ZHE */
    static let XK_Cyrillic_ve = X11Keys(fromX11KeySym: 0x06d7)  /* U+0432 CYRILLIC SMALL LETTER VE */
    static let XK_Cyrillic_softsign = X11Keys(fromX11KeySym: 0x06d8)  /* U+044C CYRILLIC SMALL LETTER SOFT SIGN */
    static let XK_Cyrillic_yeru = X11Keys(fromX11KeySym: 0x06d9)  /* U+044B CYRILLIC SMALL LETTER YERU */
    static let XK_Cyrillic_ze = X11Keys(fromX11KeySym: 0x06da)  /* U+0437 CYRILLIC SMALL LETTER ZE */
    static let XK_Cyrillic_sha = X11Keys(fromX11KeySym: 0x06db)  /* U+0448 CYRILLIC SMALL LETTER SHA */
    static let XK_Cyrillic_e = X11Keys(fromX11KeySym: 0x06dc)  /* U+044D CYRILLIC SMALL LETTER E */
    static let XK_Cyrillic_shcha = X11Keys(fromX11KeySym: 0x06dd)  /* U+0449 CYRILLIC SMALL LETTER SHCHA */
    static let XK_Cyrillic_che = X11Keys(fromX11KeySym: 0x06de)  /* U+0447 CYRILLIC SMALL LETTER CHE */
    static let XK_Cyrillic_hardsign = X11Keys(fromX11KeySym: 0x06df)  /* U+044A CYRILLIC SMALL LETTER HARD SIGN */
    static let XK_Cyrillic_YU = X11Keys(fromX11KeySym: 0x06e0)  /* U+042E CYRILLIC CAPITAL LETTER YU */
    static let XK_Cyrillic_A = X11Keys(fromX11KeySym: 0x06e1)  /* U+0410 CYRILLIC CAPITAL LETTER A */
    static let XK_Cyrillic_BE = X11Keys(fromX11KeySym: 0x06e2)  /* U+0411 CYRILLIC CAPITAL LETTER BE */
    static let XK_Cyrillic_TSE = X11Keys(fromX11KeySym: 0x06e3)  /* U+0426 CYRILLIC CAPITAL LETTER TSE */
    static let XK_Cyrillic_DE = X11Keys(fromX11KeySym: 0x06e4)  /* U+0414 CYRILLIC CAPITAL LETTER DE */
    static let XK_Cyrillic_IE = X11Keys(fromX11KeySym: 0x06e5)  /* U+0415 CYRILLIC CAPITAL LETTER IE */
    static let XK_Cyrillic_EF = X11Keys(fromX11KeySym: 0x06e6)  /* U+0424 CYRILLIC CAPITAL LETTER EF */
    static let XK_Cyrillic_GHE = X11Keys(fromX11KeySym: 0x06e7)  /* U+0413 CYRILLIC CAPITAL LETTER GHE */
    static let XK_Cyrillic_HA = X11Keys(fromX11KeySym: 0x06e8)  /* U+0425 CYRILLIC CAPITAL LETTER HA */
    static let XK_Cyrillic_I = X11Keys(fromX11KeySym: 0x06e9)  /* U+0418 CYRILLIC CAPITAL LETTER I */
    static let XK_Cyrillic_SHORTI = X11Keys(fromX11KeySym: 0x06ea)  /* U+0419 CYRILLIC CAPITAL LETTER SHORT I */
    static let XK_Cyrillic_KA = X11Keys(fromX11KeySym: 0x06eb)  /* U+041A CYRILLIC CAPITAL LETTER KA */
    static let XK_Cyrillic_EL = X11Keys(fromX11KeySym: 0x06ec)  /* U+041B CYRILLIC CAPITAL LETTER EL */
    static let XK_Cyrillic_EM = X11Keys(fromX11KeySym: 0x06ed)  /* U+041C CYRILLIC CAPITAL LETTER EM */
    static let XK_Cyrillic_EN = X11Keys(fromX11KeySym: 0x06ee)  /* U+041D CYRILLIC CAPITAL LETTER EN */
    static let XK_Cyrillic_O = X11Keys(fromX11KeySym: 0x06ef)  /* U+041E CYRILLIC CAPITAL LETTER O */
    static let XK_Cyrillic_PE = X11Keys(fromX11KeySym: 0x06f0)  /* U+041F CYRILLIC CAPITAL LETTER PE */
    static let XK_Cyrillic_YA = X11Keys(fromX11KeySym: 0x06f1)  /* U+042F CYRILLIC CAPITAL LETTER YA */
    static let XK_Cyrillic_ER = X11Keys(fromX11KeySym: 0x06f2)  /* U+0420 CYRILLIC CAPITAL LETTER ER */
    static let XK_Cyrillic_ES = X11Keys(fromX11KeySym: 0x06f3)  /* U+0421 CYRILLIC CAPITAL LETTER ES */
    static let XK_Cyrillic_TE = X11Keys(fromX11KeySym: 0x06f4)  /* U+0422 CYRILLIC CAPITAL LETTER TE */
    static let XK_Cyrillic_U = X11Keys(fromX11KeySym: 0x06f5)  /* U+0423 CYRILLIC CAPITAL LETTER U */
    static let XK_Cyrillic_ZHE = X11Keys(fromX11KeySym: 0x06f6)  /* U+0416 CYRILLIC CAPITAL LETTER ZHE */
    static let XK_Cyrillic_VE = X11Keys(fromX11KeySym: 0x06f7)  /* U+0412 CYRILLIC CAPITAL LETTER VE */
    static let XK_Cyrillic_SOFTSIGN = X11Keys(fromX11KeySym: 0x06f8)  /* U+042C CYRILLIC CAPITAL LETTER SOFT SIGN */
    static let XK_Cyrillic_YERU = X11Keys(fromX11KeySym: 0x06f9)  /* U+042B CYRILLIC CAPITAL LETTER YERU */
    static let XK_Cyrillic_ZE = X11Keys(fromX11KeySym: 0x06fa)  /* U+0417 CYRILLIC CAPITAL LETTER ZE */
    static let XK_Cyrillic_SHA = X11Keys(fromX11KeySym: 0x06fb)  /* U+0428 CYRILLIC CAPITAL LETTER SHA */
    static let XK_Cyrillic_E = X11Keys(fromX11KeySym: 0x06fc)  /* U+042D CYRILLIC CAPITAL LETTER E */
    static let XK_Cyrillic_SHCHA = X11Keys(fromX11KeySym: 0x06fd)  /* U+0429 CYRILLIC CAPITAL LETTER SHCHA */
    static let XK_Cyrillic_CHE = X11Keys(fromX11KeySym: 0x06fe)  /* U+0427 CYRILLIC CAPITAL LETTER CHE */
    static let XK_Cyrillic_HARDSIGN = X11Keys(fromX11KeySym: 0x06ff)  /* U+042A CYRILLIC CAPITAL LETTER HARD SIGN */

    /*
    * Greek
    * (based on an early draft of, and not quite identical to, ISO/IEC 8859-7)
    * Byte 3 = 7
    */

    static let XK_Greek_ALPHAaccent = X11Keys(fromX11KeySym: 0x07a1)  /* U+0386 GREEK CAPITAL LETTER ALPHA WITH TONOS */
    static let XK_Greek_EPSILONaccent = X11Keys(fromX11KeySym: 0x07a2)  /* U+0388 GREEK CAPITAL LETTER EPSILON WITH TONOS */
    static let XK_Greek_ETAaccent = X11Keys(fromX11KeySym: 0x07a3)  /* U+0389 GREEK CAPITAL LETTER ETA WITH TONOS */
    static let XK_Greek_IOTAaccent = X11Keys(fromX11KeySym: 0x07a4)  /* U+038A GREEK CAPITAL LETTER IOTA WITH TONOS */
    static let XK_Greek_IOTAdieresis = X11Keys(fromX11KeySym: 0x07a5)  /* U+03AA GREEK CAPITAL LETTER IOTA WITH DIALYTIKA */
    static let XK_Greek_IOTAdiaeresis = X11Keys(fromX11KeySym: 0x07a5)  /* old typo */
    static let XK_Greek_OMICRONaccent = X11Keys(fromX11KeySym: 0x07a7)  /* U+038C GREEK CAPITAL LETTER OMICRON WITH TONOS */
    static let XK_Greek_UPSILONaccent = X11Keys(fromX11KeySym: 0x07a8)  /* U+038E GREEK CAPITAL LETTER UPSILON WITH TONOS */
    static let XK_Greek_UPSILONdieresis = X11Keys(fromX11KeySym: 0x07a9)  /* U+03AB GREEK CAPITAL LETTER UPSILON WITH DIALYTIKA */
    static let XK_Greek_OMEGAaccent = X11Keys(fromX11KeySym: 0x07ab)  /* U+038F GREEK CAPITAL LETTER OMEGA WITH TONOS */
    static let XK_Greek_accentdieresis = X11Keys(fromX11KeySym: 0x07ae)  /* U+0385 GREEK DIALYTIKA TONOS */
    static let XK_Greek_horizbar = X11Keys(fromX11KeySym: 0x07af)  /* U+2015 HORIZONTAL BAR */
    static let XK_Greek_alphaaccent = X11Keys(fromX11KeySym: 0x07b1)  /* U+03AC GREEK SMALL LETTER ALPHA WITH TONOS */
    static let XK_Greek_epsilonaccent = X11Keys(fromX11KeySym: 0x07b2)  /* U+03AD GREEK SMALL LETTER EPSILON WITH TONOS */
    static let XK_Greek_etaaccent = X11Keys(fromX11KeySym: 0x07b3)  /* U+03AE GREEK SMALL LETTER ETA WITH TONOS */
    static let XK_Greek_iotaaccent = X11Keys(fromX11KeySym: 0x07b4)  /* U+03AF GREEK SMALL LETTER IOTA WITH TONOS */
    static let XK_Greek_iotadieresis = X11Keys(fromX11KeySym: 0x07b5)  /* U+03CA GREEK SMALL LETTER IOTA WITH DIALYTIKA */
    static let XK_Greek_iotaaccentdieresis = X11Keys(fromX11KeySym: 0x07b6)  /* U+0390 GREEK SMALL LETTER IOTA WITH DIALYTIKA AND TONOS */
    static let XK_Greek_omicronaccent = X11Keys(fromX11KeySym: 0x07b7)  /* U+03CC GREEK SMALL LETTER OMICRON WITH TONOS */
    static let XK_Greek_upsilonaccent = X11Keys(fromX11KeySym: 0x07b8)  /* U+03CD GREEK SMALL LETTER UPSILON WITH TONOS */
    static let XK_Greek_upsilondieresis = X11Keys(fromX11KeySym: 0x07b9)  /* U+03CB GREEK SMALL LETTER UPSILON WITH DIALYTIKA */
    static let XK_Greek_upsilonaccentdieresis = X11Keys(fromX11KeySym: 0x07ba)  /* U+03B0 GREEK SMALL LETTER UPSILON WITH DIALYTIKA AND TONOS */
    static let XK_Greek_omegaaccent = X11Keys(fromX11KeySym: 0x07bb)  /* U+03CE GREEK SMALL LETTER OMEGA WITH TONOS */
    static let XK_Greek_ALPHA = X11Keys(fromX11KeySym: 0x07c1)  /* U+0391 GREEK CAPITAL LETTER ALPHA */
    static let XK_Greek_BETA = X11Keys(fromX11KeySym: 0x07c2)  /* U+0392 GREEK CAPITAL LETTER BETA */
    static let XK_Greek_GAMMA = X11Keys(fromX11KeySym: 0x07c3)  /* U+0393 GREEK CAPITAL LETTER GAMMA */
    static let XK_Greek_DELTA = X11Keys(fromX11KeySym: 0x07c4)  /* U+0394 GREEK CAPITAL LETTER DELTA */
    static let XK_Greek_EPSILON = X11Keys(fromX11KeySym: 0x07c5)  /* U+0395 GREEK CAPITAL LETTER EPSILON */
    static let XK_Greek_ZETA = X11Keys(fromX11KeySym: 0x07c6)  /* U+0396 GREEK CAPITAL LETTER ZETA */
    static let XK_Greek_ETA = X11Keys(fromX11KeySym: 0x07c7)  /* U+0397 GREEK CAPITAL LETTER ETA */
    static let XK_Greek_THETA = X11Keys(fromX11KeySym: 0x07c8)  /* U+0398 GREEK CAPITAL LETTER THETA */
    static let XK_Greek_IOTA = X11Keys(fromX11KeySym: 0x07c9)  /* U+0399 GREEK CAPITAL LETTER IOTA */
    static let XK_Greek_KAPPA = X11Keys(fromX11KeySym: 0x07ca)  /* U+039A GREEK CAPITAL LETTER KAPPA */
    static let XK_Greek_LAMDA = X11Keys(fromX11KeySym: 0x07cb)  /* U+039B GREEK CAPITAL LETTER LAMDA */
    static let XK_Greek_LAMBDA = X11Keys(fromX11KeySym: 0x07cb)  /* U+039B GREEK CAPITAL LETTER LAMDA */
    static let XK_Greek_MU = X11Keys(fromX11KeySym: 0x07cc)  /* U+039C GREEK CAPITAL LETTER MU */
    static let XK_Greek_NU = X11Keys(fromX11KeySym: 0x07cd)  /* U+039D GREEK CAPITAL LETTER NU */
    static let XK_Greek_XI = X11Keys(fromX11KeySym: 0x07ce)  /* U+039E GREEK CAPITAL LETTER XI */
    static let XK_Greek_OMICRON = X11Keys(fromX11KeySym: 0x07cf)  /* U+039F GREEK CAPITAL LETTER OMICRON */
    static let XK_Greek_PI = X11Keys(fromX11KeySym: 0x07d0)  /* U+03A0 GREEK CAPITAL LETTER PI */
    static let XK_Greek_RHO = X11Keys(fromX11KeySym: 0x07d1)  /* U+03A1 GREEK CAPITAL LETTER RHO */
    static let XK_Greek_SIGMA = X11Keys(fromX11KeySym: 0x07d2)  /* U+03A3 GREEK CAPITAL LETTER SIGMA */
    static let XK_Greek_TAU = X11Keys(fromX11KeySym: 0x07d4)  /* U+03A4 GREEK CAPITAL LETTER TAU */
    static let XK_Greek_UPSILON = X11Keys(fromX11KeySym: 0x07d5)  /* U+03A5 GREEK CAPITAL LETTER UPSILON */
    static let XK_Greek_PHI = X11Keys(fromX11KeySym: 0x07d6)  /* U+03A6 GREEK CAPITAL LETTER PHI */
    static let XK_Greek_CHI = X11Keys(fromX11KeySym: 0x07d7)  /* U+03A7 GREEK CAPITAL LETTER CHI */
    static let XK_Greek_PSI = X11Keys(fromX11KeySym: 0x07d8)  /* U+03A8 GREEK CAPITAL LETTER PSI */
    static let XK_Greek_OMEGA = X11Keys(fromX11KeySym: 0x07d9)  /* U+03A9 GREEK CAPITAL LETTER OMEGA */
    static let XK_Greek_alpha = X11Keys(fromX11KeySym: 0x07e1)  /* U+03B1 GREEK SMALL LETTER ALPHA */
    static let XK_Greek_beta = X11Keys(fromX11KeySym: 0x07e2)  /* U+03B2 GREEK SMALL LETTER BETA */
    static let XK_Greek_gamma = X11Keys(fromX11KeySym: 0x07e3)  /* U+03B3 GREEK SMALL LETTER GAMMA */
    static let XK_Greek_delta = X11Keys(fromX11KeySym: 0x07e4)  /* U+03B4 GREEK SMALL LETTER DELTA */
    static let XK_Greek_epsilon = X11Keys(fromX11KeySym: 0x07e5)  /* U+03B5 GREEK SMALL LETTER EPSILON */
    static let XK_Greek_zeta = X11Keys(fromX11KeySym: 0x07e6)  /* U+03B6 GREEK SMALL LETTER ZETA */
    static let XK_Greek_eta = X11Keys(fromX11KeySym: 0x07e7)  /* U+03B7 GREEK SMALL LETTER ETA */
    static let XK_Greek_theta = X11Keys(fromX11KeySym: 0x07e8)  /* U+03B8 GREEK SMALL LETTER THETA */
    static let XK_Greek_iota = X11Keys(fromX11KeySym: 0x07e9)  /* U+03B9 GREEK SMALL LETTER IOTA */
    static let XK_Greek_kappa = X11Keys(fromX11KeySym: 0x07ea)  /* U+03BA GREEK SMALL LETTER KAPPA */
    static let XK_Greek_lamda = X11Keys(fromX11KeySym: 0x07eb)  /* U+03BB GREEK SMALL LETTER LAMDA */
    static let XK_Greek_lambda = X11Keys(fromX11KeySym: 0x07eb)  /* U+03BB GREEK SMALL LETTER LAMDA */
    static let XK_Greek_mu = X11Keys(fromX11KeySym: 0x07ec)  /* U+03BC GREEK SMALL LETTER MU */
    static let XK_Greek_nu = X11Keys(fromX11KeySym: 0x07ed)  /* U+03BD GREEK SMALL LETTER NU */
    static let XK_Greek_xi = X11Keys(fromX11KeySym: 0x07ee)  /* U+03BE GREEK SMALL LETTER XI */
    static let XK_Greek_omicron = X11Keys(fromX11KeySym: 0x07ef)  /* U+03BF GREEK SMALL LETTER OMICRON */
    static let XK_Greek_pi = X11Keys(fromX11KeySym: 0x07f0)  /* U+03C0 GREEK SMALL LETTER PI */
    static let XK_Greek_rho = X11Keys(fromX11KeySym: 0x07f1)  /* U+03C1 GREEK SMALL LETTER RHO */
    static let XK_Greek_sigma = X11Keys(fromX11KeySym: 0x07f2)  /* U+03C3 GREEK SMALL LETTER SIGMA */
    static let XK_Greek_finalsmallsigma = X11Keys(fromX11KeySym: 0x07f3)  /* U+03C2 GREEK SMALL LETTER FINAL SIGMA */
    static let XK_Greek_tau = X11Keys(fromX11KeySym: 0x07f4)  /* U+03C4 GREEK SMALL LETTER TAU */
    static let XK_Greek_upsilon = X11Keys(fromX11KeySym: 0x07f5)  /* U+03C5 GREEK SMALL LETTER UPSILON */
    static let XK_Greek_phi = X11Keys(fromX11KeySym: 0x07f6)  /* U+03C6 GREEK SMALL LETTER PHI */
    static let XK_Greek_chi = X11Keys(fromX11KeySym: 0x07f7)  /* U+03C7 GREEK SMALL LETTER CHI */
    static let XK_Greek_psi = X11Keys(fromX11KeySym: 0x07f8)  /* U+03C8 GREEK SMALL LETTER PSI */
    static let XK_Greek_omega = X11Keys(fromX11KeySym: 0x07f9)  /* U+03C9 GREEK SMALL LETTER OMEGA */
    static let XK_Greek_switch = X11Keys(fromX11KeySym: 0xff7e)  /* Alias for mode_switch */

    /*
    * Technical
    * (from the DEC VT330/VT420 Technical Character Set, http://vt100.net/charsets/technical.html)
    * Byte 3 = 8
    */

    static let XK_leftradical = X11Keys(fromX11KeySym: 0x08a1)  /* U+23B7 RADICAL SYMBOL BOTTOM */
    static let XK_topleftradical = X11Keys(fromX11KeySym: 0x08a2)  /*(U+250C BOX DRAWINGS LIGHT DOWN AND RIGHT)*/
    static let XK_horizconnector = X11Keys(fromX11KeySym: 0x08a3)  /*(U+2500 BOX DRAWINGS LIGHT HORIZONTAL)*/
    static let XK_topintegral = X11Keys(fromX11KeySym: 0x08a4)  /* U+2320 TOP HALF INTEGRAL */
    static let XK_botintegral = X11Keys(fromX11KeySym: 0x08a5)  /* U+2321 BOTTOM HALF INTEGRAL */
    static let XK_vertconnector = X11Keys(fromX11KeySym: 0x08a6)  /*(U+2502 BOX DRAWINGS LIGHT VERTICAL)*/
    static let XK_topleftsqbracket = X11Keys(fromX11KeySym: 0x08a7)  /* U+23A1 LEFT SQUARE BRACKET UPPER CORNER */
    static let XK_botleftsqbracket = X11Keys(fromX11KeySym: 0x08a8)  /* U+23A3 LEFT SQUARE BRACKET LOWER CORNER */
    static let XK_toprightsqbracket = X11Keys(fromX11KeySym: 0x08a9)  /* U+23A4 RIGHT SQUARE BRACKET UPPER CORNER */
    static let XK_botrightsqbracket = X11Keys(fromX11KeySym: 0x08aa)  /* U+23A6 RIGHT SQUARE BRACKET LOWER CORNER */
    static let XK_topleftparens = X11Keys(fromX11KeySym: 0x08ab)  /* U+239B LEFT PARENTHESIS UPPER HOOK */
    static let XK_botleftparens = X11Keys(fromX11KeySym: 0x08ac)  /* U+239D LEFT PARENTHESIS LOWER HOOK */
    static let XK_toprightparens = X11Keys(fromX11KeySym: 0x08ad)  /* U+239E RIGHT PARENTHESIS UPPER HOOK */
    static let XK_botrightparens = X11Keys(fromX11KeySym: 0x08ae)  /* U+23A0 RIGHT PARENTHESIS LOWER HOOK */
    static let XK_leftmiddlecurlybrace = X11Keys(fromX11KeySym: 0x08af)  /* U+23A8 LEFT CURLY BRACKET MIDDLE PIECE */
    static let XK_rightmiddlecurlybrace = X11Keys(fromX11KeySym: 0x08b0)  /* U+23AC RIGHT CURLY BRACKET MIDDLE PIECE */
    static let XK_topleftsummation = X11Keys(fromX11KeySym: 0x08b1)
    static let XK_botleftsummation = X11Keys(fromX11KeySym: 0x08b2)
    static let XK_topvertsummationconnector = X11Keys(fromX11KeySym: 0x08b3)
    static let XK_botvertsummationconnector = X11Keys(fromX11KeySym: 0x08b4)
    static let XK_toprightsummation = X11Keys(fromX11KeySym: 0x08b5)
    static let XK_botrightsummation = X11Keys(fromX11KeySym: 0x08b6)
    static let XK_rightmiddlesummation = X11Keys(fromX11KeySym: 0x08b7)
    static let XK_lessthanequal = X11Keys(fromX11KeySym: 0x08bc)  /* U+2264 LESS-THAN OR EQUAL TO */
    static let XK_notequal = X11Keys(fromX11KeySym: 0x08bd)  /* U+2260 NOT EQUAL TO */
    static let XK_greaterthanequal = X11Keys(fromX11KeySym: 0x08be)  /* U+2265 GREATER-THAN OR EQUAL TO */
    static let XK_integral = X11Keys(fromX11KeySym: 0x08bf)  /* U+222B INTEGRAL */
    static let XK_therefore = X11Keys(fromX11KeySym: 0x08c0)  /* U+2234 THEREFORE */
    static let XK_variation = X11Keys(fromX11KeySym: 0x08c1)  /* U+221D PROPORTIONAL TO */
    static let XK_infinity = X11Keys(fromX11KeySym: 0x08c2)  /* U+221E INFINITY */
    static let XK_nabla = X11Keys(fromX11KeySym: 0x08c5)  /* U+2207 NABLA */
    static let XK_approximate = X11Keys(fromX11KeySym: 0x08c8)  /* U+223C TILDE OPERATOR */
    static let XK_similarequal = X11Keys(fromX11KeySym: 0x08c9)  /* U+2243 ASYMPTOTICALLY EQUAL TO */
    static let XK_ifonlyif = X11Keys(fromX11KeySym: 0x08cd)  /* U+21D4 LEFT RIGHT DOUBLE ARROW */
    static let XK_implies = X11Keys(fromX11KeySym: 0x08ce)  /* U+21D2 RIGHTWARDS DOUBLE ARROW */
    static let XK_identical = X11Keys(fromX11KeySym: 0x08cf)  /* U+2261 IDENTICAL TO */
    static let XK_radical = X11Keys(fromX11KeySym: 0x08d6)  /* U+221A SQUARE ROOT */
    static let XK_includedin = X11Keys(fromX11KeySym: 0x08da)  /* U+2282 SUBSET OF */
    static let XK_includes = X11Keys(fromX11KeySym: 0x08db)  /* U+2283 SUPERSET OF */
    static let XK_intersection = X11Keys(fromX11KeySym: 0x08dc)  /* U+2229 INTERSECTION */
    static let XK_union = X11Keys(fromX11KeySym: 0x08dd)  /* U+222A UNION */
    static let XK_logicaland = X11Keys(fromX11KeySym: 0x08de)  /* U+2227 LOGICAL AND */
    static let XK_logicalor = X11Keys(fromX11KeySym: 0x08df)  /* U+2228 LOGICAL OR */
    static let XK_partialderivative = X11Keys(fromX11KeySym: 0x08ef)  /* U+2202 PARTIAL DIFFERENTIAL */
    static let XK_function = X11Keys(fromX11KeySym: 0x08f6)  /* U+0192 LATIN SMALL LETTER F WITH HOOK */
    static let XK_leftarrow = X11Keys(fromX11KeySym: 0x08fb)  /* U+2190 LEFTWARDS ARROW */
    static let XK_uparrow = X11Keys(fromX11KeySym: 0x08fc)  /* U+2191 UPWARDS ARROW */
    static let XK_rightarrow = X11Keys(fromX11KeySym: 0x08fd)  /* U+2192 RIGHTWARDS ARROW */
    static let XK_downarrow = X11Keys(fromX11KeySym: 0x08fe)  /* U+2193 DOWNWARDS ARROW */

    /*
    * Special
    * (from the DEC VT100 Special Graphics Character Set)
    * Byte 3 = 9
    */

    static let XK_blank = X11Keys(fromX11KeySym: 0x09df)
    static let XK_soliddiamond = X11Keys(fromX11KeySym: 0x09e0)  /* U+25C6 BLACK DIAMOND */
    static let XK_checkerboard = X11Keys(fromX11KeySym: 0x09e1)  /* U+2592 MEDIUM SHADE */
    static let XK_ht = X11Keys(fromX11KeySym: 0x09e2)  /* U+2409 SYMBOL FOR HORIZONTAL TABULATION */
    static let XK_ff = X11Keys(fromX11KeySym: 0x09e3)  /* U+240C SYMBOL FOR FORM FEED */
    static let XK_cr = X11Keys(fromX11KeySym: 0x09e4)  /* U+240D SYMBOL FOR CARRIAGE RETURN */
    static let XK_lf = X11Keys(fromX11KeySym: 0x09e5)  /* U+240A SYMBOL FOR LINE FEED */
    static let XK_nl = X11Keys(fromX11KeySym: 0x09e8)  /* U+2424 SYMBOL FOR NEWLINE */
    static let XK_vt = X11Keys(fromX11KeySym: 0x09e9)  /* U+240B SYMBOL FOR VERTICAL TABULATION */
    static let XK_lowrightcorner = X11Keys(fromX11KeySym: 0x09ea)  /* U+2518 BOX DRAWINGS LIGHT UP AND LEFT */
    static let XK_uprightcorner = X11Keys(fromX11KeySym: 0x09eb)  /* U+2510 BOX DRAWINGS LIGHT DOWN AND LEFT */
    static let XK_upleftcorner = X11Keys(fromX11KeySym: 0x09ec)  /* U+250C BOX DRAWINGS LIGHT DOWN AND RIGHT */
    static let XK_lowleftcorner = X11Keys(fromX11KeySym: 0x09ed)  /* U+2514 BOX DRAWINGS LIGHT UP AND RIGHT */
    static let XK_crossinglines = X11Keys(fromX11KeySym: 0x09ee)  /* U+253C BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL */
    static let XK_horizlinescan1 = X11Keys(fromX11KeySym: 0x09ef)  /* U+23BA HORIZONTAL SCAN LINE-1 */
    static let XK_horizlinescan3 = X11Keys(fromX11KeySym: 0x09f0)  /* U+23BB HORIZONTAL SCAN LINE-3 */
    static let XK_horizlinescan5 = X11Keys(fromX11KeySym: 0x09f1)  /* U+2500 BOX DRAWINGS LIGHT HORIZONTAL */
    static let XK_horizlinescan7 = X11Keys(fromX11KeySym: 0x09f2)  /* U+23BC HORIZONTAL SCAN LINE-7 */
    static let XK_horizlinescan9 = X11Keys(fromX11KeySym: 0x09f3)  /* U+23BD HORIZONTAL SCAN LINE-9 */
    static let XK_leftt = X11Keys(fromX11KeySym: 0x09f4)  /* U+251C BOX DRAWINGS LIGHT VERTICAL AND RIGHT */
    static let XK_rightt = X11Keys(fromX11KeySym: 0x09f5)  /* U+2524 BOX DRAWINGS LIGHT VERTICAL AND LEFT */
    static let XK_bott = X11Keys(fromX11KeySym: 0x09f6)  /* U+2534 BOX DRAWINGS LIGHT UP AND HORIZONTAL */
    static let XK_topt = X11Keys(fromX11KeySym: 0x09f7)  /* U+252C BOX DRAWINGS LIGHT DOWN AND HORIZONTAL */
    static let XK_vertbar = X11Keys(fromX11KeySym: 0x09f8)  /* U+2502 BOX DRAWINGS LIGHT VERTICAL */

    /*
    * Publishing
    * (these are probably from a long forgotten DEC Publishing
    * font that once shipped with DECwrite)
    * Byte 3 = 0x0a
    */

    static let XK_emspace = X11Keys(fromX11KeySym: 0x0aa1)  /* U+2003 EM SPACE */
    static let XK_enspace = X11Keys(fromX11KeySym: 0x0aa2)  /* U+2002 EN SPACE */
    static let XK_em3space = X11Keys(fromX11KeySym: 0x0aa3)  /* U+2004 THREE-PER-EM SPACE */
    static let XK_em4space = X11Keys(fromX11KeySym: 0x0aa4)  /* U+2005 FOUR-PER-EM SPACE */
    static let XK_digitspace = X11Keys(fromX11KeySym: 0x0aa5)  /* U+2007 FIGURE SPACE */
    static let XK_punctspace = X11Keys(fromX11KeySym: 0x0aa6)  /* U+2008 PUNCTUATION SPACE */
    static let XK_thinspace = X11Keys(fromX11KeySym: 0x0aa7)  /* U+2009 THIN SPACE */
    static let XK_hairspace = X11Keys(fromX11KeySym: 0x0aa8)  /* U+200A HAIR SPACE */
    static let XK_emdash = X11Keys(fromX11KeySym: 0x0aa9)  /* U+2014 EM DASH */
    static let XK_endash = X11Keys(fromX11KeySym: 0x0aaa)  /* U+2013 EN DASH */
    static let XK_signifblank = X11Keys(fromX11KeySym: 0x0aac)  /*(U+2423 OPEN BOX)*/
    static let XK_ellipsis = X11Keys(fromX11KeySym: 0x0aae)  /* U+2026 HORIZONTAL ELLIPSIS */
    static let XK_doubbaselinedot = X11Keys(fromX11KeySym: 0x0aaf)  /* U+2025 TWO DOT LEADER */
    static let XK_onethird = X11Keys(fromX11KeySym: 0x0ab0)  /* U+2153 VULGAR FRACTION ONE THIRD */
    static let XK_twothirds = X11Keys(fromX11KeySym: 0x0ab1)  /* U+2154 VULGAR FRACTION TWO THIRDS */
    static let XK_onefifth = X11Keys(fromX11KeySym: 0x0ab2)  /* U+2155 VULGAR FRACTION ONE FIFTH */
    static let XK_twofifths = X11Keys(fromX11KeySym: 0x0ab3)  /* U+2156 VULGAR FRACTION TWO FIFTHS */
    static let XK_threefifths = X11Keys(fromX11KeySym: 0x0ab4)  /* U+2157 VULGAR FRACTION THREE FIFTHS */
    static let XK_fourfifths = X11Keys(fromX11KeySym: 0x0ab5)  /* U+2158 VULGAR FRACTION FOUR FIFTHS */
    static let XK_onesixth = X11Keys(fromX11KeySym: 0x0ab6)  /* U+2159 VULGAR FRACTION ONE SIXTH */
    static let XK_fivesixths = X11Keys(fromX11KeySym: 0x0ab7)  /* U+215A VULGAR FRACTION FIVE SIXTHS */
    static let XK_careof = X11Keys(fromX11KeySym: 0x0ab8)  /* U+2105 CARE OF */
    static let XK_figdash = X11Keys(fromX11KeySym: 0x0abb)  /* U+2012 FIGURE DASH */
    static let XK_leftanglebracket = X11Keys(fromX11KeySym: 0x0abc)  /*(U+2329 LEFT-POINTING ANGLE BRACKET)*/
    static let XK_decimalpoint = X11Keys(fromX11KeySym: 0x0abd)  /*(U+002E FULL STOP)*/
    static let XK_rightanglebracket = X11Keys(fromX11KeySym: 0x0abe)  /*(U+232A RIGHT-POINTING ANGLE BRACKET)*/
    static let XK_marker = X11Keys(fromX11KeySym: 0x0abf)
    static let XK_oneeighth = X11Keys(fromX11KeySym: 0x0ac3)  /* U+215B VULGAR FRACTION ONE EIGHTH */
    static let XK_threeeighths = X11Keys(fromX11KeySym: 0x0ac4)  /* U+215C VULGAR FRACTION THREE EIGHTHS */
    static let XK_fiveeighths = X11Keys(fromX11KeySym: 0x0ac5)  /* U+215D VULGAR FRACTION FIVE EIGHTHS */
    static let XK_seveneighths = X11Keys(fromX11KeySym: 0x0ac6)  /* U+215E VULGAR FRACTION SEVEN EIGHTHS */
    static let XK_trademark = X11Keys(fromX11KeySym: 0x0ac9)  /* U+2122 TRADE MARK SIGN */
    static let XK_signaturemark = X11Keys(fromX11KeySym: 0x0aca)  /*(U+2613 SALTIRE)*/
    static let XK_trademarkincircle = X11Keys(fromX11KeySym: 0x0acb)
    static let XK_leftopentriangle = X11Keys(fromX11KeySym: 0x0acc)  /*(U+25C1 WHITE LEFT-POINTING TRIANGLE)*/
    static let XK_rightopentriangle = X11Keys(fromX11KeySym: 0x0acd)  /*(U+25B7 WHITE RIGHT-POINTING TRIANGLE)*/
    static let XK_emopencircle = X11Keys(fromX11KeySym: 0x0ace)  /*(U+25CB WHITE CIRCLE)*/
    static let XK_emopenrectangle = X11Keys(fromX11KeySym: 0x0acf)  /*(U+25AF WHITE VERTICAL RECTANGLE)*/
    static let XK_leftsinglequotemark = X11Keys(fromX11KeySym: 0x0ad0)  /* U+2018 LEFT SINGLE QUOTATION MARK */
    static let XK_rightsinglequotemark = X11Keys(fromX11KeySym: 0x0ad1)  /* U+2019 RIGHT SINGLE QUOTATION MARK */
    static let XK_leftdoublequotemark = X11Keys(fromX11KeySym: 0x0ad2)  /* U+201C LEFT DOUBLE QUOTATION MARK */
    static let XK_rightdoublequotemark = X11Keys(fromX11KeySym: 0x0ad3)  /* U+201D RIGHT DOUBLE QUOTATION MARK */
    static let XK_prescription = X11Keys(fromX11KeySym: 0x0ad4)  /* U+211E PRESCRIPTION TAKE */
    static let XK_permille = X11Keys(fromX11KeySym: 0x0ad5)  /* U+2030 PER MILLE SIGN */
    static let XK_minutes = X11Keys(fromX11KeySym: 0x0ad6)  /* U+2032 PRIME */
    static let XK_seconds = X11Keys(fromX11KeySym: 0x0ad7)  /* U+2033 DOUBLE PRIME */
    static let XK_latincross = X11Keys(fromX11KeySym: 0x0ad9)  /* U+271D LATIN CROSS */
    static let XK_hexagram = X11Keys(fromX11KeySym: 0x0ada)
    static let XK_filledrectbullet = X11Keys(fromX11KeySym: 0x0adb)  /*(U+25AC BLACK RECTANGLE)*/
    static let XK_filledlefttribullet = X11Keys(fromX11KeySym: 0x0adc)  /*(U+25C0 BLACK LEFT-POINTING TRIANGLE)*/
    static let XK_filledrighttribullet = X11Keys(fromX11KeySym: 0x0add)  /*(U+25B6 BLACK RIGHT-POINTING TRIANGLE)*/
    static let XK_emfilledcircle = X11Keys(fromX11KeySym: 0x0ade)  /*(U+25CF BLACK CIRCLE)*/
    static let XK_emfilledrect = X11Keys(fromX11KeySym: 0x0adf)  /*(U+25AE BLACK VERTICAL RECTANGLE)*/
    static let XK_enopencircbullet = X11Keys(fromX11KeySym: 0x0ae0)  /*(U+25E6 WHITE BULLET)*/
    static let XK_enopensquarebullet = X11Keys(fromX11KeySym: 0x0ae1)  /*(U+25AB WHITE SMALL SQUARE)*/
    static let XK_openrectbullet = X11Keys(fromX11KeySym: 0x0ae2)  /*(U+25AD WHITE RECTANGLE)*/
    static let XK_opentribulletup = X11Keys(fromX11KeySym: 0x0ae3)  /*(U+25B3 WHITE UP-POINTING TRIANGLE)*/
    static let XK_opentribulletdown = X11Keys(fromX11KeySym: 0x0ae4)  /*(U+25BD WHITE DOWN-POINTING TRIANGLE)*/
    static let XK_openstar = X11Keys(fromX11KeySym: 0x0ae5)  /*(U+2606 WHITE STAR)*/
    static let XK_enfilledcircbullet = X11Keys(fromX11KeySym: 0x0ae6)  /*(U+2022 BULLET)*/
    static let XK_enfilledsqbullet = X11Keys(fromX11KeySym: 0x0ae7)  /*(U+25AA BLACK SMALL SQUARE)*/
    static let XK_filledtribulletup = X11Keys(fromX11KeySym: 0x0ae8)  /*(U+25B2 BLACK UP-POINTING TRIANGLE)*/
    static let XK_filledtribulletdown = X11Keys(fromX11KeySym: 0x0ae9)  /*(U+25BC BLACK DOWN-POINTING TRIANGLE)*/
    static let XK_leftpointer = X11Keys(fromX11KeySym: 0x0aea)  /*(U+261C WHITE LEFT POINTING INDEX)*/
    static let XK_rightpointer = X11Keys(fromX11KeySym: 0x0aeb)  /*(U+261E WHITE RIGHT POINTING INDEX)*/
    static let XK_club = X11Keys(fromX11KeySym: 0x0aec)  /* U+2663 BLACK CLUB SUIT */
    static let XK_diamond = X11Keys(fromX11KeySym: 0x0aed)  /* U+2666 BLACK DIAMOND SUIT */
    static let XK_heart = X11Keys(fromX11KeySym: 0x0aee)  /* U+2665 BLACK HEART SUIT */
    static let XK_maltesecross = X11Keys(fromX11KeySym: 0x0af0)  /* U+2720 MALTESE CROSS */
    static let XK_dagger = X11Keys(fromX11KeySym: 0x0af1)  /* U+2020 DAGGER */
    static let XK_doubledagger = X11Keys(fromX11KeySym: 0x0af2)  /* U+2021 DOUBLE DAGGER */
    static let XK_checkmark = X11Keys(fromX11KeySym: 0x0af3)  /* U+2713 CHECK MARK */
    static let XK_ballotcross = X11Keys(fromX11KeySym: 0x0af4)  /* U+2717 BALLOT X */
    static let XK_musicalsharp = X11Keys(fromX11KeySym: 0x0af5)  /* U+266F MUSIC SHARP SIGN */
    static let XK_musicalflat = X11Keys(fromX11KeySym: 0x0af6)  /* U+266D MUSIC FLAT SIGN */
    static let XK_malesymbol = X11Keys(fromX11KeySym: 0x0af7)  /* U+2642 MALE SIGN */
    static let XK_femalesymbol = X11Keys(fromX11KeySym: 0x0af8)  /* U+2640 FEMALE SIGN */
    static let XK_telephone = X11Keys(fromX11KeySym: 0x0af9)  /* U+260E BLACK TELEPHONE */
    static let XK_telephonerecorder = X11Keys(fromX11KeySym: 0x0afa)  /* U+2315 TELEPHONE RECORDER */
    static let XK_phonographcopyright = X11Keys(fromX11KeySym: 0x0afb)  /* U+2117 SOUND RECORDING COPYRIGHT */
    static let XK_caret = X11Keys(fromX11KeySym: 0x0afc)  /* U+2038 CARET */
    static let XK_singlelowquotemark = X11Keys(fromX11KeySym: 0x0afd)  /* U+201A SINGLE LOW-9 QUOTATION MARK */
    static let XK_doublelowquotemark = X11Keys(fromX11KeySym: 0x0afe)  /* U+201E DOUBLE LOW-9 QUOTATION MARK */
    static let XK_cursor = X11Keys(fromX11KeySym: 0x0aff)

    /*
    * APL
    * Byte 3 = 0x0b
    */

    static let XK_leftcaret = X11Keys(fromX11KeySym: 0x0ba3)  /*(U+003C LESS-THAN SIGN)*/
    static let XK_rightcaret = X11Keys(fromX11KeySym: 0x0ba6)  /*(U+003E GREATER-THAN SIGN)*/
    static let XK_downcaret = X11Keys(fromX11KeySym: 0x0ba8)  /*(U+2228 LOGICAL OR)*/
    static let XK_upcaret = X11Keys(fromX11KeySym: 0x0ba9)  /*(U+2227 LOGICAL AND)*/
    static let XK_overbar = X11Keys(fromX11KeySym: 0x0bc0)  /*(U+00AF MACRON)*/
    static let XK_downtack = X11Keys(fromX11KeySym: 0x0bc2)  /* U+22A4 DOWN TACK */
    static let XK_upshoe = X11Keys(fromX11KeySym: 0x0bc3)  /*(U+2229 INTERSECTION)*/
    static let XK_downstile = X11Keys(fromX11KeySym: 0x0bc4)  /* U+230A LEFT FLOOR */
    static let XK_underbar = X11Keys(fromX11KeySym: 0x0bc6)  /*(U+005F LOW LINE)*/
    static let XK_jot = X11Keys(fromX11KeySym: 0x0bca)  /* U+2218 RING OPERATOR */
    static let XK_quad = X11Keys(fromX11KeySym: 0x0bcc)  /* U+2395 APL FUNCTIONAL SYMBOL QUAD */
    static let XK_uptack = X11Keys(fromX11KeySym: 0x0bce)  /* U+22A5 UP TACK */
    static let XK_circle = X11Keys(fromX11KeySym: 0x0bcf)  /* U+25CB WHITE CIRCLE */
    static let XK_upstile = X11Keys(fromX11KeySym: 0x0bd3)  /* U+2308 LEFT CEILING */
    static let XK_downshoe = X11Keys(fromX11KeySym: 0x0bd6)  /*(U+222A UNION)*/
    static let XK_rightshoe = X11Keys(fromX11KeySym: 0x0bd8)  /*(U+2283 SUPERSET OF)*/
    static let XK_leftshoe = X11Keys(fromX11KeySym: 0x0bda)  /*(U+2282 SUBSET OF)*/
    static let XK_lefttack = X11Keys(fromX11KeySym: 0x0bdc)  /* U+22A3 LEFT TACK */
    static let XK_righttack = X11Keys(fromX11KeySym: 0x0bfc)  /* U+22A2 RIGHT TACK */

    /*
    * Hebrew
    * Byte 3 = 0x0c
    */

    static let XK_hebrew_doublelowline = X11Keys(fromX11KeySym: 0x0cdf)  /* U+2017 DOUBLE LOW LINE */
    static let XK_hebrew_aleph = X11Keys(fromX11KeySym: 0x0ce0)  /* U+05D0 HEBREW LETTER ALEF */
    static let XK_hebrew_bet = X11Keys(fromX11KeySym: 0x0ce1)  /* U+05D1 HEBREW LETTER BET */
    static let XK_hebrew_beth = X11Keys(fromX11KeySym: 0x0ce1)  /* deprecated */
    static let XK_hebrew_gimel = X11Keys(fromX11KeySym: 0x0ce2)  /* U+05D2 HEBREW LETTER GIMEL */
    static let XK_hebrew_gimmel = X11Keys(fromX11KeySym: 0x0ce2)  /* deprecated */
    static let XK_hebrew_dalet = X11Keys(fromX11KeySym: 0x0ce3)  /* U+05D3 HEBREW LETTER DALET */
    static let XK_hebrew_daleth = X11Keys(fromX11KeySym: 0x0ce3)  /* deprecated */
    static let XK_hebrew_he = X11Keys(fromX11KeySym: 0x0ce4)  /* U+05D4 HEBREW LETTER HE */
    static let XK_hebrew_waw = X11Keys(fromX11KeySym: 0x0ce5)  /* U+05D5 HEBREW LETTER VAV */
    static let XK_hebrew_zain = X11Keys(fromX11KeySym: 0x0ce6)  /* U+05D6 HEBREW LETTER ZAYIN */
    static let XK_hebrew_zayin = X11Keys(fromX11KeySym: 0x0ce6)  /* deprecated */
    static let XK_hebrew_chet = X11Keys(fromX11KeySym: 0x0ce7)  /* U+05D7 HEBREW LETTER HET */
    static let XK_hebrew_het = X11Keys(fromX11KeySym: 0x0ce7)  /* deprecated */
    static let XK_hebrew_tet = X11Keys(fromX11KeySym: 0x0ce8)  /* U+05D8 HEBREW LETTER TET */
    static let XK_hebrew_teth = X11Keys(fromX11KeySym: 0x0ce8)  /* deprecated */
    static let XK_hebrew_yod = X11Keys(fromX11KeySym: 0x0ce9)  /* U+05D9 HEBREW LETTER YOD */
    static let XK_hebrew_finalkaph = X11Keys(fromX11KeySym: 0x0cea)  /* U+05DA HEBREW LETTER FINAL KAF */
    static let XK_hebrew_kaph = X11Keys(fromX11KeySym: 0x0ceb)  /* U+05DB HEBREW LETTER KAF */
    static let XK_hebrew_lamed = X11Keys(fromX11KeySym: 0x0cec)  /* U+05DC HEBREW LETTER LAMED */
    static let XK_hebrew_finalmem = X11Keys(fromX11KeySym: 0x0ced)  /* U+05DD HEBREW LETTER FINAL MEM */
    static let XK_hebrew_mem = X11Keys(fromX11KeySym: 0x0cee)  /* U+05DE HEBREW LETTER MEM */
    static let XK_hebrew_finalnun = X11Keys(fromX11KeySym: 0x0cef)  /* U+05DF HEBREW LETTER FINAL NUN */
    static let XK_hebrew_nun = X11Keys(fromX11KeySym: 0x0cf0)  /* U+05E0 HEBREW LETTER NUN */
    static let XK_hebrew_samech = X11Keys(fromX11KeySym: 0x0cf1)  /* U+05E1 HEBREW LETTER SAMEKH */
    static let XK_hebrew_samekh = X11Keys(fromX11KeySym: 0x0cf1)  /* deprecated */
    static let XK_hebrew_ayin = X11Keys(fromX11KeySym: 0x0cf2)  /* U+05E2 HEBREW LETTER AYIN */
    static let XK_hebrew_finalpe = X11Keys(fromX11KeySym: 0x0cf3)  /* U+05E3 HEBREW LETTER FINAL PE */
    static let XK_hebrew_pe = X11Keys(fromX11KeySym: 0x0cf4)  /* U+05E4 HEBREW LETTER PE */
    static let XK_hebrew_finalzade = X11Keys(fromX11KeySym: 0x0cf5)  /* U+05E5 HEBREW LETTER FINAL TSADI */
    static let XK_hebrew_finalzadi = X11Keys(fromX11KeySym: 0x0cf5)  /* deprecated */
    static let XK_hebrew_zade = X11Keys(fromX11KeySym: 0x0cf6)  /* U+05E6 HEBREW LETTER TSADI */
    static let XK_hebrew_zadi = X11Keys(fromX11KeySym: 0x0cf6)  /* deprecated */
    static let XK_hebrew_qoph = X11Keys(fromX11KeySym: 0x0cf7)  /* U+05E7 HEBREW LETTER QOF */
    static let XK_hebrew_kuf = X11Keys(fromX11KeySym: 0x0cf7)  /* deprecated */
    static let XK_hebrew_resh = X11Keys(fromX11KeySym: 0x0cf8)  /* U+05E8 HEBREW LETTER RESH */
    static let XK_hebrew_shin = X11Keys(fromX11KeySym: 0x0cf9)  /* U+05E9 HEBREW LETTER SHIN */
    static let XK_hebrew_taw = X11Keys(fromX11KeySym: 0x0cfa)  /* U+05EA HEBREW LETTER TAV */
    static let XK_hebrew_taf = X11Keys(fromX11KeySym: 0x0cfa)  /* deprecated */
    static let XK_Hebrew_switch = X11Keys(fromX11KeySym: 0xff7e)  /* Alias for mode_switch */

    /*
    * Thai
    * Byte 3 = 0x0d
    */

    static let XK_Thai_kokai = X11Keys(fromX11KeySym: 0x0da1)  /* U+0E01 THAI CHARACTER KO KAI */
    static let XK_Thai_khokhai = X11Keys(fromX11KeySym: 0x0da2)  /* U+0E02 THAI CHARACTER KHO KHAI */
    static let XK_Thai_khokhuat = X11Keys(fromX11KeySym: 0x0da3)  /* U+0E03 THAI CHARACTER KHO KHUAT */
    static let XK_Thai_khokhwai = X11Keys(fromX11KeySym: 0x0da4)  /* U+0E04 THAI CHARACTER KHO KHWAI */
    static let XK_Thai_khokhon = X11Keys(fromX11KeySym: 0x0da5)  /* U+0E05 THAI CHARACTER KHO KHON */
    static let XK_Thai_khorakhang = X11Keys(fromX11KeySym: 0x0da6)  /* U+0E06 THAI CHARACTER KHO RAKHANG */
    static let XK_Thai_ngongu = X11Keys(fromX11KeySym: 0x0da7)  /* U+0E07 THAI CHARACTER NGO NGU */
    static let XK_Thai_chochan = X11Keys(fromX11KeySym: 0x0da8)  /* U+0E08 THAI CHARACTER CHO CHAN */
    static let XK_Thai_choching = X11Keys(fromX11KeySym: 0x0da9)  /* U+0E09 THAI CHARACTER CHO CHING */
    static let XK_Thai_chochang = X11Keys(fromX11KeySym: 0x0daa)  /* U+0E0A THAI CHARACTER CHO CHANG */
    static let XK_Thai_soso = X11Keys(fromX11KeySym: 0x0dab)  /* U+0E0B THAI CHARACTER SO SO */
    static let XK_Thai_chochoe = X11Keys(fromX11KeySym: 0x0dac)  /* U+0E0C THAI CHARACTER CHO CHOE */
    static let XK_Thai_yoying = X11Keys(fromX11KeySym: 0x0dad)  /* U+0E0D THAI CHARACTER YO YING */
    static let XK_Thai_dochada = X11Keys(fromX11KeySym: 0x0dae)  /* U+0E0E THAI CHARACTER DO CHADA */
    static let XK_Thai_topatak = X11Keys(fromX11KeySym: 0x0daf)  /* U+0E0F THAI CHARACTER TO PATAK */
    static let XK_Thai_thothan = X11Keys(fromX11KeySym: 0x0db0)  /* U+0E10 THAI CHARACTER THO THAN */
    static let XK_Thai_thonangmontho = X11Keys(fromX11KeySym: 0x0db1)  /* U+0E11 THAI CHARACTER THO NANGMONTHO */
    static let XK_Thai_thophuthao = X11Keys(fromX11KeySym: 0x0db2)  /* U+0E12 THAI CHARACTER THO PHUTHAO */
    static let XK_Thai_nonen = X11Keys(fromX11KeySym: 0x0db3)  /* U+0E13 THAI CHARACTER NO NEN */
    static let XK_Thai_dodek = X11Keys(fromX11KeySym: 0x0db4)  /* U+0E14 THAI CHARACTER DO DEK */
    static let XK_Thai_totao = X11Keys(fromX11KeySym: 0x0db5)  /* U+0E15 THAI CHARACTER TO TAO */
    static let XK_Thai_thothung = X11Keys(fromX11KeySym: 0x0db6)  /* U+0E16 THAI CHARACTER THO THUNG */
    static let XK_Thai_thothahan = X11Keys(fromX11KeySym: 0x0db7)  /* U+0E17 THAI CHARACTER THO THAHAN */
    static let XK_Thai_thothong = X11Keys(fromX11KeySym: 0x0db8)  /* U+0E18 THAI CHARACTER THO THONG */
    static let XK_Thai_nonu = X11Keys(fromX11KeySym: 0x0db9)  /* U+0E19 THAI CHARACTER NO NU */
    static let XK_Thai_bobaimai = X11Keys(fromX11KeySym: 0x0dba)  /* U+0E1A THAI CHARACTER BO BAIMAI */
    static let XK_Thai_popla = X11Keys(fromX11KeySym: 0x0dbb)  /* U+0E1B THAI CHARACTER PO PLA */
    static let XK_Thai_phophung = X11Keys(fromX11KeySym: 0x0dbc)  /* U+0E1C THAI CHARACTER PHO PHUNG */
    static let XK_Thai_fofa = X11Keys(fromX11KeySym: 0x0dbd)  /* U+0E1D THAI CHARACTER FO FA */
    static let XK_Thai_phophan = X11Keys(fromX11KeySym: 0x0dbe)  /* U+0E1E THAI CHARACTER PHO PHAN */
    static let XK_Thai_fofan = X11Keys(fromX11KeySym: 0x0dbf)  /* U+0E1F THAI CHARACTER FO FAN */
    static let XK_Thai_phosamphao = X11Keys(fromX11KeySym: 0x0dc0)  /* U+0E20 THAI CHARACTER PHO SAMPHAO */
    static let XK_Thai_moma = X11Keys(fromX11KeySym: 0x0dc1)  /* U+0E21 THAI CHARACTER MO MA */
    static let XK_Thai_yoyak = X11Keys(fromX11KeySym: 0x0dc2)  /* U+0E22 THAI CHARACTER YO YAK */
    static let XK_Thai_rorua = X11Keys(fromX11KeySym: 0x0dc3)  /* U+0E23 THAI CHARACTER RO RUA */
    static let XK_Thai_ru = X11Keys(fromX11KeySym: 0x0dc4)  /* U+0E24 THAI CHARACTER RU */
    static let XK_Thai_loling = X11Keys(fromX11KeySym: 0x0dc5)  /* U+0E25 THAI CHARACTER LO LING */
    static let XK_Thai_lu = X11Keys(fromX11KeySym: 0x0dc6)  /* U+0E26 THAI CHARACTER LU */
    static let XK_Thai_wowaen = X11Keys(fromX11KeySym: 0x0dc7)  /* U+0E27 THAI CHARACTER WO WAEN */
    static let XK_Thai_sosala = X11Keys(fromX11KeySym: 0x0dc8)  /* U+0E28 THAI CHARACTER SO SALA */
    static let XK_Thai_sorusi = X11Keys(fromX11KeySym: 0x0dc9)  /* U+0E29 THAI CHARACTER SO RUSI */
    static let XK_Thai_sosua = X11Keys(fromX11KeySym: 0x0dca)  /* U+0E2A THAI CHARACTER SO SUA */
    static let XK_Thai_hohip = X11Keys(fromX11KeySym: 0x0dcb)  /* U+0E2B THAI CHARACTER HO HIP */
    static let XK_Thai_lochula = X11Keys(fromX11KeySym: 0x0dcc)  /* U+0E2C THAI CHARACTER LO CHULA */
    static let XK_Thai_oang = X11Keys(fromX11KeySym: 0x0dcd)  /* U+0E2D THAI CHARACTER O ANG */
    static let XK_Thai_honokhuk = X11Keys(fromX11KeySym: 0x0dce)  /* U+0E2E THAI CHARACTER HO NOKHUK */
    static let XK_Thai_paiyannoi = X11Keys(fromX11KeySym: 0x0dcf)  /* U+0E2F THAI CHARACTER PAIYANNOI */
    static let XK_Thai_saraa = X11Keys(fromX11KeySym: 0x0dd0)  /* U+0E30 THAI CHARACTER SARA A */
    static let XK_Thai_maihanakat = X11Keys(fromX11KeySym: 0x0dd1)  /* U+0E31 THAI CHARACTER MAI HAN-AKAT */
    static let XK_Thai_saraaa = X11Keys(fromX11KeySym: 0x0dd2)  /* U+0E32 THAI CHARACTER SARA AA */
    static let XK_Thai_saraam = X11Keys(fromX11KeySym: 0x0dd3)  /* U+0E33 THAI CHARACTER SARA AM */
    static let XK_Thai_sarai = X11Keys(fromX11KeySym: 0x0dd4)  /* U+0E34 THAI CHARACTER SARA I */
    static let XK_Thai_saraii = X11Keys(fromX11KeySym: 0x0dd5)  /* U+0E35 THAI CHARACTER SARA II */
    static let XK_Thai_saraue = X11Keys(fromX11KeySym: 0x0dd6)  /* U+0E36 THAI CHARACTER SARA UE */
    static let XK_Thai_sarauee = X11Keys(fromX11KeySym: 0x0dd7)  /* U+0E37 THAI CHARACTER SARA UEE */
    static let XK_Thai_sarau = X11Keys(fromX11KeySym: 0x0dd8)  /* U+0E38 THAI CHARACTER SARA U */
    static let XK_Thai_sarauu = X11Keys(fromX11KeySym: 0x0dd9)  /* U+0E39 THAI CHARACTER SARA UU */
    static let XK_Thai_phinthu = X11Keys(fromX11KeySym: 0x0dda)  /* U+0E3A THAI CHARACTER PHINTHU */
    static let XK_Thai_maihanakat_maitho = X11Keys(fromX11KeySym: 0x0dde)
    static let XK_Thai_baht = X11Keys(fromX11KeySym: 0x0ddf)  /* U+0E3F THAI CURRENCY SYMBOL BAHT */
    static let XK_Thai_sarae = X11Keys(fromX11KeySym: 0x0de0)  /* U+0E40 THAI CHARACTER SARA E */
    static let XK_Thai_saraae = X11Keys(fromX11KeySym: 0x0de1)  /* U+0E41 THAI CHARACTER SARA AE */
    static let XK_Thai_sarao = X11Keys(fromX11KeySym: 0x0de2)  /* U+0E42 THAI CHARACTER SARA O */
    static let XK_Thai_saraaimaimuan = X11Keys(fromX11KeySym: 0x0de3)  /* U+0E43 THAI CHARACTER SARA AI MAIMUAN */
    static let XK_Thai_saraaimaimalai = X11Keys(fromX11KeySym: 0x0de4)  /* U+0E44 THAI CHARACTER SARA AI MAIMALAI */
    static let XK_Thai_lakkhangyao = X11Keys(fromX11KeySym: 0x0de5)  /* U+0E45 THAI CHARACTER LAKKHANGYAO */
    static let XK_Thai_maiyamok = X11Keys(fromX11KeySym: 0x0de6)  /* U+0E46 THAI CHARACTER MAIYAMOK */
    static let XK_Thai_maitaikhu = X11Keys(fromX11KeySym: 0x0de7)  /* U+0E47 THAI CHARACTER MAITAIKHU */
    static let XK_Thai_maiek = X11Keys(fromX11KeySym: 0x0de8)  /* U+0E48 THAI CHARACTER MAI EK */
    static let XK_Thai_maitho = X11Keys(fromX11KeySym: 0x0de9)  /* U+0E49 THAI CHARACTER MAI THO */
    static let XK_Thai_maitri = X11Keys(fromX11KeySym: 0x0dea)  /* U+0E4A THAI CHARACTER MAI TRI */
    static let XK_Thai_maichattawa = X11Keys(fromX11KeySym: 0x0deb)  /* U+0E4B THAI CHARACTER MAI CHATTAWA */
    static let XK_Thai_thanthakhat = X11Keys(fromX11KeySym: 0x0dec)  /* U+0E4C THAI CHARACTER THANTHAKHAT */
    static let XK_Thai_nikhahit = X11Keys(fromX11KeySym: 0x0ded)  /* U+0E4D THAI CHARACTER NIKHAHIT */
    static let XK_Thai_leksun = X11Keys(fromX11KeySym: 0x0df0)  /* U+0E50 THAI DIGIT ZERO */
    static let XK_Thai_leknung = X11Keys(fromX11KeySym: 0x0df1)  /* U+0E51 THAI DIGIT ONE */
    static let XK_Thai_leksong = X11Keys(fromX11KeySym: 0x0df2)  /* U+0E52 THAI DIGIT TWO */
    static let XK_Thai_leksam = X11Keys(fromX11KeySym: 0x0df3)  /* U+0E53 THAI DIGIT THREE */
    static let XK_Thai_leksi = X11Keys(fromX11KeySym: 0x0df4)  /* U+0E54 THAI DIGIT FOUR */
    static let XK_Thai_lekha = X11Keys(fromX11KeySym: 0x0df5)  /* U+0E55 THAI DIGIT FIVE */
    static let XK_Thai_lekhok = X11Keys(fromX11KeySym: 0x0df6)  /* U+0E56 THAI DIGIT SIX */
    static let XK_Thai_lekchet = X11Keys(fromX11KeySym: 0x0df7)  /* U+0E57 THAI DIGIT SEVEN */
    static let XK_Thai_lekpaet = X11Keys(fromX11KeySym: 0x0df8)  /* U+0E58 THAI DIGIT EIGHT */
    static let XK_Thai_lekkao = X11Keys(fromX11KeySym: 0x0df9)  /* U+0E59 THAI DIGIT NINE */

    /*
    * Korean
    * Byte 3 = 0x0e
    */

    static let XK_Hangul = X11Keys(fromX11KeySym: 0xff31)  /* Hangul start/stop(toggle) */
    static let XK_Hangul_Start = X11Keys(fromX11KeySym: 0xff32)  /* Hangul start */
    static let XK_Hangul_End = X11Keys(fromX11KeySym: 0xff33)  /* Hangul end, English start */
    static let XK_Hangul_Hanja = X11Keys(fromX11KeySym: 0xff34)  /* Start Hangul->Hanja Conversion */
    static let XK_Hangul_Jamo = X11Keys(fromX11KeySym: 0xff35)  /* Hangul Jamo mode */
    static let XK_Hangul_Romaja = X11Keys(fromX11KeySym: 0xff36)  /* Hangul Romaja mode */
    static let XK_Hangul_Codeinput = X11Keys(fromX11KeySym: 0xff37)  /* Hangul code input mode */
    static let XK_Hangul_Jeonja = X11Keys(fromX11KeySym: 0xff38)  /* Jeonja mode */
    static let XK_Hangul_Banja = X11Keys(fromX11KeySym: 0xff39)  /* Banja mode */
    static let XK_Hangul_PreHanja = X11Keys(fromX11KeySym: 0xff3a)  /* Pre Hanja conversion */
    static let XK_Hangul_PostHanja = X11Keys(fromX11KeySym: 0xff3b)  /* Post Hanja conversion */
    static let XK_Hangul_SingleCandidate = X11Keys(fromX11KeySym: 0xff3c)  /* Single candidate */
    static let XK_Hangul_MultipleCandidate = X11Keys(fromX11KeySym: 0xff3d)  /* Multiple candidate */
    static let XK_Hangul_PreviousCandidate = X11Keys(fromX11KeySym: 0xff3e)  /* Previous candidate */
    static let XK_Hangul_Special = X11Keys(fromX11KeySym: 0xff3f)  /* Special symbols */
    static let XK_Hangul_switch = X11Keys(fromX11KeySym: 0xff7e)  /* Alias for mode_switch */

    /* Hangul Consonant Characters */
    static let XK_Hangul_Kiyeog = X11Keys(fromX11KeySym: 0x0ea1)  /* U+3131 HANGUL LETTER KIYEOK */
    static let XK_Hangul_SsangKiyeog = X11Keys(fromX11KeySym: 0x0ea2)  /* U+3132 HANGUL LETTER SSANGKIYEOK */
    static let XK_Hangul_KiyeogSios = X11Keys(fromX11KeySym: 0x0ea3)  /* U+3133 HANGUL LETTER KIYEOK-SIOS */
    static let XK_Hangul_Nieun = X11Keys(fromX11KeySym: 0x0ea4)  /* U+3134 HANGUL LETTER NIEUN */
    static let XK_Hangul_NieunJieuj = X11Keys(fromX11KeySym: 0x0ea5)  /* U+3135 HANGUL LETTER NIEUN-CIEUC */
    static let XK_Hangul_NieunHieuh = X11Keys(fromX11KeySym: 0x0ea6)  /* U+3136 HANGUL LETTER NIEUN-HIEUH */
    static let XK_Hangul_Dikeud = X11Keys(fromX11KeySym: 0x0ea7)  /* U+3137 HANGUL LETTER TIKEUT */
    static let XK_Hangul_SsangDikeud = X11Keys(fromX11KeySym: 0x0ea8)  /* U+3138 HANGUL LETTER SSANGTIKEUT */
    static let XK_Hangul_Rieul = X11Keys(fromX11KeySym: 0x0ea9)  /* U+3139 HANGUL LETTER RIEUL */
    static let XK_Hangul_RieulKiyeog = X11Keys(fromX11KeySym: 0x0eaa)  /* U+313A HANGUL LETTER RIEUL-KIYEOK */
    static let XK_Hangul_RieulMieum = X11Keys(fromX11KeySym: 0x0eab)  /* U+313B HANGUL LETTER RIEUL-MIEUM */
    static let XK_Hangul_RieulPieub = X11Keys(fromX11KeySym: 0x0eac)  /* U+313C HANGUL LETTER RIEUL-PIEUP */
    static let XK_Hangul_RieulSios = X11Keys(fromX11KeySym: 0x0ead)  /* U+313D HANGUL LETTER RIEUL-SIOS */
    static let XK_Hangul_RieulTieut = X11Keys(fromX11KeySym: 0x0eae)  /* U+313E HANGUL LETTER RIEUL-THIEUTH */
    static let XK_Hangul_RieulPhieuf = X11Keys(fromX11KeySym: 0x0eaf)  /* U+313F HANGUL LETTER RIEUL-PHIEUPH */
    static let XK_Hangul_RieulHieuh = X11Keys(fromX11KeySym: 0x0eb0)  /* U+3140 HANGUL LETTER RIEUL-HIEUH */
    static let XK_Hangul_Mieum = X11Keys(fromX11KeySym: 0x0eb1)  /* U+3141 HANGUL LETTER MIEUM */
    static let XK_Hangul_Pieub = X11Keys(fromX11KeySym: 0x0eb2)  /* U+3142 HANGUL LETTER PIEUP */
    static let XK_Hangul_SsangPieub = X11Keys(fromX11KeySym: 0x0eb3)  /* U+3143 HANGUL LETTER SSANGPIEUP */
    static let XK_Hangul_PieubSios = X11Keys(fromX11KeySym: 0x0eb4)  /* U+3144 HANGUL LETTER PIEUP-SIOS */
    static let XK_Hangul_Sios = X11Keys(fromX11KeySym: 0x0eb5)  /* U+3145 HANGUL LETTER SIOS */
    static let XK_Hangul_SsangSios = X11Keys(fromX11KeySym: 0x0eb6)  /* U+3146 HANGUL LETTER SSANGSIOS */
    static let XK_Hangul_Ieung = X11Keys(fromX11KeySym: 0x0eb7)  /* U+3147 HANGUL LETTER IEUNG */
    static let XK_Hangul_Jieuj = X11Keys(fromX11KeySym: 0x0eb8)  /* U+3148 HANGUL LETTER CIEUC */
    static let XK_Hangul_SsangJieuj = X11Keys(fromX11KeySym: 0x0eb9)  /* U+3149 HANGUL LETTER SSANGCIEUC */
    static let XK_Hangul_Cieuc = X11Keys(fromX11KeySym: 0x0eba)  /* U+314A HANGUL LETTER CHIEUCH */
    static let XK_Hangul_Khieuq = X11Keys(fromX11KeySym: 0x0ebb)  /* U+314B HANGUL LETTER KHIEUKH */
    static let XK_Hangul_Tieut = X11Keys(fromX11KeySym: 0x0ebc)  /* U+314C HANGUL LETTER THIEUTH */
    static let XK_Hangul_Phieuf = X11Keys(fromX11KeySym: 0x0ebd)  /* U+314D HANGUL LETTER PHIEUPH */
    static let XK_Hangul_Hieuh = X11Keys(fromX11KeySym: 0x0ebe)  /* U+314E HANGUL LETTER HIEUH */

    /* Hangul Vowel Characters */
    static let XK_Hangul_A = X11Keys(fromX11KeySym: 0x0ebf)  /* U+314F HANGUL LETTER A */
    static let XK_Hangul_AE = X11Keys(fromX11KeySym: 0x0ec0)  /* U+3150 HANGUL LETTER AE */
    static let XK_Hangul_YA = X11Keys(fromX11KeySym: 0x0ec1)  /* U+3151 HANGUL LETTER YA */
    static let XK_Hangul_YAE = X11Keys(fromX11KeySym: 0x0ec2)  /* U+3152 HANGUL LETTER YAE */
    static let XK_Hangul_EO = X11Keys(fromX11KeySym: 0x0ec3)  /* U+3153 HANGUL LETTER EO */
    static let XK_Hangul_E = X11Keys(fromX11KeySym: 0x0ec4)  /* U+3154 HANGUL LETTER E */
    static let XK_Hangul_YEO = X11Keys(fromX11KeySym: 0x0ec5)  /* U+3155 HANGUL LETTER YEO */
    static let XK_Hangul_YE = X11Keys(fromX11KeySym: 0x0ec6)  /* U+3156 HANGUL LETTER YE */
    static let XK_Hangul_O = X11Keys(fromX11KeySym: 0x0ec7)  /* U+3157 HANGUL LETTER O */
    static let XK_Hangul_WA = X11Keys(fromX11KeySym: 0x0ec8)  /* U+3158 HANGUL LETTER WA */
    static let XK_Hangul_WAE = X11Keys(fromX11KeySym: 0x0ec9)  /* U+3159 HANGUL LETTER WAE */
    static let XK_Hangul_OE = X11Keys(fromX11KeySym: 0x0eca)  /* U+315A HANGUL LETTER OE */
    static let XK_Hangul_YO = X11Keys(fromX11KeySym: 0x0ecb)  /* U+315B HANGUL LETTER YO */
    static let XK_Hangul_U = X11Keys(fromX11KeySym: 0x0ecc)  /* U+315C HANGUL LETTER U */
    static let XK_Hangul_WEO = X11Keys(fromX11KeySym: 0x0ecd)  /* U+315D HANGUL LETTER WEO */
    static let XK_Hangul_WE = X11Keys(fromX11KeySym: 0x0ece)  /* U+315E HANGUL LETTER WE */
    static let XK_Hangul_WI = X11Keys(fromX11KeySym: 0x0ecf)  /* U+315F HANGUL LETTER WI */
    static let XK_Hangul_YU = X11Keys(fromX11KeySym: 0x0ed0)  /* U+3160 HANGUL LETTER YU */
    static let XK_Hangul_EU = X11Keys(fromX11KeySym: 0x0ed1)  /* U+3161 HANGUL LETTER EU */
    static let XK_Hangul_YI = X11Keys(fromX11KeySym: 0x0ed2)  /* U+3162 HANGUL LETTER YI */
    static let XK_Hangul_I = X11Keys(fromX11KeySym: 0x0ed3)  /* U+3163 HANGUL LETTER I */

    /* Hangul syllable-final (JongSeong) Characters */
    static let XK_Hangul_J_Kiyeog = X11Keys(fromX11KeySym: 0x0ed4)  /* U+11A8 HANGUL JONGSEONG KIYEOK */
    static let XK_Hangul_J_SsangKiyeog = X11Keys(fromX11KeySym: 0x0ed5)  /* U+11A9 HANGUL JONGSEONG SSANGKIYEOK */
    static let XK_Hangul_J_KiyeogSios = X11Keys(fromX11KeySym: 0x0ed6)  /* U+11AA HANGUL JONGSEONG KIYEOK-SIOS */
    static let XK_Hangul_J_Nieun = X11Keys(fromX11KeySym: 0x0ed7)  /* U+11AB HANGUL JONGSEONG NIEUN */
    static let XK_Hangul_J_NieunJieuj = X11Keys(fromX11KeySym: 0x0ed8)  /* U+11AC HANGUL JONGSEONG NIEUN-CIEUC */
    static let XK_Hangul_J_NieunHieuh = X11Keys(fromX11KeySym: 0x0ed9)  /* U+11AD HANGUL JONGSEONG NIEUN-HIEUH */
    static let XK_Hangul_J_Dikeud = X11Keys(fromX11KeySym: 0x0eda)  /* U+11AE HANGUL JONGSEONG TIKEUT */
    static let XK_Hangul_J_Rieul = X11Keys(fromX11KeySym: 0x0edb)  /* U+11AF HANGUL JONGSEONG RIEUL */
    static let XK_Hangul_J_RieulKiyeog = X11Keys(fromX11KeySym: 0x0edc)  /* U+11B0 HANGUL JONGSEONG RIEUL-KIYEOK */
    static let XK_Hangul_J_RieulMieum = X11Keys(fromX11KeySym: 0x0edd)  /* U+11B1 HANGUL JONGSEONG RIEUL-MIEUM */
    static let XK_Hangul_J_RieulPieub = X11Keys(fromX11KeySym: 0x0ede)  /* U+11B2 HANGUL JONGSEONG RIEUL-PIEUP */
    static let XK_Hangul_J_RieulSios = X11Keys(fromX11KeySym: 0x0edf)  /* U+11B3 HANGUL JONGSEONG RIEUL-SIOS */
    static let XK_Hangul_J_RieulTieut = X11Keys(fromX11KeySym: 0x0ee0)  /* U+11B4 HANGUL JONGSEONG RIEUL-THIEUTH */
    static let XK_Hangul_J_RieulPhieuf = X11Keys(fromX11KeySym: 0x0ee1)  /* U+11B5 HANGUL JONGSEONG RIEUL-PHIEUPH */
    static let XK_Hangul_J_RieulHieuh = X11Keys(fromX11KeySym: 0x0ee2)  /* U+11B6 HANGUL JONGSEONG RIEUL-HIEUH */
    static let XK_Hangul_J_Mieum = X11Keys(fromX11KeySym: 0x0ee3)  /* U+11B7 HANGUL JONGSEONG MIEUM */
    static let XK_Hangul_J_Pieub = X11Keys(fromX11KeySym: 0x0ee4)  /* U+11B8 HANGUL JONGSEONG PIEUP */
    static let XK_Hangul_J_PieubSios = X11Keys(fromX11KeySym: 0x0ee5)  /* U+11B9 HANGUL JONGSEONG PIEUP-SIOS */
    static let XK_Hangul_J_Sios = X11Keys(fromX11KeySym: 0x0ee6)  /* U+11BA HANGUL JONGSEONG SIOS */
    static let XK_Hangul_J_SsangSios = X11Keys(fromX11KeySym: 0x0ee7)  /* U+11BB HANGUL JONGSEONG SSANGSIOS */
    static let XK_Hangul_J_Ieung = X11Keys(fromX11KeySym: 0x0ee8)  /* U+11BC HANGUL JONGSEONG IEUNG */
    static let XK_Hangul_J_Jieuj = X11Keys(fromX11KeySym: 0x0ee9)  /* U+11BD HANGUL JONGSEONG CIEUC */
    static let XK_Hangul_J_Cieuc = X11Keys(fromX11KeySym: 0x0eea)  /* U+11BE HANGUL JONGSEONG CHIEUCH */
    static let XK_Hangul_J_Khieuq = X11Keys(fromX11KeySym: 0x0eeb)  /* U+11BF HANGUL JONGSEONG KHIEUKH */
    static let XK_Hangul_J_Tieut = X11Keys(fromX11KeySym: 0x0eec)  /* U+11C0 HANGUL JONGSEONG THIEUTH */
    static let XK_Hangul_J_Phieuf = X11Keys(fromX11KeySym: 0x0eed)  /* U+11C1 HANGUL JONGSEONG PHIEUPH */
    static let XK_Hangul_J_Hieuh = X11Keys(fromX11KeySym: 0x0eee)  /* U+11C2 HANGUL JONGSEONG HIEUH */

    /* Ancient Hangul Consonant Characters */
    static let XK_Hangul_RieulYeorinHieuh = X11Keys(fromX11KeySym: 0x0eef)  /* U+316D HANGUL LETTER RIEUL-YEORINHIEUH */
    static let XK_Hangul_SunkyeongeumMieum = X11Keys(fromX11KeySym: 0x0ef0)  /* U+3171 HANGUL LETTER KAPYEOUNMIEUM */
    static let XK_Hangul_SunkyeongeumPieub = X11Keys(fromX11KeySym: 0x0ef1)  /* U+3178 HANGUL LETTER KAPYEOUNPIEUP */
    static let XK_Hangul_PanSios = X11Keys(fromX11KeySym: 0x0ef2)  /* U+317F HANGUL LETTER PANSIOS */
    static let XK_Hangul_KkogjiDalrinIeung = X11Keys(fromX11KeySym: 0x0ef3)  /* U+3181 HANGUL LETTER YESIEUNG */
    static let XK_Hangul_SunkyeongeumPhieuf = X11Keys(fromX11KeySym: 0x0ef4)  /* U+3184 HANGUL LETTER KAPYEOUNPHIEUPH */
    static let XK_Hangul_YeorinHieuh = X11Keys(fromX11KeySym: 0x0ef5)  /* U+3186 HANGUL LETTER YEORINHIEUH */

    /* Ancient Hangul Vowel Characters */
    static let XK_Hangul_AraeA = X11Keys(fromX11KeySym: 0x0ef6)  /* U+318D HANGUL LETTER ARAEA */
    static let XK_Hangul_AraeAE = X11Keys(fromX11KeySym: 0x0ef7)  /* U+318E HANGUL LETTER ARAEAE */

    /* Ancient Hangul syllable-final (JongSeong) Characters */
    static let XK_Hangul_J_PanSios = X11Keys(fromX11KeySym: 0x0ef8)  /* U+11EB HANGUL JONGSEONG PANSIOS */
    static let XK_Hangul_J_KkogjiDalrinIeung = X11Keys(fromX11KeySym: 0x0ef9)  /* U+11F0 HANGUL JONGSEONG YESIEUNG */
    static let XK_Hangul_J_YeorinHieuh = X11Keys(fromX11KeySym: 0x0efa)  /* U+11F9 HANGUL JONGSEONG YEORINHIEUH */

    /* Korean currency symbol */
    static let XK_Korean_Won = X11Keys(fromX11KeySym: 0x0eff)  /*(U+20A9 WON SIGN)*/

    /*
    * Armenian
    */

    static let XK_Armenian_ligature_ew = X11Keys(fromX11KeySym: 0x1000587)  /* U+0587 ARMENIAN SMALL LIGATURE ECH YIWN */
    static let XK_Armenian_full_stop = X11Keys(fromX11KeySym: 0x1000589)  /* U+0589 ARMENIAN FULL STOP */
    static let XK_Armenian_verjaket = X11Keys(fromX11KeySym: 0x1000589)  /* U+0589 ARMENIAN FULL STOP */
    static let XK_Armenian_separation_mark = X11Keys(fromX11KeySym: 0x100055d)  /* U+055D ARMENIAN COMMA */
    static let XK_Armenian_but = X11Keys(fromX11KeySym: 0x100055d)  /* U+055D ARMENIAN COMMA */
    static let XK_Armenian_hyphen = X11Keys(fromX11KeySym: 0x100058a)  /* U+058A ARMENIAN HYPHEN */
    static let XK_Armenian_yentamna = X11Keys(fromX11KeySym: 0x100058a)  /* U+058A ARMENIAN HYPHEN */
    static let XK_Armenian_exclam = X11Keys(fromX11KeySym: 0x100055c)  /* U+055C ARMENIAN EXCLAMATION MARK */
    static let XK_Armenian_amanak = X11Keys(fromX11KeySym: 0x100055c)  /* U+055C ARMENIAN EXCLAMATION MARK */
    static let XK_Armenian_accent = X11Keys(fromX11KeySym: 0x100055b)  /* U+055B ARMENIAN EMPHASIS MARK */
    static let XK_Armenian_shesht = X11Keys(fromX11KeySym: 0x100055b)  /* U+055B ARMENIAN EMPHASIS MARK */
    static let XK_Armenian_question = X11Keys(fromX11KeySym: 0x100055e)  /* U+055E ARMENIAN QUESTION MARK */
    static let XK_Armenian_paruyk = X11Keys(fromX11KeySym: 0x100055e)  /* U+055E ARMENIAN QUESTION MARK */
    static let XK_Armenian_AYB = X11Keys(fromX11KeySym: 0x1000531)  /* U+0531 ARMENIAN CAPITAL LETTER AYB */
    static let XK_Armenian_ayb = X11Keys(fromX11KeySym: 0x1000561)  /* U+0561 ARMENIAN SMALL LETTER AYB */
    static let XK_Armenian_BEN = X11Keys(fromX11KeySym: 0x1000532)  /* U+0532 ARMENIAN CAPITAL LETTER BEN */
    static let XK_Armenian_ben = X11Keys(fromX11KeySym: 0x1000562)  /* U+0562 ARMENIAN SMALL LETTER BEN */
    static let XK_Armenian_GIM = X11Keys(fromX11KeySym: 0x1000533)  /* U+0533 ARMENIAN CAPITAL LETTER GIM */
    static let XK_Armenian_gim = X11Keys(fromX11KeySym: 0x1000563)  /* U+0563 ARMENIAN SMALL LETTER GIM */
    static let XK_Armenian_DA = X11Keys(fromX11KeySym: 0x1000534)  /* U+0534 ARMENIAN CAPITAL LETTER DA */
    static let XK_Armenian_da = X11Keys(fromX11KeySym: 0x1000564)  /* U+0564 ARMENIAN SMALL LETTER DA */
    static let XK_Armenian_YECH = X11Keys(fromX11KeySym: 0x1000535)  /* U+0535 ARMENIAN CAPITAL LETTER ECH */
    static let XK_Armenian_yech = X11Keys(fromX11KeySym: 0x1000565)  /* U+0565 ARMENIAN SMALL LETTER ECH */
    static let XK_Armenian_ZA = X11Keys(fromX11KeySym: 0x1000536)  /* U+0536 ARMENIAN CAPITAL LETTER ZA */
    static let XK_Armenian_za = X11Keys(fromX11KeySym: 0x1000566)  /* U+0566 ARMENIAN SMALL LETTER ZA */
    static let XK_Armenian_E = X11Keys(fromX11KeySym: 0x1000537)  /* U+0537 ARMENIAN CAPITAL LETTER EH */
    static let XK_Armenian_e = X11Keys(fromX11KeySym: 0x1000567)  /* U+0567 ARMENIAN SMALL LETTER EH */
    static let XK_Armenian_AT = X11Keys(fromX11KeySym: 0x1000538)  /* U+0538 ARMENIAN CAPITAL LETTER ET */
    static let XK_Armenian_at = X11Keys(fromX11KeySym: 0x1000568)  /* U+0568 ARMENIAN SMALL LETTER ET */
    static let XK_Armenian_TO = X11Keys(fromX11KeySym: 0x1000539)  /* U+0539 ARMENIAN CAPITAL LETTER TO */
    static let XK_Armenian_to = X11Keys(fromX11KeySym: 0x1000569)  /* U+0569 ARMENIAN SMALL LETTER TO */
    static let XK_Armenian_ZHE = X11Keys(fromX11KeySym: 0x100053a)  /* U+053A ARMENIAN CAPITAL LETTER ZHE */
    static let XK_Armenian_zhe = X11Keys(fromX11KeySym: 0x100056a)  /* U+056A ARMENIAN SMALL LETTER ZHE */
    static let XK_Armenian_INI = X11Keys(fromX11KeySym: 0x100053b)  /* U+053B ARMENIAN CAPITAL LETTER INI */
    static let XK_Armenian_ini = X11Keys(fromX11KeySym: 0x100056b)  /* U+056B ARMENIAN SMALL LETTER INI */
    static let XK_Armenian_LYUN = X11Keys(fromX11KeySym: 0x100053c)  /* U+053C ARMENIAN CAPITAL LETTER LIWN */
    static let XK_Armenian_lyun = X11Keys(fromX11KeySym: 0x100056c)  /* U+056C ARMENIAN SMALL LETTER LIWN */
    static let XK_Armenian_KHE = X11Keys(fromX11KeySym: 0x100053d)  /* U+053D ARMENIAN CAPITAL LETTER XEH */
    static let XK_Armenian_khe = X11Keys(fromX11KeySym: 0x100056d)  /* U+056D ARMENIAN SMALL LETTER XEH */
    static let XK_Armenian_TSA = X11Keys(fromX11KeySym: 0x100053e)  /* U+053E ARMENIAN CAPITAL LETTER CA */
    static let XK_Armenian_tsa = X11Keys(fromX11KeySym: 0x100056e)  /* U+056E ARMENIAN SMALL LETTER CA */
    static let XK_Armenian_KEN = X11Keys(fromX11KeySym: 0x100053f)  /* U+053F ARMENIAN CAPITAL LETTER KEN */
    static let XK_Armenian_ken = X11Keys(fromX11KeySym: 0x100056f)  /* U+056F ARMENIAN SMALL LETTER KEN */
    static let XK_Armenian_HO = X11Keys(fromX11KeySym: 0x1000540)  /* U+0540 ARMENIAN CAPITAL LETTER HO */
    static let XK_Armenian_ho = X11Keys(fromX11KeySym: 0x1000570)  /* U+0570 ARMENIAN SMALL LETTER HO */
    static let XK_Armenian_DZA = X11Keys(fromX11KeySym: 0x1000541)  /* U+0541 ARMENIAN CAPITAL LETTER JA */
    static let XK_Armenian_dza = X11Keys(fromX11KeySym: 0x1000571)  /* U+0571 ARMENIAN SMALL LETTER JA */
    static let XK_Armenian_GHAT = X11Keys(fromX11KeySym: 0x1000542)  /* U+0542 ARMENIAN CAPITAL LETTER GHAD */
    static let XK_Armenian_ghat = X11Keys(fromX11KeySym: 0x1000572)  /* U+0572 ARMENIAN SMALL LETTER GHAD */
    static let XK_Armenian_TCHE = X11Keys(fromX11KeySym: 0x1000543)  /* U+0543 ARMENIAN CAPITAL LETTER CHEH */
    static let XK_Armenian_tche = X11Keys(fromX11KeySym: 0x1000573)  /* U+0573 ARMENIAN SMALL LETTER CHEH */
    static let XK_Armenian_MEN = X11Keys(fromX11KeySym: 0x1000544)  /* U+0544 ARMENIAN CAPITAL LETTER MEN */
    static let XK_Armenian_men = X11Keys(fromX11KeySym: 0x1000574)  /* U+0574 ARMENIAN SMALL LETTER MEN */
    static let XK_Armenian_HI = X11Keys(fromX11KeySym: 0x1000545)  /* U+0545 ARMENIAN CAPITAL LETTER YI */
    static let XK_Armenian_hi = X11Keys(fromX11KeySym: 0x1000575)  /* U+0575 ARMENIAN SMALL LETTER YI */
    static let XK_Armenian_NU = X11Keys(fromX11KeySym: 0x1000546)  /* U+0546 ARMENIAN CAPITAL LETTER NOW */
    static let XK_Armenian_nu = X11Keys(fromX11KeySym: 0x1000576)  /* U+0576 ARMENIAN SMALL LETTER NOW */
    static let XK_Armenian_SHA = X11Keys(fromX11KeySym: 0x1000547)  /* U+0547 ARMENIAN CAPITAL LETTER SHA */
    static let XK_Armenian_sha = X11Keys(fromX11KeySym: 0x1000577)  /* U+0577 ARMENIAN SMALL LETTER SHA */
    static let XK_Armenian_VO = X11Keys(fromX11KeySym: 0x1000548)  /* U+0548 ARMENIAN CAPITAL LETTER VO */
    static let XK_Armenian_vo = X11Keys(fromX11KeySym: 0x1000578)  /* U+0578 ARMENIAN SMALL LETTER VO */
    static let XK_Armenian_CHA = X11Keys(fromX11KeySym: 0x1000549)  /* U+0549 ARMENIAN CAPITAL LETTER CHA */
    static let XK_Armenian_cha = X11Keys(fromX11KeySym: 0x1000579)  /* U+0579 ARMENIAN SMALL LETTER CHA */
    static let XK_Armenian_PE = X11Keys(fromX11KeySym: 0x100054a)  /* U+054A ARMENIAN CAPITAL LETTER PEH */
    static let XK_Armenian_pe = X11Keys(fromX11KeySym: 0x100057a)  /* U+057A ARMENIAN SMALL LETTER PEH */
    static let XK_Armenian_JE = X11Keys(fromX11KeySym: 0x100054b)  /* U+054B ARMENIAN CAPITAL LETTER JHEH */
    static let XK_Armenian_je = X11Keys(fromX11KeySym: 0x100057b)  /* U+057B ARMENIAN SMALL LETTER JHEH */
    static let XK_Armenian_RA = X11Keys(fromX11KeySym: 0x100054c)  /* U+054C ARMENIAN CAPITAL LETTER RA */
    static let XK_Armenian_ra = X11Keys(fromX11KeySym: 0x100057c)  /* U+057C ARMENIAN SMALL LETTER RA */
    static let XK_Armenian_SE = X11Keys(fromX11KeySym: 0x100054d)  /* U+054D ARMENIAN CAPITAL LETTER SEH */
    static let XK_Armenian_se = X11Keys(fromX11KeySym: 0x100057d)  /* U+057D ARMENIAN SMALL LETTER SEH */
    static let XK_Armenian_VEV = X11Keys(fromX11KeySym: 0x100054e)  /* U+054E ARMENIAN CAPITAL LETTER VEW */
    static let XK_Armenian_vev = X11Keys(fromX11KeySym: 0x100057e)  /* U+057E ARMENIAN SMALL LETTER VEW */
    static let XK_Armenian_TYUN = X11Keys(fromX11KeySym: 0x100054f)  /* U+054F ARMENIAN CAPITAL LETTER TIWN */
    static let XK_Armenian_tyun = X11Keys(fromX11KeySym: 0x100057f)  /* U+057F ARMENIAN SMALL LETTER TIWN */
    static let XK_Armenian_RE = X11Keys(fromX11KeySym: 0x1000550)  /* U+0550 ARMENIAN CAPITAL LETTER REH */
    static let XK_Armenian_re = X11Keys(fromX11KeySym: 0x1000580)  /* U+0580 ARMENIAN SMALL LETTER REH */
    static let XK_Armenian_TSO = X11Keys(fromX11KeySym: 0x1000551)  /* U+0551 ARMENIAN CAPITAL LETTER CO */
    static let XK_Armenian_tso = X11Keys(fromX11KeySym: 0x1000581)  /* U+0581 ARMENIAN SMALL LETTER CO */
    static let XK_Armenian_VYUN = X11Keys(fromX11KeySym: 0x1000552)  /* U+0552 ARMENIAN CAPITAL LETTER YIWN */
    static let XK_Armenian_vyun = X11Keys(fromX11KeySym: 0x1000582)  /* U+0582 ARMENIAN SMALL LETTER YIWN */
    static let XK_Armenian_PYUR = X11Keys(fromX11KeySym: 0x1000553)  /* U+0553 ARMENIAN CAPITAL LETTER PIWR */
    static let XK_Armenian_pyur = X11Keys(fromX11KeySym: 0x1000583)  /* U+0583 ARMENIAN SMALL LETTER PIWR */
    static let XK_Armenian_KE = X11Keys(fromX11KeySym: 0x1000554)  /* U+0554 ARMENIAN CAPITAL LETTER KEH */
    static let XK_Armenian_ke = X11Keys(fromX11KeySym: 0x1000584)  /* U+0584 ARMENIAN SMALL LETTER KEH */
    static let XK_Armenian_O = X11Keys(fromX11KeySym: 0x1000555)  /* U+0555 ARMENIAN CAPITAL LETTER OH */
    static let XK_Armenian_o = X11Keys(fromX11KeySym: 0x1000585)  /* U+0585 ARMENIAN SMALL LETTER OH */
    static let XK_Armenian_FE = X11Keys(fromX11KeySym: 0x1000556)  /* U+0556 ARMENIAN CAPITAL LETTER FEH */
    static let XK_Armenian_fe = X11Keys(fromX11KeySym: 0x1000586)  /* U+0586 ARMENIAN SMALL LETTER FEH */
    static let XK_Armenian_apostrophe = X11Keys(fromX11KeySym: 0x100055a)  /* U+055A ARMENIAN APOSTROPHE */

    /*
    * Georgian
    */

    static let XK_Georgian_an = X11Keys(fromX11KeySym: 0x10010d0)  /* U+10D0 GEORGIAN LETTER AN */
    static let XK_Georgian_ban = X11Keys(fromX11KeySym: 0x10010d1)  /* U+10D1 GEORGIAN LETTER BAN */
    static let XK_Georgian_gan = X11Keys(fromX11KeySym: 0x10010d2)  /* U+10D2 GEORGIAN LETTER GAN */
    static let XK_Georgian_don = X11Keys(fromX11KeySym: 0x10010d3)  /* U+10D3 GEORGIAN LETTER DON */
    static let XK_Georgian_en = X11Keys(fromX11KeySym: 0x10010d4)  /* U+10D4 GEORGIAN LETTER EN */
    static let XK_Georgian_vin = X11Keys(fromX11KeySym: 0x10010d5)  /* U+10D5 GEORGIAN LETTER VIN */
    static let XK_Georgian_zen = X11Keys(fromX11KeySym: 0x10010d6)  /* U+10D6 GEORGIAN LETTER ZEN */
    static let XK_Georgian_tan = X11Keys(fromX11KeySym: 0x10010d7)  /* U+10D7 GEORGIAN LETTER TAN */
    static let XK_Georgian_in = X11Keys(fromX11KeySym: 0x10010d8)  /* U+10D8 GEORGIAN LETTER IN */
    static let XK_Georgian_kan = X11Keys(fromX11KeySym: 0x10010d9)  /* U+10D9 GEORGIAN LETTER KAN */
    static let XK_Georgian_las = X11Keys(fromX11KeySym: 0x10010da)  /* U+10DA GEORGIAN LETTER LAS */
    static let XK_Georgian_man = X11Keys(fromX11KeySym: 0x10010db)  /* U+10DB GEORGIAN LETTER MAN */
    static let XK_Georgian_nar = X11Keys(fromX11KeySym: 0x10010dc)  /* U+10DC GEORGIAN LETTER NAR */
    static let XK_Georgian_on = X11Keys(fromX11KeySym: 0x10010dd)  /* U+10DD GEORGIAN LETTER ON */
    static let XK_Georgian_par = X11Keys(fromX11KeySym: 0x10010de)  /* U+10DE GEORGIAN LETTER PAR */
    static let XK_Georgian_zhar = X11Keys(fromX11KeySym: 0x10010df)  /* U+10DF GEORGIAN LETTER ZHAR */
    static let XK_Georgian_rae = X11Keys(fromX11KeySym: 0x10010e0)  /* U+10E0 GEORGIAN LETTER RAE */
    static let XK_Georgian_san = X11Keys(fromX11KeySym: 0x10010e1)  /* U+10E1 GEORGIAN LETTER SAN */
    static let XK_Georgian_tar = X11Keys(fromX11KeySym: 0x10010e2)  /* U+10E2 GEORGIAN LETTER TAR */
    static let XK_Georgian_un = X11Keys(fromX11KeySym: 0x10010e3)  /* U+10E3 GEORGIAN LETTER UN */
    static let XK_Georgian_phar = X11Keys(fromX11KeySym: 0x10010e4)  /* U+10E4 GEORGIAN LETTER PHAR */
    static let XK_Georgian_khar = X11Keys(fromX11KeySym: 0x10010e5)  /* U+10E5 GEORGIAN LETTER KHAR */
    static let XK_Georgian_ghan = X11Keys(fromX11KeySym: 0x10010e6)  /* U+10E6 GEORGIAN LETTER GHAN */
    static let XK_Georgian_qar = X11Keys(fromX11KeySym: 0x10010e7)  /* U+10E7 GEORGIAN LETTER QAR */
    static let XK_Georgian_shin = X11Keys(fromX11KeySym: 0x10010e8)  /* U+10E8 GEORGIAN LETTER SHIN */
    static let XK_Georgian_chin = X11Keys(fromX11KeySym: 0x10010e9)  /* U+10E9 GEORGIAN LETTER CHIN */
    static let XK_Georgian_can = X11Keys(fromX11KeySym: 0x10010ea)  /* U+10EA GEORGIAN LETTER CAN */
    static let XK_Georgian_jil = X11Keys(fromX11KeySym: 0x10010eb)  /* U+10EB GEORGIAN LETTER JIL */
    static let XK_Georgian_cil = X11Keys(fromX11KeySym: 0x10010ec)  /* U+10EC GEORGIAN LETTER CIL */
    static let XK_Georgian_char = X11Keys(fromX11KeySym: 0x10010ed)  /* U+10ED GEORGIAN LETTER CHAR */
    static let XK_Georgian_xan = X11Keys(fromX11KeySym: 0x10010ee)  /* U+10EE GEORGIAN LETTER XAN */
    static let XK_Georgian_jhan = X11Keys(fromX11KeySym: 0x10010ef)  /* U+10EF GEORGIAN LETTER JHAN */
    static let XK_Georgian_hae = X11Keys(fromX11KeySym: 0x10010f0)  /* U+10F0 GEORGIAN LETTER HAE */
    static let XK_Georgian_he = X11Keys(fromX11KeySym: 0x10010f1)  /* U+10F1 GEORGIAN LETTER HE */
    static let XK_Georgian_hie = X11Keys(fromX11KeySym: 0x10010f2)  /* U+10F2 GEORGIAN LETTER HIE */
    static let XK_Georgian_we = X11Keys(fromX11KeySym: 0x10010f3)  /* U+10F3 GEORGIAN LETTER WE */
    static let XK_Georgian_har = X11Keys(fromX11KeySym: 0x10010f4)  /* U+10F4 GEORGIAN LETTER HAR */
    static let XK_Georgian_hoe = X11Keys(fromX11KeySym: 0x10010f5)  /* U+10F5 GEORGIAN LETTER HOE */
    static let XK_Georgian_fi = X11Keys(fromX11KeySym: 0x10010f6)  /* U+10F6 GEORGIAN LETTER FI */

    /*
    * Azeri (and other Turkic or Caucasian languages)
    */

    /* latin */
    static let XK_Xabovedot = X11Keys(fromX11KeySym: 0x1001e8a)  /* U+1E8A LATIN CAPITAL LETTER X WITH DOT ABOVE */
    static let XK_Ibreve = X11Keys(fromX11KeySym: 0x100012c)  /* U+012C LATIN CAPITAL LETTER I WITH BREVE */
    static let XK_Zstroke = X11Keys(fromX11KeySym: 0x10001b5)  /* U+01B5 LATIN CAPITAL LETTER Z WITH STROKE */
    static let XK_Gcaron = X11Keys(fromX11KeySym: 0x10001e6)  /* U+01E6 LATIN CAPITAL LETTER G WITH CARON */
    static let XK_Ocaron = X11Keys(fromX11KeySym: 0x10001d1)  /* U+01D1 LATIN CAPITAL LETTER O WITH CARON */
    static let XK_Obarred = X11Keys(fromX11KeySym: 0x100019f)  /* U+019F LATIN CAPITAL LETTER O WITH MIDDLE TILDE */
    static let XK_xabovedot = X11Keys(fromX11KeySym: 0x1001e8b)  /* U+1E8B LATIN SMALL LETTER X WITH DOT ABOVE */
    static let XK_ibreve = X11Keys(fromX11KeySym: 0x100012d)  /* U+012D LATIN SMALL LETTER I WITH BREVE */
    static let XK_zstroke = X11Keys(fromX11KeySym: 0x10001b6)  /* U+01B6 LATIN SMALL LETTER Z WITH STROKE */
    static let XK_gcaron = X11Keys(fromX11KeySym: 0x10001e7)  /* U+01E7 LATIN SMALL LETTER G WITH CARON */
    static let XK_ocaron = X11Keys(fromX11KeySym: 0x10001d2)  /* U+01D2 LATIN SMALL LETTER O WITH CARON */
    static let XK_obarred = X11Keys(fromX11KeySym: 0x1000275)  /* U+0275 LATIN SMALL LETTER BARRED O */
    static let XK_SCHWA = X11Keys(fromX11KeySym: 0x100018f)  /* U+018F LATIN CAPITAL LETTER SCHWA */
    static let XK_schwa = X11Keys(fromX11KeySym: 0x1000259)  /* U+0259 LATIN SMALL LETTER SCHWA */
    static let XK_EZH = X11Keys(fromX11KeySym: 0x10001b7)  /* U+01B7 LATIN CAPITAL LETTER EZH */
    static let XK_ezh = X11Keys(fromX11KeySym: 0x1000292)  /* U+0292 LATIN SMALL LETTER EZH */
    /* those are not really Caucasus */
    /* For Inupiak */
    static let XK_Lbelowdot = X11Keys(fromX11KeySym: 0x1001e36)  /* U+1E36 LATIN CAPITAL LETTER L WITH DOT BELOW */
    static let XK_lbelowdot = X11Keys(fromX11KeySym: 0x1001e37)  /* U+1E37 LATIN SMALL LETTER L WITH DOT BELOW */

    static let XK_Abelowdot = X11Keys(fromX11KeySym: 0x1001ea0)  /* U+1EA0 LATIN CAPITAL LETTER A WITH DOT BELOW */
    static let XK_abelowdot = X11Keys(fromX11KeySym: 0x1001ea1)  /* U+1EA1 LATIN SMALL LETTER A WITH DOT BELOW */
    static let XK_Ahook = X11Keys(fromX11KeySym: 0x1001ea2)  /* U+1EA2 LATIN CAPITAL LETTER A WITH HOOK ABOVE */
    static let XK_ahook = X11Keys(fromX11KeySym: 0x1001ea3)  /* U+1EA3 LATIN SMALL LETTER A WITH HOOK ABOVE */
    static let XK_Acircumflexacute = X11Keys(fromX11KeySym: 0x1001ea4)  /* U+1EA4 LATIN CAPITAL LETTER A WITH CIRCUMFLEX AND ACUTE */
    static let XK_acircumflexacute = X11Keys(fromX11KeySym: 0x1001ea5)  /* U+1EA5 LATIN SMALL LETTER A WITH CIRCUMFLEX AND ACUTE */
    static let XK_Acircumflexgrave = X11Keys(fromX11KeySym: 0x1001ea6)  /* U+1EA6 LATIN CAPITAL LETTER A WITH CIRCUMFLEX AND GRAVE */
    static let XK_acircumflexgrave = X11Keys(fromX11KeySym: 0x1001ea7)  /* U+1EA7 LATIN SMALL LETTER A WITH CIRCUMFLEX AND GRAVE */
    static let XK_Acircumflexhook = X11Keys(fromX11KeySym: 0x1001ea8)  /* U+1EA8 LATIN CAPITAL LETTER A WITH CIRCUMFLEX AND HOOK ABOVE */
    static let XK_acircumflexhook = X11Keys(fromX11KeySym: 0x1001ea9)  /* U+1EA9 LATIN SMALL LETTER A WITH CIRCUMFLEX AND HOOK ABOVE */
    static let XK_Acircumflextilde = X11Keys(fromX11KeySym: 0x1001eaa)  /* U+1EAA LATIN CAPITAL LETTER A WITH CIRCUMFLEX AND TILDE */
    static let XK_acircumflextilde = X11Keys(fromX11KeySym: 0x1001eab)  /* U+1EAB LATIN SMALL LETTER A WITH CIRCUMFLEX AND TILDE */
    static let XK_Acircumflexbelowdot = X11Keys(fromX11KeySym: 0x1001eac)  /* U+1EAC LATIN CAPITAL LETTER A WITH CIRCUMFLEX AND DOT BELOW */
    static let XK_acircumflexbelowdot = X11Keys(fromX11KeySym: 0x1001ead)  /* U+1EAD LATIN SMALL LETTER A WITH CIRCUMFLEX AND DOT BELOW */
    static let XK_Abreveacute = X11Keys(fromX11KeySym: 0x1001eae)  /* U+1EAE LATIN CAPITAL LETTER A WITH BREVE AND ACUTE */
    static let XK_abreveacute = X11Keys(fromX11KeySym: 0x1001eaf)  /* U+1EAF LATIN SMALL LETTER A WITH BREVE AND ACUTE */
    static let XK_Abrevegrave = X11Keys(fromX11KeySym: 0x1001eb0)  /* U+1EB0 LATIN CAPITAL LETTER A WITH BREVE AND GRAVE */
    static let XK_abrevegrave = X11Keys(fromX11KeySym: 0x1001eb1)  /* U+1EB1 LATIN SMALL LETTER A WITH BREVE AND GRAVE */
    static let XK_Abrevehook = X11Keys(fromX11KeySym: 0x1001eb2)  /* U+1EB2 LATIN CAPITAL LETTER A WITH BREVE AND HOOK ABOVE */
    static let XK_abrevehook = X11Keys(fromX11KeySym: 0x1001eb3)  /* U+1EB3 LATIN SMALL LETTER A WITH BREVE AND HOOK ABOVE */
    static let XK_Abrevetilde = X11Keys(fromX11KeySym: 0x1001eb4)  /* U+1EB4 LATIN CAPITAL LETTER A WITH BREVE AND TILDE */
    static let XK_abrevetilde = X11Keys(fromX11KeySym: 0x1001eb5)  /* U+1EB5 LATIN SMALL LETTER A WITH BREVE AND TILDE */
    static let XK_Abrevebelowdot = X11Keys(fromX11KeySym: 0x1001eb6)  /* U+1EB6 LATIN CAPITAL LETTER A WITH BREVE AND DOT BELOW */
    static let XK_abrevebelowdot = X11Keys(fromX11KeySym: 0x1001eb7)  /* U+1EB7 LATIN SMALL LETTER A WITH BREVE AND DOT BELOW */
    static let XK_Ebelowdot = X11Keys(fromX11KeySym: 0x1001eb8)  /* U+1EB8 LATIN CAPITAL LETTER E WITH DOT BELOW */
    static let XK_ebelowdot = X11Keys(fromX11KeySym: 0x1001eb9)  /* U+1EB9 LATIN SMALL LETTER E WITH DOT BELOW */
    static let XK_Ehook = X11Keys(fromX11KeySym: 0x1001eba)  /* U+1EBA LATIN CAPITAL LETTER E WITH HOOK ABOVE */
    static let XK_ehook = X11Keys(fromX11KeySym: 0x1001ebb)  /* U+1EBB LATIN SMALL LETTER E WITH HOOK ABOVE */
    static let XK_Etilde = X11Keys(fromX11KeySym: 0x1001ebc)  /* U+1EBC LATIN CAPITAL LETTER E WITH TILDE */
    static let XK_etilde = X11Keys(fromX11KeySym: 0x1001ebd)  /* U+1EBD LATIN SMALL LETTER E WITH TILDE */
    static let XK_Ecircumflexacute = X11Keys(fromX11KeySym: 0x1001ebe)  /* U+1EBE LATIN CAPITAL LETTER E WITH CIRCUMFLEX AND ACUTE */
    static let XK_ecircumflexacute = X11Keys(fromX11KeySym: 0x1001ebf)  /* U+1EBF LATIN SMALL LETTER E WITH CIRCUMFLEX AND ACUTE */
    static let XK_Ecircumflexgrave = X11Keys(fromX11KeySym: 0x1001ec0)  /* U+1EC0 LATIN CAPITAL LETTER E WITH CIRCUMFLEX AND GRAVE */
    static let XK_ecircumflexgrave = X11Keys(fromX11KeySym: 0x1001ec1)  /* U+1EC1 LATIN SMALL LETTER E WITH CIRCUMFLEX AND GRAVE */
    static let XK_Ecircumflexhook = X11Keys(fromX11KeySym: 0x1001ec2)  /* U+1EC2 LATIN CAPITAL LETTER E WITH CIRCUMFLEX AND HOOK ABOVE */
    static let XK_ecircumflexhook = X11Keys(fromX11KeySym: 0x1001ec3)  /* U+1EC3 LATIN SMALL LETTER E WITH CIRCUMFLEX AND HOOK ABOVE */
    static let XK_Ecircumflextilde = X11Keys(fromX11KeySym: 0x1001ec4)  /* U+1EC4 LATIN CAPITAL LETTER E WITH CIRCUMFLEX AND TILDE */
    static let XK_ecircumflextilde = X11Keys(fromX11KeySym: 0x1001ec5)  /* U+1EC5 LATIN SMALL LETTER E WITH CIRCUMFLEX AND TILDE */
    static let XK_Ecircumflexbelowdot = X11Keys(fromX11KeySym: 0x1001ec6)  /* U+1EC6 LATIN CAPITAL LETTER E WITH CIRCUMFLEX AND DOT BELOW */
    static let XK_ecircumflexbelowdot = X11Keys(fromX11KeySym: 0x1001ec7)  /* U+1EC7 LATIN SMALL LETTER E WITH CIRCUMFLEX AND DOT BELOW */
    static let XK_Ihook = X11Keys(fromX11KeySym: 0x1001ec8)  /* U+1EC8 LATIN CAPITAL LETTER I WITH HOOK ABOVE */
    static let XK_ihook = X11Keys(fromX11KeySym: 0x1001ec9)  /* U+1EC9 LATIN SMALL LETTER I WITH HOOK ABOVE */
    static let XK_Ibelowdot = X11Keys(fromX11KeySym: 0x1001eca)  /* U+1ECA LATIN CAPITAL LETTER I WITH DOT BELOW */
    static let XK_ibelowdot = X11Keys(fromX11KeySym: 0x1001ecb)  /* U+1ECB LATIN SMALL LETTER I WITH DOT BELOW */
    static let XK_Obelowdot = X11Keys(fromX11KeySym: 0x1001ecc)  /* U+1ECC LATIN CAPITAL LETTER O WITH DOT BELOW */
    static let XK_obelowdot = X11Keys(fromX11KeySym: 0x1001ecd)  /* U+1ECD LATIN SMALL LETTER O WITH DOT BELOW */
    static let XK_Ohook = X11Keys(fromX11KeySym: 0x1001ece)  /* U+1ECE LATIN CAPITAL LETTER O WITH HOOK ABOVE */
    static let XK_ohook = X11Keys(fromX11KeySym: 0x1001ecf)  /* U+1ECF LATIN SMALL LETTER O WITH HOOK ABOVE */
    static let XK_Ocircumflexacute = X11Keys(fromX11KeySym: 0x1001ed0)  /* U+1ED0 LATIN CAPITAL LETTER O WITH CIRCUMFLEX AND ACUTE */
    static let XK_ocircumflexacute = X11Keys(fromX11KeySym: 0x1001ed1)  /* U+1ED1 LATIN SMALL LETTER O WITH CIRCUMFLEX AND ACUTE */
    static let XK_Ocircumflexgrave = X11Keys(fromX11KeySym: 0x1001ed2)  /* U+1ED2 LATIN CAPITAL LETTER O WITH CIRCUMFLEX AND GRAVE */
    static let XK_ocircumflexgrave = X11Keys(fromX11KeySym: 0x1001ed3)  /* U+1ED3 LATIN SMALL LETTER O WITH CIRCUMFLEX AND GRAVE */
    static let XK_Ocircumflexhook = X11Keys(fromX11KeySym: 0x1001ed4)  /* U+1ED4 LATIN CAPITAL LETTER O WITH CIRCUMFLEX AND HOOK ABOVE */
    static let XK_ocircumflexhook = X11Keys(fromX11KeySym: 0x1001ed5)  /* U+1ED5 LATIN SMALL LETTER O WITH CIRCUMFLEX AND HOOK ABOVE */
    static let XK_Ocircumflextilde = X11Keys(fromX11KeySym: 0x1001ed6)  /* U+1ED6 LATIN CAPITAL LETTER O WITH CIRCUMFLEX AND TILDE */
    static let XK_ocircumflextilde = X11Keys(fromX11KeySym: 0x1001ed7)  /* U+1ED7 LATIN SMALL LETTER O WITH CIRCUMFLEX AND TILDE */
    static let XK_Ocircumflexbelowdot = X11Keys(fromX11KeySym: 0x1001ed8)  /* U+1ED8 LATIN CAPITAL LETTER O WITH CIRCUMFLEX AND DOT BELOW */
    static let XK_ocircumflexbelowdot = X11Keys(fromX11KeySym: 0x1001ed9)  /* U+1ED9 LATIN SMALL LETTER O WITH CIRCUMFLEX AND DOT BELOW */
    static let XK_Ohornacute = X11Keys(fromX11KeySym: 0x1001eda)  /* U+1EDA LATIN CAPITAL LETTER O WITH HORN AND ACUTE */
    static let XK_ohornacute = X11Keys(fromX11KeySym: 0x1001edb)  /* U+1EDB LATIN SMALL LETTER O WITH HORN AND ACUTE */
    static let XK_Ohorngrave = X11Keys(fromX11KeySym: 0x1001edc)  /* U+1EDC LATIN CAPITAL LETTER O WITH HORN AND GRAVE */
    static let XK_ohorngrave = X11Keys(fromX11KeySym: 0x1001edd)  /* U+1EDD LATIN SMALL LETTER O WITH HORN AND GRAVE */
    static let XK_Ohornhook = X11Keys(fromX11KeySym: 0x1001ede)  /* U+1EDE LATIN CAPITAL LETTER O WITH HORN AND HOOK ABOVE */
    static let XK_ohornhook = X11Keys(fromX11KeySym: 0x1001edf)  /* U+1EDF LATIN SMALL LETTER O WITH HORN AND HOOK ABOVE */
    static let XK_Ohorntilde = X11Keys(fromX11KeySym: 0x1001ee0)  /* U+1EE0 LATIN CAPITAL LETTER O WITH HORN AND TILDE */
    static let XK_ohorntilde = X11Keys(fromX11KeySym: 0x1001ee1)  /* U+1EE1 LATIN SMALL LETTER O WITH HORN AND TILDE */
    static let XK_Ohornbelowdot = X11Keys(fromX11KeySym: 0x1001ee2)  /* U+1EE2 LATIN CAPITAL LETTER O WITH HORN AND DOT BELOW */
    static let XK_ohornbelowdot = X11Keys(fromX11KeySym: 0x1001ee3)  /* U+1EE3 LATIN SMALL LETTER O WITH HORN AND DOT BELOW */
    static let XK_Ubelowdot = X11Keys(fromX11KeySym: 0x1001ee4)  /* U+1EE4 LATIN CAPITAL LETTER U WITH DOT BELOW */
    static let XK_ubelowdot = X11Keys(fromX11KeySym: 0x1001ee5)  /* U+1EE5 LATIN SMALL LETTER U WITH DOT BELOW */
    static let XK_Uhook = X11Keys(fromX11KeySym: 0x1001ee6)  /* U+1EE6 LATIN CAPITAL LETTER U WITH HOOK ABOVE */
    static let XK_uhook = X11Keys(fromX11KeySym: 0x1001ee7)  /* U+1EE7 LATIN SMALL LETTER U WITH HOOK ABOVE */
    static let XK_Uhornacute = X11Keys(fromX11KeySym: 0x1001ee8)  /* U+1EE8 LATIN CAPITAL LETTER U WITH HORN AND ACUTE */
    static let XK_uhornacute = X11Keys(fromX11KeySym: 0x1001ee9)  /* U+1EE9 LATIN SMALL LETTER U WITH HORN AND ACUTE */
    static let XK_Uhorngrave = X11Keys(fromX11KeySym: 0x1001eea)  /* U+1EEA LATIN CAPITAL LETTER U WITH HORN AND GRAVE */
    static let XK_uhorngrave = X11Keys(fromX11KeySym: 0x1001eeb)  /* U+1EEB LATIN SMALL LETTER U WITH HORN AND GRAVE */
    static let XK_Uhornhook = X11Keys(fromX11KeySym: 0x1001eec)  /* U+1EEC LATIN CAPITAL LETTER U WITH HORN AND HOOK ABOVE */
    static let XK_uhornhook = X11Keys(fromX11KeySym: 0x1001eed)  /* U+1EED LATIN SMALL LETTER U WITH HORN AND HOOK ABOVE */
    static let XK_Uhorntilde = X11Keys(fromX11KeySym: 0x1001eee)  /* U+1EEE LATIN CAPITAL LETTER U WITH HORN AND TILDE */
    static let XK_uhorntilde = X11Keys(fromX11KeySym: 0x1001eef)  /* U+1EEF LATIN SMALL LETTER U WITH HORN AND TILDE */
    static let XK_Uhornbelowdot = X11Keys(fromX11KeySym: 0x1001ef0)  /* U+1EF0 LATIN CAPITAL LETTER U WITH HORN AND DOT BELOW */
    static let XK_uhornbelowdot = X11Keys(fromX11KeySym: 0x1001ef1)  /* U+1EF1 LATIN SMALL LETTER U WITH HORN AND DOT BELOW */
    static let XK_Ybelowdot = X11Keys(fromX11KeySym: 0x1001ef4)  /* U+1EF4 LATIN CAPITAL LETTER Y WITH DOT BELOW */
    static let XK_ybelowdot = X11Keys(fromX11KeySym: 0x1001ef5)  /* U+1EF5 LATIN SMALL LETTER Y WITH DOT BELOW */
    static let XK_Yhook = X11Keys(fromX11KeySym: 0x1001ef6)  /* U+1EF6 LATIN CAPITAL LETTER Y WITH HOOK ABOVE */
    static let XK_yhook = X11Keys(fromX11KeySym: 0x1001ef7)  /* U+1EF7 LATIN SMALL LETTER Y WITH HOOK ABOVE */
    static let XK_Ytilde = X11Keys(fromX11KeySym: 0x1001ef8)  /* U+1EF8 LATIN CAPITAL LETTER Y WITH TILDE */
    static let XK_ytilde = X11Keys(fromX11KeySym: 0x1001ef9)  /* U+1EF9 LATIN SMALL LETTER Y WITH TILDE */
    static let XK_Ohorn = X11Keys(fromX11KeySym: 0x10001a0)  /* U+01A0 LATIN CAPITAL LETTER O WITH HORN */
    static let XK_ohorn = X11Keys(fromX11KeySym: 0x10001a1)  /* U+01A1 LATIN SMALL LETTER O WITH HORN */
    static let XK_Uhorn = X11Keys(fromX11KeySym: 0x10001af)  /* U+01AF LATIN CAPITAL LETTER U WITH HORN */
    static let XK_uhorn = X11Keys(fromX11KeySym: 0x10001b0)  /* U+01B0 LATIN SMALL LETTER U WITH HORN */
    static let XK_combining_tilde = X11Keys(fromX11KeySym: 0x1000303)  /* U+0303 COMBINING TILDE */
    static let XK_combining_grave = X11Keys(fromX11KeySym: 0x1000300)  /* U+0300 COMBINING GRAVE ACCENT */
    static let XK_combining_acute = X11Keys(fromX11KeySym: 0x1000301)  /* U+0301 COMBINING ACUTE ACCENT */
    static let XK_combining_hook = X11Keys(fromX11KeySym: 0x1000309)  /* U+0309 COMBINING HOOK ABOVE */
    static let XK_combining_belowdot = X11Keys(fromX11KeySym: 0x1000323)  /* U+0323 COMBINING DOT BELOW */

    static let XK_EcuSign = X11Keys(fromX11KeySym: 0x10020a0)  /* U+20A0 EURO-CURRENCY SIGN */
    static let XK_ColonSign = X11Keys(fromX11KeySym: 0x10020a1)  /* U+20A1 COLON SIGN */
    static let XK_CruzeiroSign = X11Keys(fromX11KeySym: 0x10020a2)  /* U+20A2 CRUZEIRO SIGN */
    static let XK_FFrancSign = X11Keys(fromX11KeySym: 0x10020a3)  /* U+20A3 FRENCH FRANC SIGN */
    static let XK_LiraSign = X11Keys(fromX11KeySym: 0x10020a4)  /* U+20A4 LIRA SIGN */
    static let XK_MillSign = X11Keys(fromX11KeySym: 0x10020a5)  /* U+20A5 MILL SIGN */
    static let XK_NairaSign = X11Keys(fromX11KeySym: 0x10020a6)  /* U+20A6 NAIRA SIGN */
    static let XK_PesetaSign = X11Keys(fromX11KeySym: 0x10020a7)  /* U+20A7 PESETA SIGN */
    static let XK_RupeeSign = X11Keys(fromX11KeySym: 0x10020a8)  /* U+20A8 RUPEE SIGN */
    static let XK_WonSign = X11Keys(fromX11KeySym: 0x10020a9)  /* U+20A9 WON SIGN */
    static let XK_NewSheqelSign = X11Keys(fromX11KeySym: 0x10020aa)  /* U+20AA NEW SHEQEL SIGN */
    static let XK_DongSign = X11Keys(fromX11KeySym: 0x10020ab)  /* U+20AB DONG SIGN */
    static let XK_EuroSign = X11Keys(fromX11KeySym: 0x20ac)  /* U+20AC EURO SIGN */

    /* one, two and three are defined above. */
    static let XK_zerosuperior = X11Keys(fromX11KeySym: 0x1002070)  /* U+2070 SUPERSCRIPT ZERO */
    static let XK_foursuperior = X11Keys(fromX11KeySym: 0x1002074)  /* U+2074 SUPERSCRIPT FOUR */
    static let XK_fivesuperior = X11Keys(fromX11KeySym: 0x1002075)  /* U+2075 SUPERSCRIPT FIVE */
    static let XK_sixsuperior = X11Keys(fromX11KeySym: 0x1002076)  /* U+2076 SUPERSCRIPT SIX */
    static let XK_sevensuperior = X11Keys(fromX11KeySym: 0x1002077)  /* U+2077 SUPERSCRIPT SEVEN */
    static let XK_eightsuperior = X11Keys(fromX11KeySym: 0x1002078)  /* U+2078 SUPERSCRIPT EIGHT */
    static let XK_ninesuperior = X11Keys(fromX11KeySym: 0x1002079)  /* U+2079 SUPERSCRIPT NINE */
    static let XK_zerosubscript = X11Keys(fromX11KeySym: 0x1002080)  /* U+2080 SUBSCRIPT ZERO */
    static let XK_onesubscript = X11Keys(fromX11KeySym: 0x1002081)  /* U+2081 SUBSCRIPT ONE */
    static let XK_twosubscript = X11Keys(fromX11KeySym: 0x1002082)  /* U+2082 SUBSCRIPT TWO */
    static let XK_threesubscript = X11Keys(fromX11KeySym: 0x1002083)  /* U+2083 SUBSCRIPT THREE */
    static let XK_foursubscript = X11Keys(fromX11KeySym: 0x1002084)  /* U+2084 SUBSCRIPT FOUR */
    static let XK_fivesubscript = X11Keys(fromX11KeySym: 0x1002085)  /* U+2085 SUBSCRIPT FIVE */
    static let XK_sixsubscript = X11Keys(fromX11KeySym: 0x1002086)  /* U+2086 SUBSCRIPT SIX */
    static let XK_sevensubscript = X11Keys(fromX11KeySym: 0x1002087)  /* U+2087 SUBSCRIPT SEVEN */
    static let XK_eightsubscript = X11Keys(fromX11KeySym: 0x1002088)  /* U+2088 SUBSCRIPT EIGHT */
    static let XK_ninesubscript = X11Keys(fromX11KeySym: 0x1002089)  /* U+2089 SUBSCRIPT NINE */
    static let XK_partdifferential = X11Keys(fromX11KeySym: 0x1002202)  /* U+2202 PARTIAL DIFFERENTIAL */
    static let XK_emptyset = X11Keys(fromX11KeySym: 0x1002205)  /* U+2205 NULL SET */
    static let XK_elementof = X11Keys(fromX11KeySym: 0x1002208)  /* U+2208 ELEMENT OF */
    static let XK_notelementof = X11Keys(fromX11KeySym: 0x1002209)  /* U+2209 NOT AN ELEMENT OF */
    static let XK_containsas = X11Keys(fromX11KeySym: 0x100220B)  /* U+220B CONTAINS AS MEMBER */
    static let XK_squareroot = X11Keys(fromX11KeySym: 0x100221A)  /* U+221A SQUARE ROOT */
    static let XK_cuberoot = X11Keys(fromX11KeySym: 0x100221B)  /* U+221B CUBE ROOT */
    static let XK_fourthroot = X11Keys(fromX11KeySym: 0x100221C)  /* U+221C FOURTH ROOT */
    static let XK_dintegral = X11Keys(fromX11KeySym: 0x100222C)  /* U+222C DOUBLE INTEGRAL */
    static let XK_tintegral = X11Keys(fromX11KeySym: 0x100222D)  /* U+222D TRIPLE INTEGRAL */
    static let XK_because = X11Keys(fromX11KeySym: 0x1002235)  /* U+2235 BECAUSE */
    static let XK_approxeq = X11Keys(fromX11KeySym: 0x1002248)  /*(U+2248 ALMOST EQUAL TO)*/
    static let XK_notapproxeq = X11Keys(fromX11KeySym: 0x1002247)  /*(U+2247 NEITHER APPROXIMATELY NOR ACTUALLY EQUAL TO)*/
    static let XK_notidentical = X11Keys(fromX11KeySym: 0x1002262)  /* U+2262 NOT IDENTICAL TO */
    static let XK_stricteq = X11Keys(fromX11KeySym: 0x1002263)  /* U+2263 STRICTLY EQUIVALENT TO */

    static let XK_braille_dot_1 = X11Keys(fromX11KeySym: 0xfff1)
    static let XK_braille_dot_2 = X11Keys(fromX11KeySym: 0xfff2)
    static let XK_braille_dot_3 = X11Keys(fromX11KeySym: 0xfff3)
    static let XK_braille_dot_4 = X11Keys(fromX11KeySym: 0xfff4)
    static let XK_braille_dot_5 = X11Keys(fromX11KeySym: 0xfff5)
    static let XK_braille_dot_6 = X11Keys(fromX11KeySym: 0xfff6)
    static let XK_braille_dot_7 = X11Keys(fromX11KeySym: 0xfff7)
    static let XK_braille_dot_8 = X11Keys(fromX11KeySym: 0xfff8)
    static let XK_braille_dot_9 = X11Keys(fromX11KeySym: 0xfff9)
    static let XK_braille_dot_10 = X11Keys(fromX11KeySym: 0xfffa)
    static let XK_braille_blank = X11Keys(fromX11KeySym: 0x1002800)  /* U+2800 BRAILLE PATTERN BLANK */
    static let XK_braille_dots_1 = X11Keys(fromX11KeySym: 0x1002801)  /* U+2801 BRAILLE PATTERN DOTS-1 */
    static let XK_braille_dots_2 = X11Keys(fromX11KeySym: 0x1002802)  /* U+2802 BRAILLE PATTERN DOTS-2 */
    static let XK_braille_dots_12 = X11Keys(fromX11KeySym: 0x1002803)  /* U+2803 BRAILLE PATTERN DOTS-12 */
    static let XK_braille_dots_3 = X11Keys(fromX11KeySym: 0x1002804)  /* U+2804 BRAILLE PATTERN DOTS-3 */
    static let XK_braille_dots_13 = X11Keys(fromX11KeySym: 0x1002805)  /* U+2805 BRAILLE PATTERN DOTS-13 */
    static let XK_braille_dots_23 = X11Keys(fromX11KeySym: 0x1002806)  /* U+2806 BRAILLE PATTERN DOTS-23 */
    static let XK_braille_dots_123 = X11Keys(fromX11KeySym: 0x1002807)  /* U+2807 BRAILLE PATTERN DOTS-123 */
    static let XK_braille_dots_4 = X11Keys(fromX11KeySym: 0x1002808)  /* U+2808 BRAILLE PATTERN DOTS-4 */
    static let XK_braille_dots_14 = X11Keys(fromX11KeySym: 0x1002809)  /* U+2809 BRAILLE PATTERN DOTS-14 */
    static let XK_braille_dots_24 = X11Keys(fromX11KeySym: 0x100280a)  /* U+280a BRAILLE PATTERN DOTS-24 */
    static let XK_braille_dots_124 = X11Keys(fromX11KeySym: 0x100280b)  /* U+280b BRAILLE PATTERN DOTS-124 */
    static let XK_braille_dots_34 = X11Keys(fromX11KeySym: 0x100280c)  /* U+280c BRAILLE PATTERN DOTS-34 */
    static let XK_braille_dots_134 = X11Keys(fromX11KeySym: 0x100280d)  /* U+280d BRAILLE PATTERN DOTS-134 */
    static let XK_braille_dots_234 = X11Keys(fromX11KeySym: 0x100280e)  /* U+280e BRAILLE PATTERN DOTS-234 */
    static let XK_braille_dots_1234 = X11Keys(fromX11KeySym: 0x100280f)  /* U+280f BRAILLE PATTERN DOTS-1234 */
    static let XK_braille_dots_5 = X11Keys(fromX11KeySym: 0x1002810)  /* U+2810 BRAILLE PATTERN DOTS-5 */
    static let XK_braille_dots_15 = X11Keys(fromX11KeySym: 0x1002811)  /* U+2811 BRAILLE PATTERN DOTS-15 */
    static let XK_braille_dots_25 = X11Keys(fromX11KeySym: 0x1002812)  /* U+2812 BRAILLE PATTERN DOTS-25 */
    static let XK_braille_dots_125 = X11Keys(fromX11KeySym: 0x1002813)  /* U+2813 BRAILLE PATTERN DOTS-125 */
    static let XK_braille_dots_35 = X11Keys(fromX11KeySym: 0x1002814)  /* U+2814 BRAILLE PATTERN DOTS-35 */
    static let XK_braille_dots_135 = X11Keys(fromX11KeySym: 0x1002815)  /* U+2815 BRAILLE PATTERN DOTS-135 */
    static let XK_braille_dots_235 = X11Keys(fromX11KeySym: 0x1002816)  /* U+2816 BRAILLE PATTERN DOTS-235 */
    static let XK_braille_dots_1235 = X11Keys(fromX11KeySym: 0x1002817)  /* U+2817 BRAILLE PATTERN DOTS-1235 */
    static let XK_braille_dots_45 = X11Keys(fromX11KeySym: 0x1002818)  /* U+2818 BRAILLE PATTERN DOTS-45 */
    static let XK_braille_dots_145 = X11Keys(fromX11KeySym: 0x1002819)  /* U+2819 BRAILLE PATTERN DOTS-145 */
    static let XK_braille_dots_245 = X11Keys(fromX11KeySym: 0x100281a)  /* U+281a BRAILLE PATTERN DOTS-245 */
    static let XK_braille_dots_1245 = X11Keys(fromX11KeySym: 0x100281b)  /* U+281b BRAILLE PATTERN DOTS-1245 */
    static let XK_braille_dots_345 = X11Keys(fromX11KeySym: 0x100281c)  /* U+281c BRAILLE PATTERN DOTS-345 */
    static let XK_braille_dots_1345 = X11Keys(fromX11KeySym: 0x100281d)  /* U+281d BRAILLE PATTERN DOTS-1345 */
    static let XK_braille_dots_2345 = X11Keys(fromX11KeySym: 0x100281e)  /* U+281e BRAILLE PATTERN DOTS-2345 */
    static let XK_braille_dots_12345 = X11Keys(fromX11KeySym: 0x100281f)  /* U+281f BRAILLE PATTERN DOTS-12345 */
    static let XK_braille_dots_6 = X11Keys(fromX11KeySym: 0x1002820)  /* U+2820 BRAILLE PATTERN DOTS-6 */
    static let XK_braille_dots_16 = X11Keys(fromX11KeySym: 0x1002821)  /* U+2821 BRAILLE PATTERN DOTS-16 */
    static let XK_braille_dots_26 = X11Keys(fromX11KeySym: 0x1002822)  /* U+2822 BRAILLE PATTERN DOTS-26 */
    static let XK_braille_dots_126 = X11Keys(fromX11KeySym: 0x1002823)  /* U+2823 BRAILLE PATTERN DOTS-126 */
    static let XK_braille_dots_36 = X11Keys(fromX11KeySym: 0x1002824)  /* U+2824 BRAILLE PATTERN DOTS-36 */
    static let XK_braille_dots_136 = X11Keys(fromX11KeySym: 0x1002825)  /* U+2825 BRAILLE PATTERN DOTS-136 */
    static let XK_braille_dots_236 = X11Keys(fromX11KeySym: 0x1002826)  /* U+2826 BRAILLE PATTERN DOTS-236 */
    static let XK_braille_dots_1236 = X11Keys(fromX11KeySym: 0x1002827)  /* U+2827 BRAILLE PATTERN DOTS-1236 */
    static let XK_braille_dots_46 = X11Keys(fromX11KeySym: 0x1002828)  /* U+2828 BRAILLE PATTERN DOTS-46 */
    static let XK_braille_dots_146 = X11Keys(fromX11KeySym: 0x1002829)  /* U+2829 BRAILLE PATTERN DOTS-146 */
    static let XK_braille_dots_246 = X11Keys(fromX11KeySym: 0x100282a)  /* U+282a BRAILLE PATTERN DOTS-246 */
    static let XK_braille_dots_1246 = X11Keys(fromX11KeySym: 0x100282b)  /* U+282b BRAILLE PATTERN DOTS-1246 */
    static let XK_braille_dots_346 = X11Keys(fromX11KeySym: 0x100282c)  /* U+282c BRAILLE PATTERN DOTS-346 */
    static let XK_braille_dots_1346 = X11Keys(fromX11KeySym: 0x100282d)  /* U+282d BRAILLE PATTERN DOTS-1346 */
    static let XK_braille_dots_2346 = X11Keys(fromX11KeySym: 0x100282e)  /* U+282e BRAILLE PATTERN DOTS-2346 */
    static let XK_braille_dots_12346 = X11Keys(fromX11KeySym: 0x100282f)  /* U+282f BRAILLE PATTERN DOTS-12346 */
    static let XK_braille_dots_56 = X11Keys(fromX11KeySym: 0x1002830)  /* U+2830 BRAILLE PATTERN DOTS-56 */
    static let XK_braille_dots_156 = X11Keys(fromX11KeySym: 0x1002831)  /* U+2831 BRAILLE PATTERN DOTS-156 */
    static let XK_braille_dots_256 = X11Keys(fromX11KeySym: 0x1002832)  /* U+2832 BRAILLE PATTERN DOTS-256 */
    static let XK_braille_dots_1256 = X11Keys(fromX11KeySym: 0x1002833)  /* U+2833 BRAILLE PATTERN DOTS-1256 */
    static let XK_braille_dots_356 = X11Keys(fromX11KeySym: 0x1002834)  /* U+2834 BRAILLE PATTERN DOTS-356 */
    static let XK_braille_dots_1356 = X11Keys(fromX11KeySym: 0x1002835)  /* U+2835 BRAILLE PATTERN DOTS-1356 */
    static let XK_braille_dots_2356 = X11Keys(fromX11KeySym: 0x1002836)  /* U+2836 BRAILLE PATTERN DOTS-2356 */
    static let XK_braille_dots_12356 = X11Keys(fromX11KeySym: 0x1002837)  /* U+2837 BRAILLE PATTERN DOTS-12356 */
    static let XK_braille_dots_456 = X11Keys(fromX11KeySym: 0x1002838)  /* U+2838 BRAILLE PATTERN DOTS-456 */
    static let XK_braille_dots_1456 = X11Keys(fromX11KeySym: 0x1002839)  /* U+2839 BRAILLE PATTERN DOTS-1456 */
    static let XK_braille_dots_2456 = X11Keys(fromX11KeySym: 0x100283a)  /* U+283a BRAILLE PATTERN DOTS-2456 */
    static let XK_braille_dots_12456 = X11Keys(fromX11KeySym: 0x100283b)  /* U+283b BRAILLE PATTERN DOTS-12456 */
    static let XK_braille_dots_3456 = X11Keys(fromX11KeySym: 0x100283c)  /* U+283c BRAILLE PATTERN DOTS-3456 */
    static let XK_braille_dots_13456 = X11Keys(fromX11KeySym: 0x100283d)  /* U+283d BRAILLE PATTERN DOTS-13456 */
    static let XK_braille_dots_23456 = X11Keys(fromX11KeySym: 0x100283e)  /* U+283e BRAILLE PATTERN DOTS-23456 */
    static let XK_braille_dots_123456 = X11Keys(fromX11KeySym: 0x100283f)  /* U+283f BRAILLE PATTERN DOTS-123456 */
    static let XK_braille_dots_7 = X11Keys(fromX11KeySym: 0x1002840)  /* U+2840 BRAILLE PATTERN DOTS-7 */
    static let XK_braille_dots_17 = X11Keys(fromX11KeySym: 0x1002841)  /* U+2841 BRAILLE PATTERN DOTS-17 */
    static let XK_braille_dots_27 = X11Keys(fromX11KeySym: 0x1002842)  /* U+2842 BRAILLE PATTERN DOTS-27 */
    static let XK_braille_dots_127 = X11Keys(fromX11KeySym: 0x1002843)  /* U+2843 BRAILLE PATTERN DOTS-127 */
    static let XK_braille_dots_37 = X11Keys(fromX11KeySym: 0x1002844)  /* U+2844 BRAILLE PATTERN DOTS-37 */
    static let XK_braille_dots_137 = X11Keys(fromX11KeySym: 0x1002845)  /* U+2845 BRAILLE PATTERN DOTS-137 */
    static let XK_braille_dots_237 = X11Keys(fromX11KeySym: 0x1002846)  /* U+2846 BRAILLE PATTERN DOTS-237 */
    static let XK_braille_dots_1237 = X11Keys(fromX11KeySym: 0x1002847)  /* U+2847 BRAILLE PATTERN DOTS-1237 */
    static let XK_braille_dots_47 = X11Keys(fromX11KeySym: 0x1002848)  /* U+2848 BRAILLE PATTERN DOTS-47 */
    static let XK_braille_dots_147 = X11Keys(fromX11KeySym: 0x1002849)  /* U+2849 BRAILLE PATTERN DOTS-147 */
    static let XK_braille_dots_247 = X11Keys(fromX11KeySym: 0x100284a)  /* U+284a BRAILLE PATTERN DOTS-247 */
    static let XK_braille_dots_1247 = X11Keys(fromX11KeySym: 0x100284b)  /* U+284b BRAILLE PATTERN DOTS-1247 */
    static let XK_braille_dots_347 = X11Keys(fromX11KeySym: 0x100284c)  /* U+284c BRAILLE PATTERN DOTS-347 */
    static let XK_braille_dots_1347 = X11Keys(fromX11KeySym: 0x100284d)  /* U+284d BRAILLE PATTERN DOTS-1347 */
    static let XK_braille_dots_2347 = X11Keys(fromX11KeySym: 0x100284e)  /* U+284e BRAILLE PATTERN DOTS-2347 */
    static let XK_braille_dots_12347 = X11Keys(fromX11KeySym: 0x100284f)  /* U+284f BRAILLE PATTERN DOTS-12347 */
    static let XK_braille_dots_57 = X11Keys(fromX11KeySym: 0x1002850)  /* U+2850 BRAILLE PATTERN DOTS-57 */
    static let XK_braille_dots_157 = X11Keys(fromX11KeySym: 0x1002851)  /* U+2851 BRAILLE PATTERN DOTS-157 */
    static let XK_braille_dots_257 = X11Keys(fromX11KeySym: 0x1002852)  /* U+2852 BRAILLE PATTERN DOTS-257 */
    static let XK_braille_dots_1257 = X11Keys(fromX11KeySym: 0x1002853)  /* U+2853 BRAILLE PATTERN DOTS-1257 */
    static let XK_braille_dots_357 = X11Keys(fromX11KeySym: 0x1002854)  /* U+2854 BRAILLE PATTERN DOTS-357 */
    static let XK_braille_dots_1357 = X11Keys(fromX11KeySym: 0x1002855)  /* U+2855 BRAILLE PATTERN DOTS-1357 */
    static let XK_braille_dots_2357 = X11Keys(fromX11KeySym: 0x1002856)  /* U+2856 BRAILLE PATTERN DOTS-2357 */
    static let XK_braille_dots_12357 = X11Keys(fromX11KeySym: 0x1002857)  /* U+2857 BRAILLE PATTERN DOTS-12357 */
    static let XK_braille_dots_457 = X11Keys(fromX11KeySym: 0x1002858)  /* U+2858 BRAILLE PATTERN DOTS-457 */
    static let XK_braille_dots_1457 = X11Keys(fromX11KeySym: 0x1002859)  /* U+2859 BRAILLE PATTERN DOTS-1457 */
    static let XK_braille_dots_2457 = X11Keys(fromX11KeySym: 0x100285a)  /* U+285a BRAILLE PATTERN DOTS-2457 */
    static let XK_braille_dots_12457 = X11Keys(fromX11KeySym: 0x100285b)  /* U+285b BRAILLE PATTERN DOTS-12457 */
    static let XK_braille_dots_3457 = X11Keys(fromX11KeySym: 0x100285c)  /* U+285c BRAILLE PATTERN DOTS-3457 */
    static let XK_braille_dots_13457 = X11Keys(fromX11KeySym: 0x100285d)  /* U+285d BRAILLE PATTERN DOTS-13457 */
    static let XK_braille_dots_23457 = X11Keys(fromX11KeySym: 0x100285e)  /* U+285e BRAILLE PATTERN DOTS-23457 */
    static let XK_braille_dots_123457 = X11Keys(fromX11KeySym: 0x100285f)  /* U+285f BRAILLE PATTERN DOTS-123457 */
    static let XK_braille_dots_67 = X11Keys(fromX11KeySym: 0x1002860)  /* U+2860 BRAILLE PATTERN DOTS-67 */
    static let XK_braille_dots_167 = X11Keys(fromX11KeySym: 0x1002861)  /* U+2861 BRAILLE PATTERN DOTS-167 */
    static let XK_braille_dots_267 = X11Keys(fromX11KeySym: 0x1002862)  /* U+2862 BRAILLE PATTERN DOTS-267 */
    static let XK_braille_dots_1267 = X11Keys(fromX11KeySym: 0x1002863)  /* U+2863 BRAILLE PATTERN DOTS-1267 */
    static let XK_braille_dots_367 = X11Keys(fromX11KeySym: 0x1002864)  /* U+2864 BRAILLE PATTERN DOTS-367 */
    static let XK_braille_dots_1367 = X11Keys(fromX11KeySym: 0x1002865)  /* U+2865 BRAILLE PATTERN DOTS-1367 */
    static let XK_braille_dots_2367 = X11Keys(fromX11KeySym: 0x1002866)  /* U+2866 BRAILLE PATTERN DOTS-2367 */
    static let XK_braille_dots_12367 = X11Keys(fromX11KeySym: 0x1002867)  /* U+2867 BRAILLE PATTERN DOTS-12367 */
    static let XK_braille_dots_467 = X11Keys(fromX11KeySym: 0x1002868)  /* U+2868 BRAILLE PATTERN DOTS-467 */
    static let XK_braille_dots_1467 = X11Keys(fromX11KeySym: 0x1002869)  /* U+2869 BRAILLE PATTERN DOTS-1467 */
    static let XK_braille_dots_2467 = X11Keys(fromX11KeySym: 0x100286a)  /* U+286a BRAILLE PATTERN DOTS-2467 */
    static let XK_braille_dots_12467 = X11Keys(fromX11KeySym: 0x100286b)  /* U+286b BRAILLE PATTERN DOTS-12467 */
    static let XK_braille_dots_3467 = X11Keys(fromX11KeySym: 0x100286c)  /* U+286c BRAILLE PATTERN DOTS-3467 */
    static let XK_braille_dots_13467 = X11Keys(fromX11KeySym: 0x100286d)  /* U+286d BRAILLE PATTERN DOTS-13467 */
    static let XK_braille_dots_23467 = X11Keys(fromX11KeySym: 0x100286e)  /* U+286e BRAILLE PATTERN DOTS-23467 */
    static let XK_braille_dots_123467 = X11Keys(fromX11KeySym: 0x100286f)  /* U+286f BRAILLE PATTERN DOTS-123467 */
    static let XK_braille_dots_567 = X11Keys(fromX11KeySym: 0x1002870)  /* U+2870 BRAILLE PATTERN DOTS-567 */
    static let XK_braille_dots_1567 = X11Keys(fromX11KeySym: 0x1002871)  /* U+2871 BRAILLE PATTERN DOTS-1567 */
    static let XK_braille_dots_2567 = X11Keys(fromX11KeySym: 0x1002872)  /* U+2872 BRAILLE PATTERN DOTS-2567 */
    static let XK_braille_dots_12567 = X11Keys(fromX11KeySym: 0x1002873)  /* U+2873 BRAILLE PATTERN DOTS-12567 */
    static let XK_braille_dots_3567 = X11Keys(fromX11KeySym: 0x1002874)  /* U+2874 BRAILLE PATTERN DOTS-3567 */
    static let XK_braille_dots_13567 = X11Keys(fromX11KeySym: 0x1002875)  /* U+2875 BRAILLE PATTERN DOTS-13567 */
    static let XK_braille_dots_23567 = X11Keys(fromX11KeySym: 0x1002876)  /* U+2876 BRAILLE PATTERN DOTS-23567 */
    static let XK_braille_dots_123567 = X11Keys(fromX11KeySym: 0x1002877)  /* U+2877 BRAILLE PATTERN DOTS-123567 */
    static let XK_braille_dots_4567 = X11Keys(fromX11KeySym: 0x1002878)  /* U+2878 BRAILLE PATTERN DOTS-4567 */
    static let XK_braille_dots_14567 = X11Keys(fromX11KeySym: 0x1002879)  /* U+2879 BRAILLE PATTERN DOTS-14567 */
    static let XK_braille_dots_24567 = X11Keys(fromX11KeySym: 0x100287a)  /* U+287a BRAILLE PATTERN DOTS-24567 */
    static let XK_braille_dots_124567 = X11Keys(fromX11KeySym: 0x100287b)  /* U+287b BRAILLE PATTERN DOTS-124567 */
    static let XK_braille_dots_34567 = X11Keys(fromX11KeySym: 0x100287c)  /* U+287c BRAILLE PATTERN DOTS-34567 */
    static let XK_braille_dots_134567 = X11Keys(fromX11KeySym: 0x100287d)  /* U+287d BRAILLE PATTERN DOTS-134567 */
    static let XK_braille_dots_234567 = X11Keys(fromX11KeySym: 0x100287e)  /* U+287e BRAILLE PATTERN DOTS-234567 */
    static let XK_braille_dots_1234567 = X11Keys(fromX11KeySym: 0x100287f)  /* U+287f BRAILLE PATTERN DOTS-1234567 */
    static let XK_braille_dots_8 = X11Keys(fromX11KeySym: 0x1002880)  /* U+2880 BRAILLE PATTERN DOTS-8 */
    static let XK_braille_dots_18 = X11Keys(fromX11KeySym: 0x1002881)  /* U+2881 BRAILLE PATTERN DOTS-18 */
    static let XK_braille_dots_28 = X11Keys(fromX11KeySym: 0x1002882)  /* U+2882 BRAILLE PATTERN DOTS-28 */
    static let XK_braille_dots_128 = X11Keys(fromX11KeySym: 0x1002883)  /* U+2883 BRAILLE PATTERN DOTS-128 */
    static let XK_braille_dots_38 = X11Keys(fromX11KeySym: 0x1002884)  /* U+2884 BRAILLE PATTERN DOTS-38 */
    static let XK_braille_dots_138 = X11Keys(fromX11KeySym: 0x1002885)  /* U+2885 BRAILLE PATTERN DOTS-138 */
    static let XK_braille_dots_238 = X11Keys(fromX11KeySym: 0x1002886)  /* U+2886 BRAILLE PATTERN DOTS-238 */
    static let XK_braille_dots_1238 = X11Keys(fromX11KeySym: 0x1002887)  /* U+2887 BRAILLE PATTERN DOTS-1238 */
    static let XK_braille_dots_48 = X11Keys(fromX11KeySym: 0x1002888)  /* U+2888 BRAILLE PATTERN DOTS-48 */
    static let XK_braille_dots_148 = X11Keys(fromX11KeySym: 0x1002889)  /* U+2889 BRAILLE PATTERN DOTS-148 */
    static let XK_braille_dots_248 = X11Keys(fromX11KeySym: 0x100288a)  /* U+288a BRAILLE PATTERN DOTS-248 */
    static let XK_braille_dots_1248 = X11Keys(fromX11KeySym: 0x100288b)  /* U+288b BRAILLE PATTERN DOTS-1248 */
    static let XK_braille_dots_348 = X11Keys(fromX11KeySym: 0x100288c)  /* U+288c BRAILLE PATTERN DOTS-348 */
    static let XK_braille_dots_1348 = X11Keys(fromX11KeySym: 0x100288d)  /* U+288d BRAILLE PATTERN DOTS-1348 */
    static let XK_braille_dots_2348 = X11Keys(fromX11KeySym: 0x100288e)  /* U+288e BRAILLE PATTERN DOTS-2348 */
    static let XK_braille_dots_12348 = X11Keys(fromX11KeySym: 0x100288f)  /* U+288f BRAILLE PATTERN DOTS-12348 */
    static let XK_braille_dots_58 = X11Keys(fromX11KeySym: 0x1002890)  /* U+2890 BRAILLE PATTERN DOTS-58 */
    static let XK_braille_dots_158 = X11Keys(fromX11KeySym: 0x1002891)  /* U+2891 BRAILLE PATTERN DOTS-158 */
    static let XK_braille_dots_258 = X11Keys(fromX11KeySym: 0x1002892)  /* U+2892 BRAILLE PATTERN DOTS-258 */
    static let XK_braille_dots_1258 = X11Keys(fromX11KeySym: 0x1002893)  /* U+2893 BRAILLE PATTERN DOTS-1258 */
    static let XK_braille_dots_358 = X11Keys(fromX11KeySym: 0x1002894)  /* U+2894 BRAILLE PATTERN DOTS-358 */
    static let XK_braille_dots_1358 = X11Keys(fromX11KeySym: 0x1002895)  /* U+2895 BRAILLE PATTERN DOTS-1358 */
    static let XK_braille_dots_2358 = X11Keys(fromX11KeySym: 0x1002896)  /* U+2896 BRAILLE PATTERN DOTS-2358 */
    static let XK_braille_dots_12358 = X11Keys(fromX11KeySym: 0x1002897)  /* U+2897 BRAILLE PATTERN DOTS-12358 */
    static let XK_braille_dots_458 = X11Keys(fromX11KeySym: 0x1002898)  /* U+2898 BRAILLE PATTERN DOTS-458 */
    static let XK_braille_dots_1458 = X11Keys(fromX11KeySym: 0x1002899)  /* U+2899 BRAILLE PATTERN DOTS-1458 */
    static let XK_braille_dots_2458 = X11Keys(fromX11KeySym: 0x100289a)  /* U+289a BRAILLE PATTERN DOTS-2458 */
    static let XK_braille_dots_12458 = X11Keys(fromX11KeySym: 0x100289b)  /* U+289b BRAILLE PATTERN DOTS-12458 */
    static let XK_braille_dots_3458 = X11Keys(fromX11KeySym: 0x100289c)  /* U+289c BRAILLE PATTERN DOTS-3458 */
    static let XK_braille_dots_13458 = X11Keys(fromX11KeySym: 0x100289d)  /* U+289d BRAILLE PATTERN DOTS-13458 */
    static let XK_braille_dots_23458 = X11Keys(fromX11KeySym: 0x100289e)  /* U+289e BRAILLE PATTERN DOTS-23458 */
    static let XK_braille_dots_123458 = X11Keys(fromX11KeySym: 0x100289f)  /* U+289f BRAILLE PATTERN DOTS-123458 */
    static let XK_braille_dots_68 = X11Keys(fromX11KeySym: 0x10028a0)  /* U+28a0 BRAILLE PATTERN DOTS-68 */
    static let XK_braille_dots_168 = X11Keys(fromX11KeySym: 0x10028a1)  /* U+28a1 BRAILLE PATTERN DOTS-168 */
    static let XK_braille_dots_268 = X11Keys(fromX11KeySym: 0x10028a2)  /* U+28a2 BRAILLE PATTERN DOTS-268 */
    static let XK_braille_dots_1268 = X11Keys(fromX11KeySym: 0x10028a3)  /* U+28a3 BRAILLE PATTERN DOTS-1268 */
    static let XK_braille_dots_368 = X11Keys(fromX11KeySym: 0x10028a4)  /* U+28a4 BRAILLE PATTERN DOTS-368 */
    static let XK_braille_dots_1368 = X11Keys(fromX11KeySym: 0x10028a5)  /* U+28a5 BRAILLE PATTERN DOTS-1368 */
    static let XK_braille_dots_2368 = X11Keys(fromX11KeySym: 0x10028a6)  /* U+28a6 BRAILLE PATTERN DOTS-2368 */
    static let XK_braille_dots_12368 = X11Keys(fromX11KeySym: 0x10028a7)  /* U+28a7 BRAILLE PATTERN DOTS-12368 */
    static let XK_braille_dots_468 = X11Keys(fromX11KeySym: 0x10028a8)  /* U+28a8 BRAILLE PATTERN DOTS-468 */
    static let XK_braille_dots_1468 = X11Keys(fromX11KeySym: 0x10028a9)  /* U+28a9 BRAILLE PATTERN DOTS-1468 */
    static let XK_braille_dots_2468 = X11Keys(fromX11KeySym: 0x10028aa)  /* U+28aa BRAILLE PATTERN DOTS-2468 */
    static let XK_braille_dots_12468 = X11Keys(fromX11KeySym: 0x10028ab)  /* U+28ab BRAILLE PATTERN DOTS-12468 */
    static let XK_braille_dots_3468 = X11Keys(fromX11KeySym: 0x10028ac)  /* U+28ac BRAILLE PATTERN DOTS-3468 */
    static let XK_braille_dots_13468 = X11Keys(fromX11KeySym: 0x10028ad)  /* U+28ad BRAILLE PATTERN DOTS-13468 */
    static let XK_braille_dots_23468 = X11Keys(fromX11KeySym: 0x10028ae)  /* U+28ae BRAILLE PATTERN DOTS-23468 */
    static let XK_braille_dots_123468 = X11Keys(fromX11KeySym: 0x10028af)  /* U+28af BRAILLE PATTERN DOTS-123468 */
    static let XK_braille_dots_568 = X11Keys(fromX11KeySym: 0x10028b0)  /* U+28b0 BRAILLE PATTERN DOTS-568 */
    static let XK_braille_dots_1568 = X11Keys(fromX11KeySym: 0x10028b1)  /* U+28b1 BRAILLE PATTERN DOTS-1568 */
    static let XK_braille_dots_2568 = X11Keys(fromX11KeySym: 0x10028b2)  /* U+28b2 BRAILLE PATTERN DOTS-2568 */
    static let XK_braille_dots_12568 = X11Keys(fromX11KeySym: 0x10028b3)  /* U+28b3 BRAILLE PATTERN DOTS-12568 */
    static let XK_braille_dots_3568 = X11Keys(fromX11KeySym: 0x10028b4)  /* U+28b4 BRAILLE PATTERN DOTS-3568 */
    static let XK_braille_dots_13568 = X11Keys(fromX11KeySym: 0x10028b5)  /* U+28b5 BRAILLE PATTERN DOTS-13568 */
    static let XK_braille_dots_23568 = X11Keys(fromX11KeySym: 0x10028b6)  /* U+28b6 BRAILLE PATTERN DOTS-23568 */
    static let XK_braille_dots_123568 = X11Keys(fromX11KeySym: 0x10028b7)  /* U+28b7 BRAILLE PATTERN DOTS-123568 */
    static let XK_braille_dots_4568 = X11Keys(fromX11KeySym: 0x10028b8)  /* U+28b8 BRAILLE PATTERN DOTS-4568 */
    static let XK_braille_dots_14568 = X11Keys(fromX11KeySym: 0x10028b9)  /* U+28b9 BRAILLE PATTERN DOTS-14568 */
    static let XK_braille_dots_24568 = X11Keys(fromX11KeySym: 0x10028ba)  /* U+28ba BRAILLE PATTERN DOTS-24568 */
    static let XK_braille_dots_124568 = X11Keys(fromX11KeySym: 0x10028bb)  /* U+28bb BRAILLE PATTERN DOTS-124568 */
    static let XK_braille_dots_34568 = X11Keys(fromX11KeySym: 0x10028bc)  /* U+28bc BRAILLE PATTERN DOTS-34568 */
    static let XK_braille_dots_134568 = X11Keys(fromX11KeySym: 0x10028bd)  /* U+28bd BRAILLE PATTERN DOTS-134568 */
    static let XK_braille_dots_234568 = X11Keys(fromX11KeySym: 0x10028be)  /* U+28be BRAILLE PATTERN DOTS-234568 */
    static let XK_braille_dots_1234568 = X11Keys(fromX11KeySym: 0x10028bf)  /* U+28bf BRAILLE PATTERN DOTS-1234568 */
    static let XK_braille_dots_78 = X11Keys(fromX11KeySym: 0x10028c0)  /* U+28c0 BRAILLE PATTERN DOTS-78 */
    static let XK_braille_dots_178 = X11Keys(fromX11KeySym: 0x10028c1)  /* U+28c1 BRAILLE PATTERN DOTS-178 */
    static let XK_braille_dots_278 = X11Keys(fromX11KeySym: 0x10028c2)  /* U+28c2 BRAILLE PATTERN DOTS-278 */
    static let XK_braille_dots_1278 = X11Keys(fromX11KeySym: 0x10028c3)  /* U+28c3 BRAILLE PATTERN DOTS-1278 */
    static let XK_braille_dots_378 = X11Keys(fromX11KeySym: 0x10028c4)  /* U+28c4 BRAILLE PATTERN DOTS-378 */
    static let XK_braille_dots_1378 = X11Keys(fromX11KeySym: 0x10028c5)  /* U+28c5 BRAILLE PATTERN DOTS-1378 */
    static let XK_braille_dots_2378 = X11Keys(fromX11KeySym: 0x10028c6)  /* U+28c6 BRAILLE PATTERN DOTS-2378 */
    static let XK_braille_dots_12378 = X11Keys(fromX11KeySym: 0x10028c7)  /* U+28c7 BRAILLE PATTERN DOTS-12378 */
    static let XK_braille_dots_478 = X11Keys(fromX11KeySym: 0x10028c8)  /* U+28c8 BRAILLE PATTERN DOTS-478 */
    static let XK_braille_dots_1478 = X11Keys(fromX11KeySym: 0x10028c9)  /* U+28c9 BRAILLE PATTERN DOTS-1478 */
    static let XK_braille_dots_2478 = X11Keys(fromX11KeySym: 0x10028ca)  /* U+28ca BRAILLE PATTERN DOTS-2478 */
    static let XK_braille_dots_12478 = X11Keys(fromX11KeySym: 0x10028cb)  /* U+28cb BRAILLE PATTERN DOTS-12478 */
    static let XK_braille_dots_3478 = X11Keys(fromX11KeySym: 0x10028cc)  /* U+28cc BRAILLE PATTERN DOTS-3478 */
    static let XK_braille_dots_13478 = X11Keys(fromX11KeySym: 0x10028cd)  /* U+28cd BRAILLE PATTERN DOTS-13478 */
    static let XK_braille_dots_23478 = X11Keys(fromX11KeySym: 0x10028ce)  /* U+28ce BRAILLE PATTERN DOTS-23478 */
    static let XK_braille_dots_123478 = X11Keys(fromX11KeySym: 0x10028cf)  /* U+28cf BRAILLE PATTERN DOTS-123478 */
    static let XK_braille_dots_578 = X11Keys(fromX11KeySym: 0x10028d0)  /* U+28d0 BRAILLE PATTERN DOTS-578 */
    static let XK_braille_dots_1578 = X11Keys(fromX11KeySym: 0x10028d1)  /* U+28d1 BRAILLE PATTERN DOTS-1578 */
    static let XK_braille_dots_2578 = X11Keys(fromX11KeySym: 0x10028d2)  /* U+28d2 BRAILLE PATTERN DOTS-2578 */
    static let XK_braille_dots_12578 = X11Keys(fromX11KeySym: 0x10028d3)  /* U+28d3 BRAILLE PATTERN DOTS-12578 */
    static let XK_braille_dots_3578 = X11Keys(fromX11KeySym: 0x10028d4)  /* U+28d4 BRAILLE PATTERN DOTS-3578 */
    static let XK_braille_dots_13578 = X11Keys(fromX11KeySym: 0x10028d5)  /* U+28d5 BRAILLE PATTERN DOTS-13578 */
    static let XK_braille_dots_23578 = X11Keys(fromX11KeySym: 0x10028d6)  /* U+28d6 BRAILLE PATTERN DOTS-23578 */
    static let XK_braille_dots_123578 = X11Keys(fromX11KeySym: 0x10028d7)  /* U+28d7 BRAILLE PATTERN DOTS-123578 */
    static let XK_braille_dots_4578 = X11Keys(fromX11KeySym: 0x10028d8)  /* U+28d8 BRAILLE PATTERN DOTS-4578 */
    static let XK_braille_dots_14578 = X11Keys(fromX11KeySym: 0x10028d9)  /* U+28d9 BRAILLE PATTERN DOTS-14578 */
    static let XK_braille_dots_24578 = X11Keys(fromX11KeySym: 0x10028da)  /* U+28da BRAILLE PATTERN DOTS-24578 */
    static let XK_braille_dots_124578 = X11Keys(fromX11KeySym: 0x10028db)  /* U+28db BRAILLE PATTERN DOTS-124578 */
    static let XK_braille_dots_34578 = X11Keys(fromX11KeySym: 0x10028dc)  /* U+28dc BRAILLE PATTERN DOTS-34578 */
    static let XK_braille_dots_134578 = X11Keys(fromX11KeySym: 0x10028dd)  /* U+28dd BRAILLE PATTERN DOTS-134578 */
    static let XK_braille_dots_234578 = X11Keys(fromX11KeySym: 0x10028de)  /* U+28de BRAILLE PATTERN DOTS-234578 */
    static let XK_braille_dots_1234578 = X11Keys(fromX11KeySym: 0x10028df)  /* U+28df BRAILLE PATTERN DOTS-1234578 */
    static let XK_braille_dots_678 = X11Keys(fromX11KeySym: 0x10028e0)  /* U+28e0 BRAILLE PATTERN DOTS-678 */
    static let XK_braille_dots_1678 = X11Keys(fromX11KeySym: 0x10028e1)  /* U+28e1 BRAILLE PATTERN DOTS-1678 */
    static let XK_braille_dots_2678 = X11Keys(fromX11KeySym: 0x10028e2)  /* U+28e2 BRAILLE PATTERN DOTS-2678 */
    static let XK_braille_dots_12678 = X11Keys(fromX11KeySym: 0x10028e3)  /* U+28e3 BRAILLE PATTERN DOTS-12678 */
    static let XK_braille_dots_3678 = X11Keys(fromX11KeySym: 0x10028e4)  /* U+28e4 BRAILLE PATTERN DOTS-3678 */
    static let XK_braille_dots_13678 = X11Keys(fromX11KeySym: 0x10028e5)  /* U+28e5 BRAILLE PATTERN DOTS-13678 */
    static let XK_braille_dots_23678 = X11Keys(fromX11KeySym: 0x10028e6)  /* U+28e6 BRAILLE PATTERN DOTS-23678 */
    static let XK_braille_dots_123678 = X11Keys(fromX11KeySym: 0x10028e7)  /* U+28e7 BRAILLE PATTERN DOTS-123678 */
    static let XK_braille_dots_4678 = X11Keys(fromX11KeySym: 0x10028e8)  /* U+28e8 BRAILLE PATTERN DOTS-4678 */
    static let XK_braille_dots_14678 = X11Keys(fromX11KeySym: 0x10028e9)  /* U+28e9 BRAILLE PATTERN DOTS-14678 */
    static let XK_braille_dots_24678 = X11Keys(fromX11KeySym: 0x10028ea)  /* U+28ea BRAILLE PATTERN DOTS-24678 */
    static let XK_braille_dots_124678 = X11Keys(fromX11KeySym: 0x10028eb)  /* U+28eb BRAILLE PATTERN DOTS-124678 */
    static let XK_braille_dots_34678 = X11Keys(fromX11KeySym: 0x10028ec)  /* U+28ec BRAILLE PATTERN DOTS-34678 */
    static let XK_braille_dots_134678 = X11Keys(fromX11KeySym: 0x10028ed)  /* U+28ed BRAILLE PATTERN DOTS-134678 */
    static let XK_braille_dots_234678 = X11Keys(fromX11KeySym: 0x10028ee)  /* U+28ee BRAILLE PATTERN DOTS-234678 */
    static let XK_braille_dots_1234678 = X11Keys(fromX11KeySym: 0x10028ef)  /* U+28ef BRAILLE PATTERN DOTS-1234678 */
    static let XK_braille_dots_5678 = X11Keys(fromX11KeySym: 0x10028f0)  /* U+28f0 BRAILLE PATTERN DOTS-5678 */
    static let XK_braille_dots_15678 = X11Keys(fromX11KeySym: 0x10028f1)  /* U+28f1 BRAILLE PATTERN DOTS-15678 */
    static let XK_braille_dots_25678 = X11Keys(fromX11KeySym: 0x10028f2)  /* U+28f2 BRAILLE PATTERN DOTS-25678 */
    static let XK_braille_dots_125678 = X11Keys(fromX11KeySym: 0x10028f3)  /* U+28f3 BRAILLE PATTERN DOTS-125678 */
    static let XK_braille_dots_35678 = X11Keys(fromX11KeySym: 0x10028f4)  /* U+28f4 BRAILLE PATTERN DOTS-35678 */
    static let XK_braille_dots_135678 = X11Keys(fromX11KeySym: 0x10028f5)  /* U+28f5 BRAILLE PATTERN DOTS-135678 */
    static let XK_braille_dots_235678 = X11Keys(fromX11KeySym: 0x10028f6)  /* U+28f6 BRAILLE PATTERN DOTS-235678 */
    static let XK_braille_dots_1235678 = X11Keys(fromX11KeySym: 0x10028f7)  /* U+28f7 BRAILLE PATTERN DOTS-1235678 */
    static let XK_braille_dots_45678 = X11Keys(fromX11KeySym: 0x10028f8)  /* U+28f8 BRAILLE PATTERN DOTS-45678 */
    static let XK_braille_dots_145678 = X11Keys(fromX11KeySym: 0x10028f9)  /* U+28f9 BRAILLE PATTERN DOTS-145678 */
    static let XK_braille_dots_245678 = X11Keys(fromX11KeySym: 0x10028fa)  /* U+28fa BRAILLE PATTERN DOTS-245678 */
    static let XK_braille_dots_1245678 = X11Keys(fromX11KeySym: 0x10028fb)  /* U+28fb BRAILLE PATTERN DOTS-1245678 */
    static let XK_braille_dots_345678 = X11Keys(fromX11KeySym: 0x10028fc)  /* U+28fc BRAILLE PATTERN DOTS-345678 */
    static let XK_braille_dots_1345678 = X11Keys(fromX11KeySym: 0x10028fd)  /* U+28fd BRAILLE PATTERN DOTS-1345678 */
    static let XK_braille_dots_2345678 = X11Keys(fromX11KeySym: 0x10028fe)  /* U+28fe BRAILLE PATTERN DOTS-2345678 */
    static let XK_braille_dots_12345678 = X11Keys(fromX11KeySym: 0x10028ff)  /* U+28ff BRAILLE PATTERN DOTS-12345678 */

    static let XK_Sinh_ng = X11Keys(fromX11KeySym: 0x1000d82)  /* U+0D82 SINHALA ANUSVARAYA */
    static let XK_Sinh_h2 = X11Keys(fromX11KeySym: 0x1000d83)  /* U+0D83 SINHALA VISARGAYA */
    static let XK_Sinh_a = X11Keys(fromX11KeySym: 0x1000d85)  /* U+0D85 SINHALA AYANNA */
    static let XK_Sinh_aa = X11Keys(fromX11KeySym: 0x1000d86)  /* U+0D86 SINHALA AAYANNA */
    static let XK_Sinh_ae = X11Keys(fromX11KeySym: 0x1000d87)  /* U+0D87 SINHALA AEYANNA */
    static let XK_Sinh_aee = X11Keys(fromX11KeySym: 0x1000d88)  /* U+0D88 SINHALA AEEYANNA */
    static let XK_Sinh_i = X11Keys(fromX11KeySym: 0x1000d89)  /* U+0D89 SINHALA IYANNA */
    static let XK_Sinh_ii = X11Keys(fromX11KeySym: 0x1000d8a)  /* U+0D8A SINHALA IIYANNA */
    static let XK_Sinh_u = X11Keys(fromX11KeySym: 0x1000d8b)  /* U+0D8B SINHALA UYANNA */
    static let XK_Sinh_uu = X11Keys(fromX11KeySym: 0x1000d8c)  /* U+0D8C SINHALA UUYANNA */
    static let XK_Sinh_ri = X11Keys(fromX11KeySym: 0x1000d8d)  /* U+0D8D SINHALA IRUYANNA */
    static let XK_Sinh_rii = X11Keys(fromX11KeySym: 0x1000d8e)  /* U+0D8E SINHALA IRUUYANNA */
    static let XK_Sinh_lu = X11Keys(fromX11KeySym: 0x1000d8f)  /* U+0D8F SINHALA ILUYANNA */
    static let XK_Sinh_luu = X11Keys(fromX11KeySym: 0x1000d90)  /* U+0D90 SINHALA ILUUYANNA */
    static let XK_Sinh_e = X11Keys(fromX11KeySym: 0x1000d91)  /* U+0D91 SINHALA EYANNA */
    static let XK_Sinh_ee = X11Keys(fromX11KeySym: 0x1000d92)  /* U+0D92 SINHALA EEYANNA */
    static let XK_Sinh_ai = X11Keys(fromX11KeySym: 0x1000d93)  /* U+0D93 SINHALA AIYANNA */
    static let XK_Sinh_o = X11Keys(fromX11KeySym: 0x1000d94)  /* U+0D94 SINHALA OYANNA */
    static let XK_Sinh_oo = X11Keys(fromX11KeySym: 0x1000d95)  /* U+0D95 SINHALA OOYANNA */
    static let XK_Sinh_au = X11Keys(fromX11KeySym: 0x1000d96)  /* U+0D96 SINHALA AUYANNA */
    static let XK_Sinh_ka = X11Keys(fromX11KeySym: 0x1000d9a)  /* U+0D9A SINHALA KAYANNA */
    static let XK_Sinh_kha = X11Keys(fromX11KeySym: 0x1000d9b)  /* U+0D9B SINHALA MAHA. KAYANNA */
    static let XK_Sinh_ga = X11Keys(fromX11KeySym: 0x1000d9c)  /* U+0D9C SINHALA GAYANNA */
    static let XK_Sinh_gha = X11Keys(fromX11KeySym: 0x1000d9d)  /* U+0D9D SINHALA MAHA. GAYANNA */
    static let XK_Sinh_ng2 = X11Keys(fromX11KeySym: 0x1000d9e)  /* U+0D9E SINHALA KANTAJA NAASIKYAYA */
    static let XK_Sinh_nga = X11Keys(fromX11KeySym: 0x1000d9f)  /* U+0D9F SINHALA SANYAKA GAYANNA */
    static let XK_Sinh_ca = X11Keys(fromX11KeySym: 0x1000da0)  /* U+0DA0 SINHALA CAYANNA */
    static let XK_Sinh_cha = X11Keys(fromX11KeySym: 0x1000da1)  /* U+0DA1 SINHALA MAHA. CAYANNA */
    static let XK_Sinh_ja = X11Keys(fromX11KeySym: 0x1000da2)  /* U+0DA2 SINHALA JAYANNA */
    static let XK_Sinh_jha = X11Keys(fromX11KeySym: 0x1000da3)  /* U+0DA3 SINHALA MAHA. JAYANNA */
    static let XK_Sinh_nya = X11Keys(fromX11KeySym: 0x1000da4)  /* U+0DA4 SINHALA TAALUJA NAASIKYAYA */
    static let XK_Sinh_jnya = X11Keys(fromX11KeySym: 0x1000da5)  /* U+0DA5 SINHALA TAALUJA SANYOOGA NAASIKYAYA */
    static let XK_Sinh_nja = X11Keys(fromX11KeySym: 0x1000da6)  /* U+0DA6 SINHALA SANYAKA JAYANNA */
    static let XK_Sinh_tta = X11Keys(fromX11KeySym: 0x1000da7)  /* U+0DA7 SINHALA TTAYANNA */
    static let XK_Sinh_ttha = X11Keys(fromX11KeySym: 0x1000da8)  /* U+0DA8 SINHALA MAHA. TTAYANNA */
    static let XK_Sinh_dda = X11Keys(fromX11KeySym: 0x1000da9)  /* U+0DA9 SINHALA DDAYANNA */
    static let XK_Sinh_ddha = X11Keys(fromX11KeySym: 0x1000daa)  /* U+0DAA SINHALA MAHA. DDAYANNA */
    static let XK_Sinh_nna = X11Keys(fromX11KeySym: 0x1000dab)  /* U+0DAB SINHALA MUURDHAJA NAYANNA */
    static let XK_Sinh_ndda = X11Keys(fromX11KeySym: 0x1000dac)  /* U+0DAC SINHALA SANYAKA DDAYANNA */
    static let XK_Sinh_tha = X11Keys(fromX11KeySym: 0x1000dad)  /* U+0DAD SINHALA TAYANNA */
    static let XK_Sinh_thha = X11Keys(fromX11KeySym: 0x1000dae)  /* U+0DAE SINHALA MAHA. TAYANNA */
    static let XK_Sinh_dha = X11Keys(fromX11KeySym: 0x1000daf)  /* U+0DAF SINHALA DAYANNA */
    static let XK_Sinh_dhha = X11Keys(fromX11KeySym: 0x1000db0)  /* U+0DB0 SINHALA MAHA. DAYANNA */
    static let XK_Sinh_na = X11Keys(fromX11KeySym: 0x1000db1)  /* U+0DB1 SINHALA DANTAJA NAYANNA */
    static let XK_Sinh_ndha = X11Keys(fromX11KeySym: 0x1000db3)  /* U+0DB3 SINHALA SANYAKA DAYANNA */
    static let XK_Sinh_pa = X11Keys(fromX11KeySym: 0x1000db4)  /* U+0DB4 SINHALA PAYANNA */
    static let XK_Sinh_pha = X11Keys(fromX11KeySym: 0x1000db5)  /* U+0DB5 SINHALA MAHA. PAYANNA */
    static let XK_Sinh_ba = X11Keys(fromX11KeySym: 0x1000db6)  /* U+0DB6 SINHALA BAYANNA */
    static let XK_Sinh_bha = X11Keys(fromX11KeySym: 0x1000db7)  /* U+0DB7 SINHALA MAHA. BAYANNA */
    static let XK_Sinh_ma = X11Keys(fromX11KeySym: 0x1000db8)  /* U+0DB8 SINHALA MAYANNA */
    static let XK_Sinh_mba = X11Keys(fromX11KeySym: 0x1000db9)  /* U+0DB9 SINHALA AMBA BAYANNA */
    static let XK_Sinh_ya = X11Keys(fromX11KeySym: 0x1000dba)  /* U+0DBA SINHALA YAYANNA */
    static let XK_Sinh_ra = X11Keys(fromX11KeySym: 0x1000dbb)  /* U+0DBB SINHALA RAYANNA */
    static let XK_Sinh_la = X11Keys(fromX11KeySym: 0x1000dbd)  /* U+0DBD SINHALA DANTAJA LAYANNA */
    static let XK_Sinh_va = X11Keys(fromX11KeySym: 0x1000dc0)  /* U+0DC0 SINHALA VAYANNA */
    static let XK_Sinh_sha = X11Keys(fromX11KeySym: 0x1000dc1)  /* U+0DC1 SINHALA TAALUJA SAYANNA */
    static let XK_Sinh_ssha = X11Keys(fromX11KeySym: 0x1000dc2)  /* U+0DC2 SINHALA MUURDHAJA SAYANNA */
    static let XK_Sinh_sa = X11Keys(fromX11KeySym: 0x1000dc3)  /* U+0DC3 SINHALA DANTAJA SAYANNA */
    static let XK_Sinh_ha = X11Keys(fromX11KeySym: 0x1000dc4)  /* U+0DC4 SINHALA HAYANNA */
    static let XK_Sinh_lla = X11Keys(fromX11KeySym: 0x1000dc5)  /* U+0DC5 SINHALA MUURDHAJA LAYANNA */
    static let XK_Sinh_fa = X11Keys(fromX11KeySym: 0x1000dc6)  /* U+0DC6 SINHALA FAYANNA */
    static let XK_Sinh_al = X11Keys(fromX11KeySym: 0x1000dca)  /* U+0DCA SINHALA AL-LAKUNA */
    static let XK_Sinh_aa2 = X11Keys(fromX11KeySym: 0x1000dcf)  /* U+0DCF SINHALA AELA-PILLA */
    static let XK_Sinh_ae2 = X11Keys(fromX11KeySym: 0x1000dd0)  /* U+0DD0 SINHALA AEDA-PILLA */
    static let XK_Sinh_aee2 = X11Keys(fromX11KeySym: 0x1000dd1)  /* U+0DD1 SINHALA DIGA AEDA-PILLA */
    static let XK_Sinh_i2 = X11Keys(fromX11KeySym: 0x1000dd2)  /* U+0DD2 SINHALA IS-PILLA */
    static let XK_Sinh_ii2 = X11Keys(fromX11KeySym: 0x1000dd3)  /* U+0DD3 SINHALA DIGA IS-PILLA */
    static let XK_Sinh_u2 = X11Keys(fromX11KeySym: 0x1000dd4)  /* U+0DD4 SINHALA PAA-PILLA */
    static let XK_Sinh_uu2 = X11Keys(fromX11KeySym: 0x1000dd6)  /* U+0DD6 SINHALA DIGA PAA-PILLA */
    static let XK_Sinh_ru2 = X11Keys(fromX11KeySym: 0x1000dd8)  /* U+0DD8 SINHALA GAETTA-PILLA */
    static let XK_Sinh_e2 = X11Keys(fromX11KeySym: 0x1000dd9)  /* U+0DD9 SINHALA KOMBUVA */
    static let XK_Sinh_ee2 = X11Keys(fromX11KeySym: 0x1000dda)  /* U+0DDA SINHALA DIGA KOMBUVA */
    static let XK_Sinh_ai2 = X11Keys(fromX11KeySym: 0x1000ddb)  /* U+0DDB SINHALA KOMBU DEKA */
    static let XK_Sinh_o2 = X11Keys(fromX11KeySym: 0x1000ddc)  /* U+0DDC SINHALA KOMBUVA HAA AELA-PILLA*/
    static let XK_Sinh_oo2 = X11Keys(fromX11KeySym: 0x1000ddd)  /* U+0DDD SINHALA KOMBUVA HAA DIGA AELA-PILLA*/
    static let XK_Sinh_au2 = X11Keys(fromX11KeySym: 0x1000dde)  /* U+0DDE SINHALA KOMBUVA HAA GAYANUKITTA */
    static let XK_Sinh_lu2 = X11Keys(fromX11KeySym: 0x1000ddf)  /* U+0DDF SINHALA GAYANUKITTA */
    static let XK_Sinh_ruu2 = X11Keys(fromX11KeySym: 0x1000df2)  /* U+0DF2 SINHALA DIGA GAETTA-PILLA */
    static let XK_Sinh_luu2 = X11Keys(fromX11KeySym: 0x1000df3)  /* U+0DF3 SINHALA DIGA GAYANUKITTA */
    static let XK_Sinh_kunddaliya = X11Keys(fromX11KeySym: 0x1000df4)  /* U+0DF4 SINHALA KUNDDALIYA */
}
