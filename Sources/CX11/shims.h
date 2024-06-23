#ifndef XLIB_ILLEGAL_ACCESS
#define XLIB_ILLEGAL_ACCESS 1
#endif

// keysymdef.h macros
#define XK_MISCELLANY 1
#define XK_LATIN1 1

#include <stdarg.h>
#include "/usr/include/X11/Xlib.h"

// Used to invoke 'XCreateIC' with variadic arguments from Swift
XIC _XCreateIC(XIM xim, Window window);
