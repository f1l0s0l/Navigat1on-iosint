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
        case noFavouritesPosts
        case showOllFavouritesPosts
        case removeFavoritePost(indexPath: IndexPath)
        case showSearchItem
        case hideSearchItem
    }
    
    enum Action {
        case reloadFavourites
        case removeOllFavourites
        case removeFavouritePost(indexPath: IndexPath)
        case didTapSearchButton
        case didChangesSearch(searchString: String?)
        case didTapCloseSearchButton
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
            
        case .removeOllFavourites:
            CoreDataManager.shared.removeAllFavourites()
            self.reloadFavouritesPots()
            
        case .removeFavouritePost(let indexPath):
            let favouritePost = self.favouritesPosts[indexPath.row]
            
            CoreDataManager.shared.removeFavouritePost(favouritePost: favouritePost) { [weak self] in
                guard let self = self else {
                    return
                }
                self.favouritesPosts.removeAll(where: {$0.id == favouritePost.id} )
                self.state = .removeFavoritePost(indexPath: indexPath)
                self.showFavotitesPosts()
            }
            
        case .didTapSearchButton:
            self.state = .showSearchItem
            
        case .didChangesSearch(let searchString):
            guard let searchString = searchString,
                  !searchString.isEmpty
            else {
                return
            }
            self.favouritesPosts = CoreDataManager.shared.getAutorFavouritesPosts(searchString: searchString)
            self.showFavotitesPosts()
            
        case .didTapCloseSearchButton:
            self.state = .hideSearchItem
            self.reloadFavouritesPots()
        }
        
    }
    
    
    // MARK: - Methods
    
    private func showFavotitesPosts() {
        if self.favouritesPosts.count == 0 {
            self.state = .noFavouritesPosts
        } else {
            self.state = .showOllFavouritesPosts
        }
    }
    
    private func reloadFavouritesPots() {
        self.favouritesPosts = CoreDataManager.shared.favouritesPosts
        self.showFavotitesPosts()
    }
    
}
