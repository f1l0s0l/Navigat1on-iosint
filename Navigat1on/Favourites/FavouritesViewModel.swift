//
//  FavouritesViewModel.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 06.03.2023.
//

import Foundation
//import CoreData

final class FavouritesViewModel {
    
    enum State {
        case initial
        case noFavouritesPosts
        case showOllFavouritesPosts
        case showSearchItem
        case hideSearchItem
        case tableViewReloadData
        case tableViewInsertRow(indexPath: [IndexPath])
        case tableViewDeleteRow(indexPath: [IndexPath])
    }
    
    enum Action {
        case reloadFavourites
        case removeOllFavourites
        case removeFavouritePost(indexPath: IndexPath)
        case didTapSearchButton
        case didChangesSearch(searchString: String?)
        case didTapCloseSearchButton
        case checkIsEmptyFavouritesPosts
        case insertRow(indexPath: [IndexPath])
        case deleteRow(indexPath: [IndexPath])
        case reloadDate
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
            self.changeFetchResultsController(searchString: searchString)
            self.state = .tableViewReloadData
            
            
        case .didTapCloseSearchButton:
            self.changeFetchResultsController(searchString: nil)
            self.state = .hideSearchItem
            
            
        case .checkIsEmptyFavouritesPosts:
            self.showFavotitesPosts()
            
            
        case .deleteRow(let indexPath):
            if self.fetchResultsController.fetchedObjects?.count == 0 {
                self.state = .tableViewReloadData
            } else {
                self.state = .tableViewDeleteRow(indexPath: indexPath)
            }
            
            
        case .insertRow(let indexPath):
            self.state = .tableViewInsertRow(indexPath: indexPath)
            
            
        case .reloadDate:
            self.state = .tableViewReloadData
        }
        
    }
    
    
    // MARK: - Methods
    
    private func showFavotitesPosts() {
        if self.fetchResultsController.fetchedObjects?.count ?? 0 == 0 {
            self.state = .noFavouritesPosts
        } else {
            self.state = .showOllFavouritesPosts
        }
    }
    
    private func changeFetchResultsController(searchString: String?) {
        if let searchString = searchString, !searchString.isEmpty {
            self.fetchResultsController.fetchRequest.predicate = NSPredicate(format: "author contains[c] %@", searchString)
        } else {
            self.fetchResultsController.fetchRequest.predicate = NSPredicate(value: true)
        }
        
        try? self.fetchResultsController.performFetch()
        self.showFavotitesPosts()
    }
    
}
