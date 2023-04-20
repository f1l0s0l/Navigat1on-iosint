//
//  MapCoordinator.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 20.04.2023.
//

import Foundation
import UIKit

final class MapCoordinator: Coordinatable {

    // MARK: - Public Properties

//    weak var parentCoordinator: Coordinatable?
    
    // MARK: - Properties

    private var navigationController: UINavigationController
    
    private(set) var childCoordinators: [Coordinatable] = []
    
    // MARK: - Life Cycle
    
    init(navController: UINavigationController) {
        self.navigationController = navController
    }
    
    
    // MARK: - Public Methods
    
    func start() -> UIViewController {
        let mapViewController = Factory(
            navigationController: self.navigationController,
            coordinator: self,
            flow: .map
        )
        let itemForMapVC = UITabBarItem(
            title: "Map",
            image: UIImage(systemName: "map"),
            tag: 3
        )
        mapViewController.navigationController.tabBarItem = itemForMapVC
        self.navigationController = mapViewController.navigationController
        
        
//        let feedViewController = Factory(navigationController: self.navigationController,
//                                         coordinator: self,
//                                         flow: .feed
//        )
//        let itemForProfileVCc = UITabBarItem(title: "Feed",
//                                            image: UIImage(systemName: "square.stack.3d.down.right"),
//                                            tag: 0
//        )
//        feedViewController.navigationController.tabBarItem = itemForProfileVCc
//        self.navigationController = feedViewController.navigationController
        
        return self.navigationController
    }
    
//    func pushNameResidentsViewController(residents: [String]) {
//        let viewModel = NameResidentsViewModel(residents: residents)
//        let nameResidentsViewController = NameResidentsViewController(viewModel: viewModel)
//        self.navigationController.pushViewController(nameResidentsViewController, animated: true)
//    }
 
    func addChildCoordinator(_ coordinator: Coordinatable) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else {
            return
        }
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinatable) {
        childCoordinators.removeAll(where: {$0 === coordinator})
    }
    
}
