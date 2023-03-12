//
//  FavouritesViewModel.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 06.03.2023.
//

import Foundation
import CoreData
//import UIKit

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
        //
        case reloadFavourites
        //
        
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
    
    let fetchResultsController = CoreDataManager.shared.fetchResultsController
    
    
    // MARK: - Properties
    
    private let coordinator: Coordinatable
    
    
    // MARK: - Life cycle
    
    init(coordinator: Coordinatable) {
        self.coordinator = coordinator
        try? fetchResultsController.performFetch()
    }
    
    
    // MARK: - Public methods
    
    func doAction(action: Action) {
        switch action {
            
        case .reloadFavourites:
            ()
            
        case .removeOllFavourites:
            CoreDataManager.shared.removeAllFavourites()
            
        case .removeFavouritePost(let indexPath):
            let favouritePost = self.fetchResultsController.object(at: indexPath)
            CoreDataManager.shared.removeFavouritePost(favouritePost: favouritePost)
            
        case .didTapSearchButton:
            self.state = .showSearchItem
            
        case .didChangesSearch(let searchString):
            guard let searchString = searchString,
                  !searchString.isEmpty
            else {
                return
            }
            //
            self.showFavotitesPosts()
            
        case .didTapCloseSearchButton:
            self.state = .hideSearchItem
        }
        
    }
    
    
    // MARK: - Methods
    
    private func showFavotitesPosts() {
        if self.fetchResultsController.fetchedObjects?.count ?? 0 < 0 {
            self.state = .noFavouritesPosts
        } else {
            self.state = .showOllFavouritesPosts
        }
    }
    
}
