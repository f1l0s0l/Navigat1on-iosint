//
//  ProfileViewModel.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation

final class ProfileViewModel {
    
    // MARK: - Properties
    
    let dataPosts = DataPosts.dataPosts
    let arrayPhotos = Photos.photos
    
    let coordinator: Coordinatable
    var user: User
    
    
    // MARK: - Life Cycle
    
    init(coordinator: Coordinatable, user: User) {
        self.coordinator = coordinator
        self.user = user
    }
    
    
    // MARK: - Public Methods
    
    func didPab() {
        (coordinator as? ProfileCoordinator)?.pushToPhotosViewController(arrayPhotos: arrayPhotos)
    }
    
}
