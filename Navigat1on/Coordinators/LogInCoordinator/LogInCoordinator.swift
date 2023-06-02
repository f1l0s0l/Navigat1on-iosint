//
//  LogInCoordinator.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation
import UIKit

protocol ILoginCoordinator: AnyObject {
    func switchToTabBarController(user: User)
}

final class LogInCoordinator {
    
    // MARK: - Properties
            
    private weak var parentCoordinator: IMainCoordinator?
    
    private var childCoordinators: [ICoordinator] = []
    
    
    // MARK: - Life cycle
    
    init(parentCoordinator: IMainCoordinator?) {
        self.parentCoordinator = parentCoordinator
    }
    
}



    // MARK: - ICoordinator

extension LogInCoordinator: ICoordinator {
    func start() -> UIViewController {
        let logInViewController = Factory(navigationController: UINavigationController(),
                                          coordinator: self,
                                          flow: .logIn
        )
        return logInViewController.navigationController
    }
}



    // MARK: - CoordinatableLogin

extension LogInCoordinator: ILoginCoordinator {
    func switchToTabBarController(user: User) {
        self.parentCoordinator?.switchToTabBarController(user: user)
    }
}
