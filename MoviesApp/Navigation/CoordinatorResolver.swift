import UIKit

typealias CoordinatorResolverDelegate = HomeCoordinatorDelegate &
                                        FavoritesCoordinatorDelegate

class CoordinatorResolver {
    var navigationController: UINavigationController
    weak var delegate: CoordinatorResolverDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func resolve(route: Route) -> Coordinator {
        var coordinator: Coordinator
        
        switch route {
        case .home:
            coordinator = createHomeCoordinator()
        case .favorites:
            coordinator = createFavoritesCoordinator()
        }
        
        return coordinator
    }

    private func createHomeCoordinator() -> Coordinator {
        let coordinator = HomeCoordinator(navigationController: navigationController)
        return coordinator
    }

    private func createFavoritesCoordinator() -> Coordinator {
        let coordinator = FavoritesCoordinator(navigationController: navigationController)
        return coordinator
    }
}
