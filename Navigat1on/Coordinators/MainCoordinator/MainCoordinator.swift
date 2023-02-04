//
//  MainCoordinator.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation
import UIKit

protocol MainMainCoordinator: AnyObject {
    func testPushVC(user: User)
}

final class MainCoordinator: Coordinatable {
    
    // MARK: - Public Properties
    
//    var navigationController: UINavigationController
    
    var viewController: UIViewController
    
    
    // MARK: - Life cycle
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    
    // MARK: - Public methods
    
    func start() -> UIViewController {
        guard isVerification else {
//            self.pushLogInViewController()
            return viewController
        }
        self.pushMainTabBarController()
        return viewController
    }
    
    func pushMainTabBarController() {
        print("Попали в Мэйн соориднатор, вызываем таб бар навигатор")
//        navigationController.viewControllers.removeAll()
        
        let tabBarCoordinator = TabBarCoordinator(user: self.user)
        childCoordinators.append(tabBarCoordinator)
//        addChildCoordinator(tabBarCoordinator)
//        navigationController.setViewControllers([tabBarCoordinator.start()], animated: true) // viewControllers.append(tabBarCoordinator.start())
        
        viewController.view.addSubview(tabBarCoordinator.start().view)
        viewController.addChild(tabBarCoordinator.start())
        tabBarCoordinator.start().didMove(toParent: viewController)
    }
    
//    func pushLogInViewController() {
//        let logInCoordinator = LogInCoordinator(navigationController: navigationController)
//        logInCoordinator.parentCoordinator = self
////        childCoordinators.append(logInCoordinator)
////        addChildCoordinator(logInCoordinator)
//        navigationController.viewControllers = [logInCoordinator.start()]
////        navigationController.viewControllers.append(logInCoordinator.start())   // pushViewController(logInCoordinator.start(), animated: true)
//    }
        
    func addChildCoordinator(_ coordinator: Coordinatable) {
//        guard !childCoordinators.contains(where: { $0 === coordinator }) else { // Что означает ! перед childCoordinators?
//            return
//        }
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinatable) {
        childCoordinators.removeAll(where: {$0 === coordinator})
    }
    
    
    // MARK: - Properties
    
    private var isVerification: Bool = true
    
    private var user: User = User(login: "defaultLogIn",
                                  fullName: "DefaultName",
                                  avatar: UIImage(named: "logo"),
                                  status: "DefaultStatus"
    )
    
    var childCoordinators: [Coordinatable] = [] // (set)

}


extension MainCoordinator: MainMainCoordinator {
    
    func testPushVC(user: User) {
        print("Провалились в делегат, но сам метод еще не вызвали")
        //передакм сюда user
        self.user = user
        self.pushMainTabBarController()
    }
    
    
}
