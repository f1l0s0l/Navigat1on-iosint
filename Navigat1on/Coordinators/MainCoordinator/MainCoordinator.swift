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

protocol IMainCoordinator: AnyObject {
    func switchToTabBarController(user: User)
    func switchToLoginController()
}


final class MainCoordinator {
    
    // MARK: - Private properties
    
    private var rootViewController: UIViewController

    private var childCoordinators: [ICoordinator] = []
    
    
    // MARK: - Lifecycles
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    
    // MARK: - Private methods
    
    private func checkUser() -> User? {
        RealmManager.shared.userIsLogin()
    }
    
    private func makeLoginCoordinator() -> ICoordinator{
        let loginCoordionator = LogInCoordinator(parentCoordinator: self)
        return loginCoordionator
    }
    
    private func makeTabBarCoordinator(user: User) -> ICoordinator{
        let tabBarCoordinator = TabBarCoordinator(user: user)
        return tabBarCoordinator
    }
        
    private func addChildCoordinator(_ coordinator: ICoordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else {
            return
        }
        childCoordinators.append(coordinator)
    }
    
    private func removeChildCoordinator(_ coordinator: ICoordinator) {
        childCoordinators.removeAll(where: {$0 === coordinator})
    }
    
    private func setFlow(to newViewController: UIViewController) {
        self.rootViewController.addChild(newViewController)
        newViewController.view.frame = self.rootViewController.view.bounds
        self.rootViewController.view.addSubview(newViewController.view)
        newViewController.didMove(toParent: self.rootViewController)
    }
    
    private func switchFlow(to newViewController: UIViewController) {
        self.rootViewController.children[0].willMove(toParent: nil)
        self.rootViewController.children[0].navigationController?.navigationBar.isHidden = true
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



    // MARK: - ICoordinator

extension MainCoordinator: ICoordinator {
    
    func start() -> UIViewController {
        guard let user = self.checkUser() else {
            let loginCoordinator = self.makeLoginCoordinator()
            self.addChildCoordinator(loginCoordinator)
            self.setFlow(to: loginCoordinator.start())
            return self.rootViewController
        }
        let tabBarCoordinator = self.makeTabBarCoordinator(user: user)
        self.addChildCoordinator(tabBarCoordinator)
        self.setFlow(to: tabBarCoordinator.start())
        return self.rootViewController
    }
}



    // MARK: - IMainCoordinator

extension MainCoordinator: IMainCoordinator {
    
    func switchToTabBarController(user: User) {
        let tabBarCoordinator = TabBarCoordinator(user: user)
        self.addChildCoordinator(tabBarCoordinator)
        self.switchFlow(to: tabBarCoordinator.start())
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
