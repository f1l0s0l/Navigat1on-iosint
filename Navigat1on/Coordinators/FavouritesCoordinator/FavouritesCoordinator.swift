//
//  FavouritesCoordinator.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 06.03.2023.
//

import UIKit

protocol IFavouritesCoordinator: AnyObject {
    
}

final class FavouritesCoordinator {
    
    // MARK: - Enum
    
    private enum LocalizedKeys: String {
        case tabBarItemTitle = "favouriteTabBarItem.title"
    }
    
    
    // MARK: - Private properties

    private var navigationController: UINavigationController
    
    private var childCoordinators: [ICoordinator] = []
    
    
    // MARK: - Init
    
    init(navController: UINavigationController) {
        self.navigationController = navController
    }
    
}



    // MARK: - ICoordinator

extension FavouritesCoordinator: ICoordinator {
    
    func start() -> UIViewController {
        let favouritesViewController = Factory(
            navigationController: self.navigationController,
            coordinator: self,
            flow: .favourites
        )
        let itemForFavouritesVC = UITabBarItem(
            title: String(localized: String.LocalizationValue(LocalizedKeys.tabBarItemTitle.rawValue)),
            image: UIImage(systemName: "heart"),
            tag: 1
        )
        favouritesViewController.navigationController.tabBarItem = itemForFavouritesVC
        self.navigationController = favouritesViewController.navigationController
        
        return self.navigationController
    }
}



extension FavouritesCoordinator: IFavouritesCoordinator {
    
}
