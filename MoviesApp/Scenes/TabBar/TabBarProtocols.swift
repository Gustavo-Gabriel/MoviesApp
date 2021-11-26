import UIKit

protocol TabBarPresenterType: AnyObject, UITabBarControllerDelegate {
    var delegate: TabBarPresenterDelegate? { get set }
    var currentNavigationController: UINavigationController { get set }
    var tabFlows: [TabBarItemFlow] { get }
}

protocol TabBarPresenterDelegate: AnyObject {
    func didChangeTab(to flow: TabBarItemFlow)
}

protocol TabBarItemCoordinatorFactoryType {
    var delegate: TabBarItemCoordinatorFactoryDelegate? { get set }
    func build(for flows: [TabBarItemFlow]) -> [TabBarItemFlow: Coordinator]
}
