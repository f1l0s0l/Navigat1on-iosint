//
//  LogInCoordinator.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation
import UIKit

//protocol LogInViewControllerDelegate: AnyObject {
//    func checkCredentials(logIn: String?, pswrd: String?, completion: @escaping (CheckerError?) -> Void)
//    func signUp(logIn: String?, pswrd: String?, completion: @escaping (CheckerError?) -> Void)
//    func addStateDidChangeListener(completion: @escaping (User?) -> Void)
//}


protocol CoordinatableLogin: AnyObject {
    func switchToTabBarController(user: User)
}

final class LogInCoordinator: Coordinatable {

    // MARK: - Public Properties
    
//    weak var logInInspectorDelegate: LogInViewControllerDelegate?
    
    
    // MARK: - Properties
    
//    private var rootViewController: UIViewController
    
    private weak var parentCoordinator: CoordinatableMain?
    
    private(set) var childCoordinators: [Coordinatable] = []
    
    
    // MARK: - Life cycle
    
    init(parentCoordinator: CoordinatableMain?) {
        self.parentCoordinator = parentCoordinator
    }
    
    
    // MARK: - Public Methods
    
    func start() -> UIViewController {
        let logInViewController = Factory(navigationController: UINavigationController(),
                                          coordinator: self,
                                          flow: .logIn
        )
        return logInViewController.navigationController
        
//        self.rootViewController.children[0].willMove(toParent: nil)
//        self.rootViewController.addChild(logInViewController.navigationController)
//        logInViewController.navigationController.view.frame = self.rootViewController.view.bounds
//
//        self.rootViewController.transition(
//            from: self.rootViewController.children[0],
//            to: logInViewController.navigationController,
//            duration: 0.6,
//            options: [.transitionCrossDissolve, .curveEaseOut],
//            animations: {}) { _ in
//                self.rootViewController.children[0].removeFromParent()
//                logInViewController.navigationController.didMove(toParent: self.rootViewController)
//            }
//
    }
    
    func addChildCoordinator(_ coordinator: Coordinatable) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else {
            return
        }
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinatable) {
        childCoordinators.removeAll(where: {$0 === coordinator})
    }
    
}



extension LogInCoordinator: CoordinatableLogin {
    func switchToTabBarController(user: User) {
        self.parentCoordinator?.switchToTabBarController(user: user)
    }
}
