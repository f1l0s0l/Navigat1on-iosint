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
        case favourites
        case map
    }
    
    let navigationController: UINavigationController
    
    let coordinator: ICoordinator
    
    private let flow: Flow
    
    //
//    weak var delegate: LogInViewControllerDelegate?
    //
    
    init(navigationController: UINavigationController, coordinator: ICoordinator, flow: Flow) {
        self.navigationController = navigationController
        self.flow = flow
        self.coordinator = coordinator
        self.initModule()
    }
    
    private func initModule() {
        switch flow {
        case .logIn:
            let checkerPassword = CheckerPassword()
            let localAuthorizationService = LocalAuthorizationService()
            let viewModel = LogInViewModel(
                coordinator: self.coordinator as! ILoginCoordinator,
                checkerPassword: checkerPassword,
                localAuthorizationService: localAuthorizationService
            )
            let controller = LogInViewController2(viewModel: viewModel)
            navigationController.setViewControllers([controller], animated: true)

        case .feed:
            let viewModel = FeedViewModel(coordinator: self.coordinator as? IFeedCoordinator)
            let controller = FeedViewController2(viewModel: viewModel)
            navigationController.setViewControllers([controller], animated: true)
            
        case .favourites:
            let viewModel = FavouritesViewModel(coordinator: self.coordinator as? IFavouritesCoordinator)
            let controller = FavouritesViewController(viewModel: viewModel)
            navigationController.setViewControllers([controller], animated: true)
            
            
        case let .profile(user):
            let viewModel = ProfileViewModel(coordinator: self.coordinator as? IProfileCoordinator, user: user)
            let controller = ProfileViewController(viewModel: viewModel)
            navigationController.setViewControllers([controller], animated: true)
            
        case .map:
//            let viewModel = MapViewModel(coordinator: self.coordinator)
            let viewController = MapViewController(coordinator: self.coordinator as? IMapCoordinator)
            navigationController.setViewControllers([viewController], animated: true)
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

