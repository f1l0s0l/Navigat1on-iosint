//
//  FeedCoordinator.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation
import UIKit

final class FeedCoordinator: Coordinatable {
    
    // MARK: - Public Properties

    weak var parentCoordinator: Coordinatable?
    
    
    private var navigationController: UINavigationController
    
    
    init(navController: UINavigationController) {
        self.navigationController = navController
    }
    
    
    // MARK: - Public Methods
    
    func start() -> UIViewController {
        let feedViewController = Factory(navigationController: self.navigationController,
                                         coordinator: self,
                                         flow: .feed
        )
        let itemForProfileVCc = UITabBarItem(title: "Feed",
                                            image: UIImage(systemName: "square.stack.3d.down.right"),
                                            tag: 1
        )
        feedViewController.navigationController.tabBarItem = itemForProfileVCc
        
        self.navigationController = feedViewController.navigationController
        return self.navigationController
//        return feedViewController.navigationController
    }
 
    func addChildCoordinator(_ coordinator: Coordinatable) {
        print()
    }
    
    func removeChildCoordinator(_ coordinator: Coordinatable) {
        print()
    }
    
    
    // MARK: - Public Properties

    var childCoordinators: [Coordinatable] = []
  
}
