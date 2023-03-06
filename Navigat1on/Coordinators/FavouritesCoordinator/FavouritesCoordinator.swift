//
//  FavouritesCoordinator.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 06.03.2023.
//

import Foundation
import UIKit

final class FavouritesCoordinator: Coordinatable {
    
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
        let favouritesViewController = Factory(
            navigationController: self.navigationController,
            coordinator: self,
            flow: .favourites
        )
        let itemForFavouritesVC = UITabBarItem(
            title: "Favourites",
            image: UIImage(systemName: "heart"),
            tag: 1
        )
        favouritesViewController.navigationController.tabBarItem = itemForFavouritesVC
        self.navigationController = favouritesViewController.navigationController
        
        return self.navigationController
    }
 
    func addChildCoordinator(_ coordinator: Coordinatable) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else {
            return
        }
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinatable) {
        ()
    }
    
}
