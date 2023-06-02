//
//  ProfileViewModel.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation
import UserNotifications
import UIKit

protocol IProfileViewModel {
    var dataPosts: [PostView] { get }
    var arrayPhotos: [UIImage?] { get }
    var user: User { get }
    var stateChanged: ((ProfileViewModel.State) -> Void)? { get set }
    
    func didTapPhotos(_ object: UNUserNotificationCenterDelegate)
    func registeForLatestUpdatesIfPossible(_ object: UNUserNotificationCenterDelegate)
}

final class ProfileViewModel {
    
    // MARK: - Enum
    
    enum State {
        case setDelegateNotificationCenter
    }
    
    
    // MARK: - Public properties
    
    var dataPosts = DataPosts.dataPosts
    var arrayPhotos = Photos.photos
    var user: User
    var stateChanged: ((State) -> Void)?
    
    
    // MARK: - Private properties
    
    private let coordinator: Coordinatable
    
    private let localNotificationService: ILocalNotificationService
    
    private var state: State = .setDelegateNotificationCenter {
        didSet {
            self.stateChanged?(self.state)
        }
    }
    
    
    // MARK: - Life Cycle
    
    init(coordinator: Coordinatable, user: User, localNotificationService: ILocalNotificationService) {
        self.coordinator = coordinator
        self.user = user
        self.localNotificationService = localNotificationService
    }
    
}



    // MARK: - IProfileViewModel

extension ProfileViewModel: IProfileViewModel {
    
    func didTapPhotos(_ object: UNUserNotificationCenterDelegate) {
//        (self.coordinator as? ProfileCoordinator)?.pushToPhotosViewController(arrayPhotos: arrayPhotos)
        self.localNotificationService.setDelegate(object)
        self.localNotificationService.registeForLatestUpdatesIfPossible()
    }
    
    func registeForLatestUpdatesIfPossible(_ object: UNUserNotificationCenterDelegate) {
        self.localNotificationService.setDelegate(object)
        self.localNotificationService.registeForLatestUpdatesIfPossible()
    }
}
