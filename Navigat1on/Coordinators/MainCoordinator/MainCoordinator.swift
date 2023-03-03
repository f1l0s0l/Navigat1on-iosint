//
//  MainCoordinator.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation
import UIKit
//import FirebaseAuth
import RealmSwift

protocol CoordinatableMain: AnyObject {
    func switchToTabBarController(user: User)
    func switchToLoginController()
}


final class MainCoordinator: Coordinatable {
    
    // MARK: - Properties
    
    private var currentUser: User?

    private var rootViewController: UIViewController

    private(set) var childCoordinators: [Coordinatable] = []
    
    
    // MARK: - Life cycle
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    
    // MARK: - Public methods
    
    func start() -> UIViewController {
        let loadingViewController = LoadingViewController()
        self.rootViewController.addChild(loadingViewController)
        loadingViewController.view.frame = self.rootViewController.view.bounds
        self.rootViewController.view.addSubview(loadingViewController.view)
        loadingViewController.didMove(toParent: self.rootViewController)
        
        self.checkUser()
        
        return self.rootViewController
    }
    
    private func checkUser() {
        guard let user = RealmManager.shared.userIsLogin() else {
            self.showLoginController()
            return
        }
        self.showTabBarController(user: user)
    }
    
    private func showLoginController() {
        let loginCoordinator = LogInCoordinator(parentCoordinator: self)
        self.addChildCoordinator(loginCoordinator)
        let loginVC = loginCoordinator.start()
        self.makeShow(to: loginVC)
    }
    
    private func showTabBarController(user: User) {
        let tabBarCoordinator = TabBarCoordinator(user: user)
        self.addChildCoordinator(tabBarCoordinator)
        let tabBarController = tabBarCoordinator.start()
        self.makeSwitch(to: tabBarController)
        
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
//
//    private func startTimerForBannerVC() {
//        Timer.scheduledTimer(
//            withTimeInterval: 3,
//            repeats: true
//        ) { timer in
//            self.pushBannerVC()
//            timer.invalidate()
//        }
//    }
//
//    private func pushBannerVC() {
//        let bannerVC = BannerViewController()
//        bannerVC.delegate = self
//        self.navigationController.pushViewController(bannerVC, animated: true)
//    }
    
    private func makeShow(to newViewController: UIViewController) {
        self.rootViewController.addChild(newViewController)
        newViewController.view.frame = self.rootViewController.view.bounds
        self.rootViewController.view.addSubview(newViewController.view)
        newViewController.didMove(toParent: self.rootViewController)
        
        self.rootViewController.children[0].willMove(toParent: nil)
        self.rootViewController.children[0].view.removeFromSuperview()
        self.rootViewController.children[0].removeFromParent()
        
    }
    
    private func makeSwitch(to newViewController: UIViewController) {
        self.rootViewController.children[0].willMove(toParent: nil)
        self.rootViewController.addChild(newViewController)
        newViewController.view.frame = self.rootViewController.view.bounds
        
        self.rootViewController.transition(
            from: self.rootViewController.children[0],
            to: newViewController,
            duration: 0.6,
            options: [.transitionCrossDissolve, .curveEaseOut],
            animations: {}
        ) { _ in
            self.rootViewController.children[0].removeFromParent()
            newViewController.didMove(toParent: self.rootViewController)
            }
        
    }
    
}



    // MARK: - CoordinatableMain

extension MainCoordinator: CoordinatableMain {
    func switchToTabBarController(user: User) {
        let tabBarCoordinator = TabBarCoordinator(user: user)
        self.addChildCoordinator(tabBarCoordinator)
        let tabBarController = tabBarCoordinator.start()
        self.makeSwitch(to: tabBarController)
        self.removeChildCoordinator(self.childCoordinators[0])
    }
    
    func switchToLoginController() {
        // пока нет необходимости, но так монжно попадать обратно в flow авторизации
    }
    
    
}


    // MARK: - extrension BannerViewControllerDelegate

//extension MainCoordinator: BannerViewControllerDelegate {
//
//    func popBannerVC() {
//        self.navigationController.popViewController(animated: true)
//        self.startTimerForBannerVC()
//    }
//}
