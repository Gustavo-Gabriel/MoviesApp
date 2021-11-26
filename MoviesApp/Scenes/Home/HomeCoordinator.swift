import UIKit

class HomeCoordinator: Coordinator {
    var currentViewController: UIViewController?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(with naviagtionType: NavigationType = .push) {
        let controller = createHomeViewController()
        show(controller, with: naviagtionType)
    }
    
    func createHomeViewController() -> HomeViewController {
        let homeViewController = HomeViewController()
        currentViewController = homeViewController
        return homeViewController
    }
}
