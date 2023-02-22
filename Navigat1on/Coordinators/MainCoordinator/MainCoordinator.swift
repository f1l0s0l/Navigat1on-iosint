//
//  MainCoordinator.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation
import UIKit
import FirebaseAuth

final class MainCoordinator: Coordinatable {
    
    // MARK: - Properties

    private var navigationController: UINavigationController

    private(set) var childCoordinators: [Coordinatable] = []
    
    
    // MARK: - Life cycle
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
//        start()
    }
    
    
    // MARK: - Public methods
    
    func start() -> UIViewController {
        
        let checkerService = CheckerService()
        let loginInspector = LoginInspector(checkerServise: checkerService)
        loginInspector.addStateDidChangeListener { [weak self] user in
            guard let user = user else {
                self?.pushLogInViewController(loginInspector: loginInspector)
                return
            }
            self?.pushMainTabBarController(user: user)
        }
        return self.navigationController
    }
    
    func pushMainTabBarController(user: User) {
        self.navigationController.navigationBar.isHidden = true
        print("Попали в Мэйн соориднатор, вызываем таб бар навигатор")
        self.navigationController.viewControllers.removeAll()
        
        let tabBarCoordinator = TabBarCoordinator(user: user)
        self.addChildCoordinator(tabBarCoordinator)
        
        self.navigationController.setViewControllers([tabBarCoordinator.start()], animated: true)
//        self.startTimerForBannerVC()
    }
    
    func pushLogInViewController(loginInspector: LoginInspector) {
        self.navigationController.navigationBar.isHidden = true
        self.navigationController.viewControllers.removeAll()

        let logInCoordinator = LogInCoordinator()
        logInCoordinator.logInInspectorDelegate = loginInspector
//        logInCoordinator.parentCoordinator = self
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



    // MARK: - extrension BannerViewControllerDelegate

extension MainCoordinator: BannerViewControllerDelegate {
    
    func popBannerVC() {
        self.navigationController.popViewController(animated: true)
        self.startTimerForBannerVC()
    }
}
