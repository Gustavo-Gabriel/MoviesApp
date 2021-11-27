import UIKit

struct TabBarItemFactory: TabBarItemFactoryType {
    func build(for flow: TabBarItemFlow) -> UITabBarItem {
        let item: UITabBarItem
        
        // TODO: VERIFICAR O INIT DE UITABBARITEM
        // TODO: SUSTITUIR STRINGS PO LOCALIZABLES
        switch flow {
        case .home:
            item = UITabBarItem(title: "Home", image: nil, selectedImage: nil)
        case .favorites:
            item = UITabBarItem(title: "Favoritos", image: nil, selectedImage: nil)
        }

        return item
    }
}
