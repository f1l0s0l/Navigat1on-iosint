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
    
    // MARK: - Public Methods
    
    func start() -> UIViewController {
        let feedViewController = Factory(navigationController: UINavigationController(),
                                         coordinator: self,
                                         flow: .feed
        )
        return feedViewController.navigationController
    }
 
    func addChildCoordinator(_ coordinator: Coordinatable) {
        print()
    }
    
    func removeChildCoordinator(_ coordinator: Coordinatable) {
        print()
    }
    
    
    // MARK: - Public Properties

    private(set) var childCoordinators: [Coordinatable] = []
  
}
