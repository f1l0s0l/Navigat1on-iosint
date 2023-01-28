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

    weak var parentCoordinator: Coordinatable?
    
    // MARK: - Public Methods
    
    func start() -> UIViewController {
        let logInViewController = Factory(navigationController: UINavigationController(),
                                          coordinator: self,
                                          flow: .logIn
        )
        return logInViewController.navigationController
    }
    
    func pushMainTabBarController() {
        (parentCoordinator as? MainCoordinator)?.pushMainTabBarController()
    }
    
    func addChildCoordinator(_ coordinator: Coordinatable) {
        print()
    }
    
    func removeChildCoordinator(_ coordinator: Coordinatable) {
        print()
    }

    
    // MARK: - Properties

    private(set) var childCoordinators: [Coordinatable] = []
    
}
