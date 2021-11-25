import UIKit

enum NavigationType {
    case root
    case rootTransition(duration: TimeInterval)
    case push
    case present
    case pushHidingTabBar
}
