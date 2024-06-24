import ImagineUI
import MinX11

extension X11Keys {
    var asKeys: Keys {
        switch self {
        // Alphabet
        case .XK_a, .XK_A: return .a
        case .XK_b, .XK_B: return .b
        case .XK_c, .XK_C: return .c
        case .XK_d, .XK_D: return .d
        case .XK_e, .XK_E: return .e
        case .XK_f, .XK_F: return .f
        case .XK_g, .XK_G: return .g
        case .XK_h, .XK_H: return .h
        case .XK_j, .XK_J: return .j
        case .XK_i, .XK_I: return .i
        case .XK_k, .XK_K: return .k
        case .XK_l, .XK_L: return .l
        case .XK_m, .XK_M: return .m
        case .XK_n, .XK_N: return .n
        case .XK_o, .XK_O: return .o
        case .XK_p, .XK_P: return .p
        case .XK_q, .XK_Q: return .q
        case .XK_r, .XK_R: return .r
        case .XK_s, .XK_S: return .s
        case .XK_t, .XK_T: return .t
        case .XK_u, .XK_U: return .u
        case .XK_v, .XK_V: return .v
        case .XK_w, .XK_W: return .w
        case .XK_x, .XK_X: return .x
        case .XK_y, .XK_Y: return .y
        case .XK_z, .XK_Z: return .z
        // Modifiers
        case .XK_Alt_L, .XK_Alt_R: return .alt
        case .XK_Control_L: return .lControlKey
        case .XK_Control_R: return .rControlKey
        case .XK_Shift_L: return .lShiftKey
        case .XK_Shift_R: return .rShiftKey
        case .XK_Super_L: return .lWin
        case .XK_Super_R: return .rWin
        // Numpad
        case .XK_Num_Lock: return .numLock
        case .XK_KP_Separator: return .separator
        case .XK_KP_0: return .numPad0
        case .XK_KP_1: return .numPad1
        case .XK_KP_2: return .numPad2
        case .XK_KP_3: return .numPad3
        case .XK_KP_4: return .numPad4
        case .XK_KP_5: return .numPad5
        case .XK_KP_6: return .numPad6
        case .XK_KP_7: return .numPad7
        case .XK_KP_8: return .numPad8
        case .XK_KP_9: return .numPad9
        case .XK_KP_Add: return .add
        case .XK_KP_Decimal: return .decimal
        case .XK_KP_Multiply, .XK_multiply: return .multiply
        case .XK_KP_Divide, .XK_division: return .divide
        case .XK_KP_Subtract: return .subtract
        case .XK_minus: return .oemMinus
        // Function keys
        case .XK_F1: return .f1
        case .XK_F2: return .f2
        case .XK_F3: return .f3
        case .XK_F4: return .f4
        case .XK_F5: return .f5
        case .XK_F6: return .f6
        case .XK_F7: return .f7
        case .XK_F8: return .f8
        case .XK_F9: return .f9
        case .XK_F10: return .f10
        case .XK_F11: return .f11
        case .XK_F12: return .f12
        case .XK_F13: return .f13
        case .XK_F14: return .f14
        case .XK_F15: return .f15
        case .XK_F16: return .f16
        case .XK_F17: return .f17
        case .XK_F18: return .f18
        case .XK_F19: return .f19
        case .XK_F20: return .f20
        case .XK_F21: return .f21
        case .XK_F22: return .f22
        case .XK_F23: return .f23
        case .XK_F24: return .f24
        // Navigation
        case .XK_space: return .space
        case .XK_Tab: return .tab
        case .XK_Return: return .return
        case .XK_BackSpace: return .back
        case .XK_Left: return .left
        case .XK_Up: return .up
        case .XK_Right: return .right
        case .XK_Down: return .down
        case .XK_Home: return .home
        case .XK_End: return .end
        case .XK_Page_Down: return .pageDown
        case .XK_Page_Up: return .pageUp
        case .XK_Next: return .next
        case .XK_Prior: return .prior
        case .XK_Insert: return .insert
        case .XK_Select: return .select
        case .XK_Delete: return .delete
        // Misc.
        case .XK_Caps_Lock: return .capsLock
        case .XK_Cancel: return .cancel
        case .XK_Menu: return .menu
        case .XK_Clear: return .clear
        case .XK_3270_CursorSelect: return .crsel
        case .XK_3270_EraseEOF: return .eraseEof
        case .XK_3270_ExSelect: return .exsel
        case .XK_Pause: return .pause
        case .XK_Print: return .print
        case .XK_3270_Attn: return .attn
        case .XK_3270_PrintScreen: return .printScreen
        case .XK_Hangul: return .hangulMode
        case .XK_Hangul_Hanja: return .hanjaMode
        case .XK_Help: return .help
        case .XK_Mode_switch: return .imeModeChange
        case .XK_Kanji: return .kanjiMode
        case .XK_Hiragana_Katakana: return .kanaMode
        case .XK_Linefeed: return .lineFeed
        default:
            return .init(rawValue: rawValue)
        }
    }
}
