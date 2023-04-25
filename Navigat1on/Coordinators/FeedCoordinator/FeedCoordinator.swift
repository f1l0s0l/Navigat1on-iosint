//
//  FeedCoordinator.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation
import UIKit

final class FeedCoordinator: Coordinatable {
    
    private enum LocalizedKeys: String {
        case tabBarItemTitle = "feedTabBarItem.title"
    }

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
    
    func pushNameResidentsViewController(residents: [String]) {
        let viewModel = NameResidentsViewModel(residents: residents)
        let nameResidentsViewController = NameResidentsViewController(viewModel: viewModel)
        self.navigationController.pushViewController(nameResidentsViewController, animated: true)
    }
 
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
