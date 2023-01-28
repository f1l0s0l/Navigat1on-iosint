//
//  MainCoordinator.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation
import UIKit

final class MainCoordinator: Coordinatable {
    
    // MARK: - Public Properties
    
    var navigationController: UINavigationController
    
    
    // MARK: - Life cycle
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    // MARK: - Public methods
    
    func start() -> UIViewController {
        guard isVerification else {
            self.pushLogInViewController()
            return navigationController
        }
        self.pushMainTabBarController()
        return navigationController
    }
    
    func pushMainTabBarController() {
        navigationController.viewControllers.removeAll()
        let tabBarCoordinator = TabBarCoordinator()
        navigationController.viewControllers.append(tabBarCoordinator.start())
    }
    
    func pushLogInViewController() {
        let logInCoordinator = LogInCoordinator()
        addChildCoordinator(logInCoordinator)
        navigationController.pushViewController(logInCoordinator.start(), animated: true)  //append(logInCoordinator.start())
    }
        
    func addChildCoordinator(_ coordinator: Coordinatable) {
        guard childCoordinators.contains(where: { $0 === coordinator }) else { // Что означает ! перед childCoordinators?
            return
        }
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinatable) {
        childCoordinators.removeAll(where: {$0 === coordinator})
    }
    
    
    // MARK: - Properties
    
    private var isVerification: Bool = false
    
    private(set) var childCoordinators: [Coordinatable] = []

}
