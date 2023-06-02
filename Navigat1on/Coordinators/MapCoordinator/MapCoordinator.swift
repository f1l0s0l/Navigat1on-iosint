//
//  MapCoordinator.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 20.04.2023.
//

import UIKit

protocol IMapCoordinator: AnyObject {
    
}

final class MapCoordinator {
    
    // MARK: - Enum

    private enum LocalizedKeys: String {
        case tabBarItemTitle = "mapTabBarItem.title"
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

extension MapCoordinator: ICoordinator {
    
    func start() -> UIViewController {
        let mapViewController = Factory(
            navigationController: self.navigationController,
            coordinator: self,
            flow: .map
        )
        let itemForMapVC = UITabBarItem(
            title: String(localized: String.LocalizationValue(LocalizedKeys.tabBarItemTitle.rawValue)),
            image: UIImage(systemName: "map"),
            tag: 3
        )
        mapViewController.navigationController.tabBarItem = itemForMapVC
        self.navigationController = mapViewController.navigationController

        return self.navigationController
    }
}



extension MapCoordinator: IMapCoordinator {
    
}
