import UIKit

enum TabBarItemFlow: CaseIterable {
    case home
    case favorites
}

final class TabBarCoordinator: Coordinator {
    weak var delegate: TabBarCoordinatorDelegate?
    var currentViewController: UIViewController?
    var navigationController: UINavigationController
    private(set) var currentCoordinator: Coordinator?
    
    private var tabBarItemCoordinatorFactory: TabBarItemCoordinatorFactoryType
    private(set) var tabBarController: TabBarController?
    private let tabFlows: [TabBarItemFlow]
    private var tabBarCoordinators: [Coordinator] = []
    
    private var coordinatorResolver: CoordinatorResolver
    
    private var navigationsControllers: [UINavigationController] {
        return tabBarCoordinators.map { $0.navigationController }
    }
    
    private(set) var homeCoordinator: HomeCoordinator?
    private(set) var favoritesCoordinator: FavoritesCoordinator?
    
    init(coordinatorResolver: CoordinatorResolver,
         tabFlows: [TabBarItemFlow],
         mainNavigation: UINavigationController,
         tabBarCoordinatorFactory: TabBarItemCoordinatorFactoryType? = nil) {
        self.coordinatorResolver = coordinatorResolver
        self.tabFlows = tabFlows
        self.navigationController = mainNavigation
        self.tabBarItemCoordinatorFactory = tabBarCoordinatorFactory ?? TabBarItemCoordinatorFactory(resolver: coordinatorResolver)
        self.tabBarItemCoordinatorFactory.delegate = self
    }
    
    func start(with navigationType: NavigationType) {
        setupTabBarCoordinators()
        setupTabBarController()
        showTabBar()
    }
    
    private func showTabBar() {
        tabBarCoordinators.forEach { $0.start(with: .push) }
        guard let currentViewController = currentViewController else { return }
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(currentViewController, animated: true)

    }
    
    private func setupTabBarController() {
        let tabBarController = createTabBarController()
        currentViewController = tabBarController
        self.tabBarController = tabBarController
    }
    
    private func createTabBarController() -> TabBarController {
        let tabBarPresenter = TabBarPresenter(coordinatorResolver: coordinatorResolver,
                                              tabFlows: tabFlows)
        tabBarPresenter.delegate = self
        return TabBarController(presenter: tabBarPresenter,
                                navigationControllers: navigationsControllers)
    }
    
    private func setupTabBarCoordinators() {
        let coordinators = tabBarItemCoordinatorFactory.build(for: tabFlows)

        tabFlows.forEach { flow in
            guard let coordinator = coordinators[flow] else { return }
            tabBarCoordinators.append(coordinator)
        }
        
        homeCoordinator = coordinators[.home] as? HomeCoordinator
        favoritesCoordinator = coordinators[.favorites] as? FavoritesCoordinator
        
        coordinatorResolver.delegate = homeCoordinator as? CoordinatorResolverDelegate
    }
}

extension TabBarCoordinator: HomeCoordinatorDelegate {

}

extension TabBarCoordinator: FavoritesCoordinatorDelegate {

}

extension TabBarCoordinator: TabBarPresenterDelegate {
    func didChangeTab(to flow: TabBarItemFlow) {
        guard let tabIndex = navigationsControllers.firstIndex(of: navigationController),
              tabFlows.indices.contains(tabIndex) else { return }
        didChangeTab(to: tabFlows[tabIndex])
    }
}
