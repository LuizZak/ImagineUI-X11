import CX11

/// Used during debugging to identify messages by type.
internal enum _XEventType: Int32 {
    case KeyPress = 2
    case KeyRelease = 3
    case ButtonPress = 4
    case ButtonRelease = 5
    case MotionNotify = 6
    case EnterNotify = 7
    case LeaveNotify = 8
    case FocusIn = 9
    case FocusOut = 10
    case KeymapNotify = 11
    case Expose = 12
    case GraphicsExpose = 13
    case NoExpose = 14
    case VisibilityNotify = 15
    case CreateNotify = 16
    case DestroyNotify = 17
    case UnmapNotify = 18
    case MapNotify = 19
    case MapRequest = 20
    case ReparentNotify = 21
    case ConfigureNotify = 22
    case ConfigureRequest = 23
    case GravityNotify = 24
    case ResizeRequest = 25
    case CirculateNotify = 26
    case CirculateRequest = 27
    case PropertyNotify = 28
    case SelectionClear = 29
    case SelectionRequest = 30
    case SelectionNotify = 31
    case ColormapNotify = 32
    case ClientMessage = 33
    case MappingNotify = 34
    case GenericEvent = 35
    case unknown = -1

    var description: String {
        switch self {
        case .KeyPress:
            return "KeyPress"
        case .KeyRelease:
            return "KeyRelease"
        case .ButtonPress:
            return "ButtonPress"
        case .ButtonRelease:
            return "ButtonRelease"
        case .MotionNotify:
            return "MotionNotify"
        case .EnterNotify:
            return "EnterNotify"
        case .LeaveNotify:
            return "LeaveNotify"
        case .FocusIn:
            return "FocusIn"
        case .FocusOut:
            return "FocusOut"
        case .KeymapNotify:
            return "KeymapNotify"
        case .Expose:
            return "Expose"
        case .GraphicsExpose:
            return "GraphicsExpose"
        case .NoExpose:
            return "NoExpose"
        case .VisibilityNotify:
            return "VisibilityNotify"
        case .CreateNotify:
            return "CreateNotify"
        case .DestroyNotify:
            return "DestroyNotify"
        case .UnmapNotify:
            return "UnmapNotify"
        case .MapNotify:
            return "MapNotify"
        case .MapRequest:
            return "MapRequest"
        case .ReparentNotify:
            return "ReparentNotify"
        case .ConfigureNotify:
            return "ConfigureNotify"
        case .ConfigureRequest:
            return "ConfigureRequest"
        case .GravityNotify:
            return "GravityNotify"
        case .ResizeRequest:
            return "ResizeRequest"
        case .CirculateNotify:
            return "CirculateNotify"
        case .CirculateRequest:
            return "CirculateRequest"
        case .PropertyNotify:
            return "PropertyNotify"
        case .SelectionClear:
            return "SelectionClear"
        case .SelectionRequest:
            return "SelectionRequest"
        case .SelectionNotify:
            return "SelectionNotify"
        case .ColormapNotify:
            return "ColormapNotify"
        case .ClientMessage:
            return "ClientMessage"
        case .MappingNotify:
            return "MappingNotify"
        case .GenericEvent:
            return "GenericEvent"
        case .unknown:
            return "<<unknown>>"
        }
    }
}

extension _XEventType {
    static func from(event: XEvent) -> Self {
        Self(rawValue: event.type) ?? .unknown
    }

    static func from(_ value: Int32) -> Self {
        Self(rawValue: value) ?? .unknown
    }
}
