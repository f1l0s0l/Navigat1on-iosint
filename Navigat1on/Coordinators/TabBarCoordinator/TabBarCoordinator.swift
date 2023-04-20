//
//  TabBarCoordinator.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 27.01.2023.
//

import Foundation
import UIKit

final class TabBarCoordinator: Coordinatable {
    
    // MARK: - Public Properties
    
//    weak var parentCoordinator: Coordinatable?
    
    // MARK: - Properties

    private var user: User
    
    private(set) var childCoordinators: [Coordinatable] = []
    
    init(user: User) {
        self.user = user
    }
    
    
    // MARK: - Public Methods

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
    
    func addChildCoordinator(_ coordinator: Coordinatable) {
        guard !self.childCoordinators.contains(where: { $0 === coordinator }) else {
            return
        }
        self.childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinatable) {
        self.childCoordinators.removeAll(where: {$0 === coordinator})
    }
 
}
