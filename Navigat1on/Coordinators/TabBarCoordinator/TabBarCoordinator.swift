//
//  TabBarCoordinator.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 27.01.2023.
//

import UIKit

final class TabBarCoordinator {
    
    // MARK: - Properties

    private var user: User
    
    private var childCoordinators: [ICoordinator] = []
    
    
    // MARK: - Init
    
    init(user: User) {
        self.user = user
    }
    
    
    // MARK: - Private methods
    
    private func addChildCoordinator(_ coordinator: ICoordinator) {
        guard !self.childCoordinators.contains(where: { $0 === coordinator }) else {
            return
        }
        self.childCoordinators.append(coordinator)
    }
    
    private func removeChildCoordinator(_ coordinator: ICoordinator) {
        self.childCoordinators.removeAll(where: {$0 === coordinator})
    }
 
}



    // MARK: - ICoordinator

extension TabBarCoordinator: ICoordinator {
    func start() -> UIViewController {
        let feedCoordinator = FeedCoordinator(navController: UINavigationController())
        let favouritesCoordinator = FavouritesCoordinator(navController: UINavigationController())
        let profileCoordinator = ProfileCoordinator(user: self.user, navController: UINavigationController())
        let mapCoordinator = MapCoordinator(navController: UINavigationController())
        
        let mainTabBarController = MainTabBarViewController(viewControllers: [
            feedCoordinator.start(),
            mapCoordinator.start(),
            favouritesCoordinator.start(),
            profileCoordinator.start()
        ])
        
        self.addChildCoordinator(feedCoordinator)
        self.addChildCoordinator(mapCoordinator)
        self.addChildCoordinator(favouritesCoordinator)
        self.addChildCoordinator(profileCoordinator)
        
        return mainTabBarController
    }
}
