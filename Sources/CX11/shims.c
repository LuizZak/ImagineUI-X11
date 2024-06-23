#include "shims.h"

XIC _XCreateIC(XIM xim, Window window) {
    return XCreateIC(xim,
        XNInputStyle, XIMPreeditNothing | XIMStatusNothing,
        XNClientWindow, window,
        XNFocusWindow, window,
        NULL
    );
}
