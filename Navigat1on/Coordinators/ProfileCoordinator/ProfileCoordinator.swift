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
    
    
    
    var test: ProfileViewController2?

    

    weak var parentCoordinator: Coordinatable?
    
    private var user: User
    private var navigationController: UINavigationController
    
    
    init(user: User, navController: UINavigationController) {
        self.user = user
        self.navigationController = navController
    }
    
    
    
    
    // MARK: - Public Methods

    func start() -> UIViewController {
//        let profileViewModel = ProfileViewModel(coordinator: self, user: user)
//        let profileViewController = ProfileViewController2(viewModel: profileViewModel)
        
//        let navController = UINavigationController.init(rootViewController: profileViewController)
        
//        self.navigationController = navController
        
        let profileViewController = Factory(navigationController: self.navigationController,
                                            coordinator: self,
                                            flow: .profile(user: self.user)
        )
        
        let itemForProfileVC = UITabBarItem(title: "Profile",
                                            image: UIImage(systemName: "person.crop.circle"),
                                            tag: 1
        )
        profileViewController.navigationController.tabBarItem = itemForProfileVC
//        profileViewController.navigationController.tabBarItem = itemForProfileVC
        
//        self.navigationController = profileViewController.navigationController
//        return self.navigationController
//        return profileViewController.navigationController
//        return navigationController
//        profileViewController.tabBarItem = itemForProfileVC
//        profileViewController.title = "Profile"
//        profileViewController.navigationItem.title = "Profile2"
//        self.test = profileViewController
//        return profileViewController
        self.navigationController = profileViewController.navigationController
//        return self.navigationController
        return profileViewController.navigationController
    }
    
    
    
    
    
    
    
    
    func pushToPhotosViewController() { // тут мы передадим фотгграфии из viewModel
        let photosViewController = PhotosViewController()
        self.navigationController.pushViewController(photosViewController, animated: true)
//        self.navigationController.pushViewController(photosViewController, animated: true)
    }
    
    
    
    
    
    

    func addChildCoordinator(_ coordinator: Coordinatable) {
        print()
    }
    
    func removeChildCoordinator(_ coordinator: Coordinatable) {
        print()
    }
    
    
    // MARK: - Public Properties

    var childCoordinators: [Coordinatable] = []
    
}
