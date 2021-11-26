import UIKit

class ParentViewController: UIViewController {

    let childViewController: UIViewController

    init(child: UIViewController) {
        self.childViewController = child
        super.init(nibName: nil, bundle: nil)
        load()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func load() {
        addChild(childViewController)
        view.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
    }

    override var childForStatusBarStyle: UIViewController? {
        return childViewController.childForStatusBarStyle ?? childViewController
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

