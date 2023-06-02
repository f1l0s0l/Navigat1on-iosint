//
//  ProfileViewModel.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation

protocol IProfileViewModel: AnyObject {
    func didTapPhotosCell()
}

final class ProfileViewModel {
    
    // MARK: - Public properties
    
    let dataPosts = DataPosts.dataPosts

    let arrayPhotos = Photos.photos
    
    var user: User
    
    
    // MARK: - Private properties
    
    private weak var coordinator: IProfileCoordinator?
    
    
    // MARK: - Init
    
    init(coordinator: IProfileCoordinator?, user: User) {
        self.coordinator = coordinator
        self.user = user
    }
    
}



    // MARK: - IProfileViewModel

extension ProfileViewModel: IProfileViewModel {
    func didTapPhotosCell() {
        self.coordinator?.pushToPhotosViewController(arrayPhotos: self.arrayPhotos)
    }
}
