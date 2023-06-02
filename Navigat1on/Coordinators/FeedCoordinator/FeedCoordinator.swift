//
//  FeedCoordinator.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import UIKit

protocol IFeedCoordinator: AnyObject {
    func pushNameResidentsViewController(residents: [String])
}

final class FeedCoordinator {
    
    // MARK: - Enum
    
    private enum LocalizedKeys: String {
        case tabBarItemTitle = "feedTabBarItem.title"
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

extension FeedCoordinator: ICoordinator {
    func start() -> UIViewController {
        let feedViewController = Factory(navigationController: self.navigationController,
                                         coordinator: self,
                                         flow: .feed
        )
        let itemForProfileVCc = UITabBarItem(
            title: String(localized: String.LocalizationValue(LocalizedKeys.tabBarItemTitle.rawValue)),
            image: UIImage(systemName: "square.stack.3d.down.right"),
            tag: 0
        )
        feedViewController.navigationController.tabBarItem = itemForProfileVCc
        self.navigationController = feedViewController.navigationController
        
        return self.navigationController
    }
}



    // MARK: - IFeedCoordinator

extension FeedCoordinator: IFeedCoordinator {
    func pushNameResidentsViewController(residents: [String]) {
        let viewModel = NameResidentsViewModel(residents: residents)
        let nameResidentsViewController = NameResidentsViewController(viewModel: viewModel)
        self.navigationController.pushViewController(nameResidentsViewController, animated: true)
    }
}
