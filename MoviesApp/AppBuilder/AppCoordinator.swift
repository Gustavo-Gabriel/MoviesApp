import UIKit

class AppCoordinator {

    private(set) var parentViewController: ParentViewController
    var navigationController: UINavigationController = UINavigationController()
    weak var window: UIWindow?
    var currentCoordinator: Coordinator?

    init(window: UIWindow) {
        self.window = window
        let controller = ParentViewController(child: navigationController)
        self.parentViewController = controller
        window.rootViewController = parentViewController
        window.makeKeyAndVisible()
    }

    func start() {
        let coordinator = createHomeCoordinator()
        currentCoordinator = coordinator
        coordinator.start(with: .root)
    }

    func createHomeCoordinator() -> HomeCoordinator {
        let homeCoordinator = HomeCoordinator(navigationController: self.navigationController)
        return homeCoordinator
    }
 }

