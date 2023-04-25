//
//  ProfileCoordinator.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation
import UIKit

final class ProfileCoordinator: Coordinatable {
    
    private enum LocalizedKeys: String {
        case tabBarItemTitle = "profileTabBarItem.title"
    }
    
    // MARK: - Public Properties
    
//    weak var parentCoordinator: Coordinatable?
    
    
    // MARK: - Properties

    private var user: User
    
    private var navigationController: UINavigationController
    
    private(set) var childCoordinators: [Coordinatable] = []
    
    
    // MARK: - Life Cycle

    init(user: User, navController: UINavigationController) {
        self.user = user
        self.navigationController = navController
    }
    
    
    // MARK: - Public Methods

    func start() -> UIViewController {
        let profileViewController = Factory(navigationController: self.navigationController,
                                            coordinator: self,
                                            flow: .profile(user: self.user)
        )
        let itemForProfileVC = UITabBarItem(
            title: String(localized: String.LocalizationValue(LocalizedKeys.tabBarItemTitle.rawValue)),
            image: UIImage(systemName: "person.crop.circle"),
            tag: 2
        )
        profileViewController.navigationController.tabBarItem = itemForProfileVC
        self.navigationController = profileViewController.navigationController
        
        return profileViewController.navigationController
    }

    func pushToPhotosViewController(arrayPhotos: [UIImage?]) { // тут мы передадим фотгграфии из viewModel
        let photosViewController = PhotosViewController(arrayPhotos: arrayPhotos)
        self.navigationController.pushViewController(photosViewController, animated: true)
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
