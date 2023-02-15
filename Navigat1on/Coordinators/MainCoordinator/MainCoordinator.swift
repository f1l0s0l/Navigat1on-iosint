//
//  MainCoordinator.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation
import UIKit

final class MainCoordinator: Coordinatable {
    
    // MARK: - Properties

    private var navigationController: UINavigationController
    
    private var isVerification: Bool = false
    
    private var user: User = User(login: "defaultLogIn",
                                  fullName: "DefaultName",
                                  avatar: UIImage(named: "logo"),
                                  status: "DefaultStatus"
    )
    
    private(set) var childCoordinators: [Coordinatable] = []
    
    
    // MARK: - Life cycle
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    // MARK: - Public methods
    
    func start() -> UIViewController {
        guard isVerification else {
            self.pushLogInViewController()
            return self.navigationController
        }
        self.pushMainTabBarController()
        return self.navigationController
    }
    
    func pushMainTabBarController() {
        self.navigationController.navigationBar.isHidden = true
        print("Попали в Мэйн соориднатор, вызываем таб бар навигатор")
        self.navigationController.viewControllers.removeAll()
        
        let tabBarCoordinator = TabBarCoordinator(user: self.user)
        self.addChildCoordinator(tabBarCoordinator)
        
        self.navigationController.setViewControllers([tabBarCoordinator.start()], animated: true)
//        self.startTimerForBannerVC()
    }
    
    func pushLogInViewController() {
        self.navigationController.navigationBar.isHidden = true
        self.navigationController.viewControllers.removeAll()

        let logInCoordinator = LogInCoordinator()
        logInCoordinator.parentCoordinator = self
        self.addChildCoordinator(logInCoordinator)
        self.navigationController.setViewControllers([logInCoordinator.start()], animated: true)
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
    
    
    // MARK: - Methods

    private func startTimerForBannerVC() {
        Timer.scheduledTimer(
            withTimeInterval: 3,
            repeats: true
        ) { timer in
            self.pushBannerVC()
            timer.invalidate()
        }
    }
    
    private func pushBannerVC() {
        let bannerVC = BannerViewController()
        bannerVC.delegate = self
        self.navigationController.pushViewController(bannerVC, animated: true)
    }
    
}


extension MainCoordinator: MainCoordinatorDelegate {
    
    func pushMainTabBarController(user: User) {
        print("Провалились в делегат, но сам метод еще не вызвали")
        self.user = user
        self.pushMainTabBarController()
    }
}

extension MainCoordinator: BannerViewControllerDelegate {
    
    func popBannerVC() {
        self.navigationController.popViewController(animated: true)
        self.startTimerForBannerVC()
    }
}
