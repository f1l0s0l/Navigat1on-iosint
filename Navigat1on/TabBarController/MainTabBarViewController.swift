//
//  MainTabBarViewController.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation
import UIKit


 final class MainTabBarViewController: UITabBarController {
     
     private var navControllers: [UIViewController] = []
     
     init(viewControllers: [UIViewController]) {
         super.init(nibName: nil, bundle: nil)
         self.viewControllers = viewControllers
         setupView()
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }


    // MARK: - Methods
    
    private func setupView() {
        UITabBar.appearance().tintColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        UITabBar.appearance().backgroundColor = .white

        UINavigationBar.appearance().tintColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        UINavigationBar.appearance().backgroundColor = .systemGray6
    }
    
}
