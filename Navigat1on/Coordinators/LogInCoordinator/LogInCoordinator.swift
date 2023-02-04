//
//  LogInCoordinator.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation
import UIKit

final class LogInCoordinator: Coordinatable {
    
    // MARK: - Public Properties

    weak var parentCoordinator: MainCoordinatorDelegate?
    
    
    // MARK: - Properties

     private(set) var childCoordinators: [Coordinatable] = []
    
    
    // MARK: - Public Methods
    
    func start() -> UIViewController {
        let logInViewController = Factory(navigationController: UINavigationController(),
                                          coordinator: self,
                                          flow: .logIn
        )
        return logInViewController.navigationController.viewControllers[0]
    }
    
    func pushMainTabBarController(user: User) {
        print("в Лог Координаторе, вызов таб бар соординатора")
        parentCoordinator?.pushMainTabBarController(user: user)
    }
    
    func addChildCoordinator(_ coordinator: Coordinatable) {
        ()
    }
    
    func removeChildCoordinator(_ coordinator: Coordinatable) {
        ()
    }
    
}
