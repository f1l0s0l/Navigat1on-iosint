//
//  test.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 03.02.2023.
//

import Foundation
import UIKit

class TestViewController: UIViewController {
    
    
    private lazy var testButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(testt), for: .touchUpInside)
        return button
    }()
    
    @objc private func testt() {
        let testTabBarController = TestTabBarController()
        self.navigationController?.setViewControllers([testTabBarController], animated: true)
//        self.navigationController?.pushViewController(testTabBarController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.title = "Основной ViewController"
        self.view.backgroundColor = .green
        self.view.addSubview(testButton)
        self.setupConst()
    }
    
    
    
    private func setupConst() {
        NSLayoutConstraint.activate([
            testButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            testButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            testButton.heightAnchor.constraint(equalToConstant: 100),
            testButton.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    
}

class TestTabBarController: UITabBarController {
    
    // MARK: - Properties
   
       var test2: UINavigationController!
       var test3: UINavigationController!
   
       // MARK: - Life cycle
   
       override func viewDidLoad() {
           super.viewDidLoad()
           setupUI()
   
       }
   
       // MARK: - Methods
   
       private func setupUI() {
           let test22 = TestViewController2()
           let test33 = TestViewController3()
           //У нас в проекте NAvigation объявление LogInViewController() происходит не в AppleDelegate/SceneDelegate
           //В AppleDalegate/SceneDelegate назначается рутовым котроллером TabBarController()
           //Так что делегат я тут присвоил
         
   
           test2 = UINavigationController.init(rootViewController: test22 )
           test3 = UINavigationController.init(rootViewController: test33)
//           logInTabNavigationController.navigationBar.isHidden = true
   
           self.viewControllers = [test2, test3]
   
           let item1 = UITabBarItem(title: "Feed",
                                    image: UIImage(systemName: "square.stack.3d.down.right"), tag: 0)
   
           let item2 = UITabBarItem(title: "Profile",
                                    image: UIImage(systemName: "person.crop.circle"), tag: 1)
   
           test2.tabBarItem = item1
           test3.tabBarItem = item2
   
           UITabBar.appearance().tintColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
           UITabBar.appearance().backgroundColor = .white
   
           UINavigationBar.appearance().tintColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
           UINavigationBar.appearance().backgroundColor = .systemGray6
   
       }
   
    
    
}



class TestViewController2: UIViewController {
    
    
    private lazy var testButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
//        button.addTarget(self, action: #selector(testt), for: .touchUpInside)
        return button
    }()
    
//    @objc private func testt() {
//        let testTabBarController = TestTabBarController()
//        self.navigationController?.pushViewController(testTabBarController, animated: true)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Первйы ViewController"
        self.view.backgroundColor = .yellow
        self.view.addSubview(testButton)
        self.setupConst()
    }
    
    
    
    private func setupConst() {
        NSLayoutConstraint.activate([
            testButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            testButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            testButton.heightAnchor.constraint(equalToConstant: 100),
            testButton.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    
}

class TestViewController3: UIViewController {
    
    
    private lazy var testButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
//        button.addTarget(self, action: #selector(testt), for: .touchUpInside)
        return button
    }()
    
//    @objc private func testt() {
//        let testTabBarController = TestTabBarController()
//        self.navigationController?.pushViewController(testTabBarController, animated: true)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Второй ViewController"
        self.view.backgroundColor = .red
        self.view.addSubview(testButton)
        self.setupConst()
    }
    
    
    
    private func setupConst() {
        NSLayoutConstraint.activate([
            testButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            testButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            testButton.heightAnchor.constraint(equalToConstant: 100),
            testButton.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    
}
