import UIKit

final class TabBarPresenter: NSObject, TabBarPresenterType {
    weak var delegate: TabBarPresenterDelegate?
    var tabFlows: [TabBarItemFlow]
    var currentNavigationController: UINavigationController
    
    init(tabFlows: [TabBarItemFlow],
         currentNavigationController: UINavigationController) {
        self.tabFlows = tabFlows
        self.currentNavigationController = currentNavigationController
    }
}
