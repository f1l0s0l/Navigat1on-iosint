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
        let profileCoordinator = ProfileCoordinator(user: self.user, navController: UINavigationController())
        let feedCoordinator = FeedCoordinator(navController: UINavigationController())
        let mainTabBarController = MainTabBarViewController(viewControllers: [
            feedCoordinator.start(),
            profileCoordinator.start()
        ])
        
        addChildCoordinator(profileCoordinator)
        addChildCoordinator(feedCoordinator)
        
        return mainTabBarController

    }
    
    func addChildCoordinator(_ coordinator: Coordinatable) {
        ()
    }
    
    func removeChildCoordinator(_ coordinator: Coordinatable) {
        ()
    }
 
}
