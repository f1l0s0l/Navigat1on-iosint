//
//  FavouritesViewModel.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 06.03.2023.
//

import Foundation

final class FavouritesViewModel {
    
    enum State {
        case initial
        case noFavourites
        case haveFavourites
    }
    
    enum Action {
        case reloadFavourites
        case removeOllFavourites
    }
    
    
    // MARK: - Public Properties
    
    var stateChange: ((State) -> Void)?
    private var state: State = .initial {
        didSet {
            stateChange?(state)
        }
    }
    
    
    // MARK: - Properties
    
    private let coordinator: Coordinatable
        
    private(set) var favouritesPosts: [FavouritePost] = []
    
    
    
    // MARK: - Life cycle
    
    init(coordinator: Coordinatable) {
        self.coordinator = coordinator
        self.reloadFavouritesPots()
    }
    
    
    // MARK: - Public methods
    
    func doAction(action: Action) {
        switch action {
            
        case .reloadFavourites:
            self.reloadFavouritesPots()
            if self.favouritesPosts.count == 0 {
                self.state = .noFavourites
            } else {
                self.state = .haveFavourites
            }
            
        case .removeOllFavourites:
            CoreDataManager.shared.removeAllFavourites()
            self.reloadFavouritesPots()
            self.state = .noFavourites
            
        }
    }
    
    
    
    // MARK: - Methods
    
    private func reloadFavouritesPots() {
//        CoreDataManager.shared.reloadFavouritesPosts()
        self.favouritesPosts = CoreDataManager.shared.favouritesPosts
    }
    
    
    
}
