import UIKit

protocol Coordinator {
    var currentViewController: UIViewController? { get }
    var navigationController: UINavigationController { get }

    func start(with naviagtionType: NavigationType)
}

extension Coordinator {
    func show(_ viewControllers: [UIViewController],
              animated: Bool = true,
              shouldHideTabBar: Bool = false) {

        if (viewControllers.first != nil) && shouldHideTabBar {
            viewControllers.first?.hidesBottomBarWhenPushed = true
        }

        let currentViewControllers = navigationController.viewControllers

        navigationController.setViewControllers(currentViewControllers + viewControllers, animated: animated)
    }

    func show(_ viewController: UIViewController, with navigationType: NavigationType, animated: Bool = true) {
        switch navigationType {
        case .root:
            showRoot(viewController)

        case .rootTransition(let duration):
            showRoot(with: duration, viewController)

        case .push:
            navigationController.pushViewController(viewController, animated: animated)

        case .present:
            if !(viewController.modalPresentationStyle == .custom ||
                 viewController.modalPresentationStyle == .overFullScreen) {
                
                viewController.modalPresentationStyle = .fullScreen
            }

            navigationController.present(viewController, animated: animated, completion: nil)

        case .pushHidingTabBar:
            viewController.hidesBottomBarWhenPushed = true
            navigationController.pushViewController(viewController, animated: true)
        }
    }

    private func showRoot(with duration: TimeInterval = 0.3, _ viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        
        navigationController.view.layer.add(transition, forKey: nil)
        navigationController.setViewControllers([viewController], animated: false)
        navigationController.dismiss(animated: false, completion: nil)
    }

    func dismiss(_ viewController: UIViewController, animated: Bool = true) {
        viewController.dismiss(animated: animated, completion: nil)
    }

    func back(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
}

