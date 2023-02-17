//
//  Factory.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import UIKit

final class Factory {
    enum Flow {
        case logIn
        case feed
        case profile(user: User)
        case starWars
    }
    
    let navigationController: UINavigationController
    
    let coordinator: Coordinatable
    
    private let flow: Flow
    
    init(navigationController: UINavigationController, coordinator: Coordinatable, flow: Flow) {
        self.navigationController = navigationController
        self.flow = flow
        self.coordinator = coordinator
        self.initModule()
    }
    
    private func initModule() {
        switch flow {
        case .logIn:
            let viewModel = LogInViewModel(coordinator: self.coordinator)
            let controller = LogInViewController2(viewModel: viewModel)
            navigationController.setViewControllers([controller], animated: true)

        case .feed:
            let viewModel = FeedViewModel(coordinator: self.coordinator)
            let controller = FeedViewController2(viewModel: viewModel)
//            let feedModel = FeedModel()
//            let controller = FeedViewController(feedModel: feedModel)
            navigationController.setViewControllers([controller], animated: true)
            
        case let .profile(user):
            let viewModel = ProfileViewModel(coordinator: self.coordinator, user: user)
            let controller = ProfileViewController(viewModel: viewModel)
            navigationController.setViewControllers([controller], animated: true)
            
        case .starWars:
            let viewModel = StarWarsViewModel(coordinator: self.coordinator)
            let controller = StarWarsViewController(viewModel: viewModel)
            navigationController.setViewControllers([controller], animated: true)
        }
        
        
        
//        switch flow {
//        case .logIn:
//            let coordinator = LogInCoordinator()
//            let viewModel = LogInViewModel(coordinator: coordinator)
//            let controller = LogInViewController2(viewModel: viewModel)
//            navigationController.setViewControllers([controller], animated: true)
//
//        case .feed:
//            let coordinator = FeedCoordinator()
//            let viewModel = FeedViewModel()
//            let controller = FeedViewController2(viewModel: viewModel, coordinator: coordinator)
//            navigationController.setViewControllers([controller], animated: true)
//
//        case .profile:
//            let coordinator = ProfileCoordinator()
//            let viewModel = ProfileViewModel(coordinator: coordinator)
//            let controller = ProfileViewController(viewModel: viewModel)
//            navigationController.setViewControllers([controller], animated: true)
//        }
    }
    
   
    
    
}

