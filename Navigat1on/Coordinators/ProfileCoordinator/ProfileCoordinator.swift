//
//  ProfileCoordinator.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import UIKit

protocol IProfileCoordinator: AnyObject {
    func pushToPhotosViewController(arrayPhotos: [UIImage?])
}

final class ProfileCoordinator {
    
    // MARK: - Enum
    
    private enum LocalizedKeys: String {
        case tabBarItemTitle = "profileTabBarItem.title"
    }

    
    // MARK: - Private properties

    private var user: User
    
    private var navigationController: UINavigationController
    
    private var childCoordinators: [ICoordinator] = []
    
    
    // MARK: - Init

    init(user: User, navController: UINavigationController) {
        self.user = user
        self.navigationController = navController
    }
    
}



    // MARK: - ICoordinator

extension ProfileCoordinator: ICoordinator {
    
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
}



    // MARK: - IProfileCoordinator

extension ProfileCoordinator: IProfileCoordinator {
    func pushToPhotosViewController(arrayPhotos: [UIImage?]) { // тут мы передадим фотгграфии из viewModel
        let photosViewController = PhotosViewController(arrayPhotos: arrayPhotos)
        self.navigationController.pushViewController(photosViewController, animated: true)
    }

}
