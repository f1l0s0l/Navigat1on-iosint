//
//  MainTabBarViewController.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation
import UIKit


 final class MainTabBarViewController: UITabBarController {
     
     init(viewControllers: [UIViewController]) {
         super.init(nibName: nil, bundle: nil)
         self.viewControllers = viewControllers
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
    
    
    
    
    
    
    
    
    
    
    //MARK: - Properties
    
//    private let logInViewController = Factory(navigationController: UINavigationController(), flow: .logIn)
//    private let feedViewController = Factory(navigationController: UINavigationController(), flow: .feed)
//    private let profileViewController = Factory(navigationController: UINavigationController(), flow: .profile)
    
    
    // MARK: - Life cycle
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupView()
//        setupNavigationControllers()
//        setControllers()
//    }
    
    
    // MARK: - Methods
    
//    private func setupView() {
//        UITabBar.appearance().tintColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
//        UITabBar.appearance().backgroundColor = .white
//
//        UINavigationBar.appearance().tintColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
//        UINavigationBar.appearance().backgroundColor = .systemGray6
//    }
//
//    private func setupNavigationControllers() {
//        let itemForFeedVC = UITabBarItem(title: "Feed",
//                                         image: UIImage(systemName: "square.stack.3d.down.right"),
//                                         tag: 0
//        )
//        let itemForProfileVC = UITabBarItem(title: "Profile",
//                                            image: UIImage(systemName: "person.crop.circle"),
//                                            tag: 1
//        )
//
//        feedViewController.navigationController.tabBarItem = itemForFeedVC
//        profileViewController.navigationController.tabBarItem = itemForProfileVC
//
//    }
//
//    private func setControllers() {
//        self.viewControllers = [
////            logInViewController.navigationController,
//            feedViewController.navigationController,
//            profileViewController.navigationController
//        ]
//    }
    
}
