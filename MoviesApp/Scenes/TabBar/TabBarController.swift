import UIKit

class TabBarController: UITabBarController {
    private var presenter: TabBarPresenterType
    private var navigationControllers: [UINavigationController]
    
    init(presenter: TabBarPresenterType,
         navigationControllers: [UINavigationController]) {
        self.presenter = presenter
        self.navigationControllers = navigationControllers
        super.init(nibName: nil, bundle: nil)
        self.delegate = presenter
        self.viewControllers = navigationControllers
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFirstNavigationController()
        setupTabBar()
    }
    
    override var childForStatusBarStyle: UIViewController? {
        return selectedViewController?.childForStatusBarStyle ?? selectedViewController
    }
    
    private func setFirstNavigationController() {
        guard let firstItemNavigation = navigationControllers.first else { return }
        presenter.currentNavigationController = firstItemNavigation
    }
    
    private func setupTabBar() {
        tabBar.barTintColor = .blue
        tabBar.isTranslucent = false
    }
}
