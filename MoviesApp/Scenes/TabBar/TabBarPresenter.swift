import UIKit

final class TabBarPresenter: NSObject, TabBarPresenterType {
    weak var delegate: TabBarPresenterDelegate?
    private var coordinatorResolver: CoordinatorResolver
    var tabFlows: [TabBarItemFlow]

    var currentNavigationController: UINavigationController {
        get { return coordinatorResolver.navigationController }
        set { coordinatorResolver.navigationController = newValue }
    }
    
    init(coordinatorResolver: CoordinatorResolver,
         tabFlows: [TabBarItemFlow]) {
        self.coordinatorResolver = coordinatorResolver
        self.tabFlows = tabFlows
    }
}

extension TabBarPresenter: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        
        guard let navigationController = viewController as? UINavigationController else { return }

        didSelectTab(with: navigationController,
                     in: tabBarController.selectedIndex)
    }
    
    private func didSelectTab(with navigationController: UINavigationController,
                              in index: Int) {
        currentNavigationController = navigationController
        
        guard tabFlows.indices.contains(index) else { return }
        delegate?.didChangeTab(to: tabFlows[index])
    }
}
