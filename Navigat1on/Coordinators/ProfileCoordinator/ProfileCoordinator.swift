//
//  ProfileCoordinator.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation
import UIKit

final class ProfileCoordinator: Coordinatable {
    
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
        let itemForProfileVC = UITabBarItem(title: "Profile",
                                            image: UIImage(systemName: "person.crop.circle"),
                                            tag: 1
        )
        profileViewController.navigationController.tabBarItem = itemForProfileVC
        self.navigationController = profileViewController.navigationController
        
        return profileViewController.navigationController
    }

    func pushToPhotosViewController(arrayPhotos: [UIImage?]) { // тут мы передадим фотгграфии из viewModel
        let photosViewController = PhotosViewController(arrayPhotos: arrayPhotos)
        photosViewController.title = "Photo Gallery"
        self.navigationController.pushViewController(photosViewController, animated: true)
    }

    func addChildCoordinator(_ coordinator: Coordinatable) {
        ()
    }
    
    func removeChildCoordinator(_ coordinator: Coordinatable) {
        ()
    }
    
}
