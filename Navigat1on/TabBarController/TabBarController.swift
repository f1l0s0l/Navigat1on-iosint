//
//  TabBarController.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 19.01.2023.
//

//import UIKit
//
//class TabBarController: UITabBarController {
//    
//    // MARK: - Properties
//    
//    var feedTabNavigationController: UINavigationController!
//    var logInTabNavigationController: UINavigationController!
//    
//    // MARK: - Life cycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//
//    }
//    
//    // MARK: - Methods
//    
//    private func setupUI() {
//        let feedModel = FeedModel()
//        let feedViewController = FeedViewController(feedModel: feedModel)
//        
//        let logInViewController = LogInViewController()
//        //У нас в проекте NAvigation объявление LogInViewController() происходит не в AppleDelegate/SceneDelegate
//        //В AppleDalegate/SceneDelegate назначается рутовым котроллером TabBarController()
//        //Так что делегат я тут присвоил
//        logInViewController.loginDelegate = MyLoginFactory().makeLoginInspector()
//        
//        feedTabNavigationController = UINavigationController.init(rootViewController: feedViewController )
//        logInTabNavigationController = UINavigationController.init(rootViewController: logInViewController)
//        logInTabNavigationController.navigationBar.isHidden = true
//                
//        self.viewControllers = [feedTabNavigationController, logInTabNavigationController]
//        
//        let item1 = UITabBarItem(title: "Feed",
//                                 image: UIImage(systemName: "square.stack.3d.down.right"), tag: 0)
//        
//        let item2 = UITabBarItem(title: "Profile",
//                                 image: UIImage(systemName: "person.crop.circle"), tag: 1)
//        
//        feedTabNavigationController.tabBarItem = item1
//        logInTabNavigationController.tabBarItem = item2
//        
//        UITabBar.appearance().tintColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
//        UITabBar.appearance().backgroundColor = .white
//        
//        UINavigationBar.appearance().tintColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
//        UINavigationBar.appearance().backgroundColor = .systemGray6
//     
//    }
//    
//}
