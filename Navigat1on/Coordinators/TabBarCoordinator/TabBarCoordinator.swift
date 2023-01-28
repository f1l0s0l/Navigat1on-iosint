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
    
    weak var parentCoordinator: Coordinatable?
    
    
    // MARK: - Public Methods

    func start() -> UIViewController {
        let profileCoordinator = ProfileCoordinator()
        let feedCoordinator = FeedCoordinator()
        let mainTabBarController = MainTabBarViewController(viewControllers: [
            profileCoordinator.start(),
            feedCoordinator.start()
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
    
    
    // MARK: - Properties

    private(set) var childCoordinators: [Coordinatable] = []
 
}
