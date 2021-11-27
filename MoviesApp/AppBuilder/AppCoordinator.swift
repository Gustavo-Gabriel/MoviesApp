import UIKit

class AppCoordinator {

    private(set) var parentViewController: ParentViewController
    var navigationController: UINavigationController = UINavigationController()
    weak var window: UIWindow?
    var currentCoordinator: Coordinator?
    var tabBarCoordinator: Coordinator?
    var homeCoordinator: HomeCoordinator?

    init(window: UIWindow) {
        self.window = window
        let controller = ParentViewController(child: navigationController)
        self.parentViewController = controller
        window.rootViewController = parentViewController
        window.makeKeyAndVisible()
    }

    func start() {
        let coordinator = createTabBarCoordinator()
        currentCoordinator = coordinator
        coordinator.start(with: .root)
    }

    private func createHomeCoordinator() -> HomeCoordinator {
        let homeCoordinator = HomeCoordinator(navigationController: self.navigationController)
        return homeCoordinator
    }
    
    private func createTabBarCoordinator() -> TabBarCoordinator {
        let resolver = CoordinatorResolver(navigationController: self.navigationController)
        let flows: [TabBarItemFlow] = [.home, .favorites]
        
        let tabBarCoordinator = TabBarCoordinator(coordinatorResolver: resolver,
                                                  tabFlows: flows,
                                                  mainNavigation: self.navigationController)
        self.tabBarCoordinator = tabBarCoordinator
        self.currentCoordinator = tabBarCoordinator
        
        return tabBarCoordinator
    }
 }

