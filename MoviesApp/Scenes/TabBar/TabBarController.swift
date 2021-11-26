import UIKit

class TabBarController: UITableViewController {
    private var presenter: TabBarPresenterType
    private var navigationControllers: [UINavigationController]
    
    init(presenter: TabBarPresenterType,
         navigationControllers: [UINavigationController]) {
        self.presenter = presenter
        self.navigationControllers = navigationControllers
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
