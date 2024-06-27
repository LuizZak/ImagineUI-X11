#ifndef XLIB_ILLEGAL_ACCESS
#define XLIB_ILLEGAL_ACCESS 1
#endif

// keysymdef.h macros
#define XK_MISCELLANY 1
#define XK_LATIN1 1

#define XUTIL_DEFINE_FUNCTIONS

#include <stdarg.h>
#include <X11/Xlib.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <X11/keysym.h>
#include <X11/keysymdef.h>
#include <X11/X.h>
#include <X11/Xatom.h>
#include <X11/cursorfont.h>
#include <X11/Xresource.h>
#include <X11/extensions/Xfixes.h>
#include <X11/extensions/Xdbe.h>
#include <X11/extensions/XShm.h>

// Used to invoke 'XCreateIC' with variadic arguments from Swift
XIC _XCreateIC(XIM xim, Window window);
