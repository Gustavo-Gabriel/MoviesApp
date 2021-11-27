import UIKit

class FavoritesCoordinator: Coordinator {
    weak var delegate: FavoritesCoordinatorDelegate?
    var currentViewController: UIViewController?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(with naviagtionType: NavigationType = .push) {
        let controller = createFavoritesViewController()
        show(controller, with: naviagtionType)
    }
    
    func createFavoritesViewController() -> FavoritesViewController {
        let favoritesViewController = FavoritesViewController()
        currentViewController = favoritesViewController
        return favoritesViewController
    }
}
