//
//  FavouritesViewModel.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 06.03.2023.
//

import Foundation
//import CoreData

protocol IFavouritesViewModel: AnyObject {
    var stateChange: ((FavouritesViewModel.State) -> Void)? { get set }
    
    func removeOllFavourites()
    func removeFavouritePost(indexPath: IndexPath)
    func didTapSearchButton()
    func didChangesSearch(searchString: String?)
    func didTapCloseSearchButton()
    func checkIsEmptyFavouritesPosts()
    func deleteRow(indexPath: IndexPath)
    func insertRow(indexPath: IndexPath)
    func reloadData()
}

final class FavouritesViewModel {
    
    // MARK: Enum
    
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
    
    // MARK: - Public Properties
    
    var stateChange: ((State) -> Void)?
    
    
    // MARK: - Private properties
    
    private(set) var state: State = .initial {
        didSet {
            stateChange?(state)
        }
    }
    
    let fetchResultsController = CoreDataManager.shared.fetchResultsController
    
    private weak var coordinator: IFavouritesCoordinator?
    
    
    // MARK: - Life cycle
    
    init(coordinator: IFavouritesCoordinator?) {
        self.coordinator = coordinator
        try? fetchResultsController.performFetch()
    }
    
    
    // MARK: - Private methods
    
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



    // MARK: - IFavouritesViewModel

extension FavouritesViewModel: IFavouritesViewModel {
    
    func removeOllFavourites() {
        CoreDataManager.shared.removeAllFavourites()
    }
    
    func removeFavouritePost(indexPath: IndexPath) {
        let favouritePost = self.fetchResultsController.object(at: indexPath)
        CoreDataManager.shared.removeFavouritePost(favouritePost: favouritePost)
    }
    
    func didTapSearchButton() {
        self.state = .showSearchItem
    }
    
    func didChangesSearch(searchString: String?) {
        self.changeFetchResultsController(searchString: searchString)
        self.state = .tableViewReloadData
    }
    
    func didTapCloseSearchButton() {
        self.changeFetchResultsController(searchString: nil)
        self.state = .hideSearchItem
    }
    
    func checkIsEmptyFavouritesPosts() {
        self.showFavotitesPosts()
    }
    
    func deleteRow(indexPath: IndexPath) {
        if self.fetchResultsController.fetchedObjects?.count == 0 {
            self.state = .tableViewReloadData
        } else {
            self.state = .tableViewDeleteRow(indexPath: [indexPath])
        }
    }
    
    func insertRow(indexPath: IndexPath) {
        self.state = .tableViewInsertRow(indexPath: [indexPath])
    }
    
    func reloadData() {
        self.state = .tableViewReloadData
    }
    
}
