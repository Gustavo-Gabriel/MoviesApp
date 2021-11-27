import UIKit

typealias TabBarItemCoordinatorFactoryDelegate =
    HomeCoordinatorDelegate &
    FavoritesCoordinatorDelegate

struct TabBarItemCoordinatorFactory: TabBarItemCoordinatorFactoryType {
    let resolver: CoordinatorResolver
    var delegate: TabBarItemCoordinatorFactoryDelegate?
    let itemFactory: TabBarItemFactoryType = TabBarItemFactory()
    
    func build(for flows: [TabBarItemFlow]) -> [TabBarItemFlow: Coordinator] {
        var coordinators: [TabBarItemFlow: Coordinator] = [:]
        
        flows.forEach { flow in
            let navigationController = UINavigationController()
            navigationController.tabBarItem = itemFactory.build(for: flow)
            
            switch flow {
            case .home:
                let homeCoordinator = createHomeCoordinator(with: navigationController)
                homeCoordinator?.delegate = delegate
                coordinators[flow] = homeCoordinator
                
            case .favorites:
                let favoritesCoordinator = createFavoritesCoordinator(with: navigationController)
                favoritesCoordinator?.delegate = delegate
                coordinators[flow] = favoritesCoordinator
            }
        }

        return coordinators
    }
        
    private func createHomeCoordinator(with navigation: UINavigationController) -> HomeCoordinator? {
        resolver.navigationController = navigation
        let coordinator = resolver.resolve(route: .home) as? HomeCoordinator
        resolver.delegate = coordinator as? CoordinatorResolverDelegate
        return coordinator
    }
    
    private func createFavoritesCoordinator(with navigation: UINavigationController) -> FavoritesCoordinator? {
        resolver.navigationController = navigation
        let coordinator = resolver.resolve(route: .favorites) as? FavoritesCoordinator
        resolver.delegate = coordinator as? CoordinatorResolverDelegate
        return coordinator
    }
}
