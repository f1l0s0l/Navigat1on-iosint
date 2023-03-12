//
//  FavouritesViewController.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 06.03.2023.
//

//import Foundation
import UIKit
import CoreData

class FavouritesViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: FavouritesViewModel
    
    private lazy var fetchResultsController = self.viewModel.fetchResultsController
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        view.isHidden = true
        return view
    }()
    
    private lazy var oopsTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Тут должна быть милая картинка и текст, в духе: 'В вашем избранном пока пусто, но вы всегла можете добавить понравившиеся посты в избранное двойным тапом по посту'"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        return searchController
    }()
    
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCellID")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemGray6
        return tableView
    }()
    
    
    // MARK: - Life cycle
    
    init(viewModel: FavouritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupNavigationBarItem()
        self.setupConstraints()
        self.bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.doAction(action: .reloadFavourites)
        self.tableView.reloadData()
    }
    
    
    // MARK: - Methods
    
    private func setupView() {
        self.title = "Favourites"
        self.view.backgroundColor = .systemGray6
        self.view.addSubview(self.backView)
        self.view.addSubview(self.oopsTextLabel)
        self.view.addSubview(self.tableView)
        self.fetchResultsController.delegate = self
    }
    
    private func setupNavigationBarItem() {
        let searchButton = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .done,
            target: self,
            action: #selector(didTapSearchButton)
        )
        self.navigationItem.leftBarButtonItem = searchButton
        
        self.hideSearchItem()
    }
    
    private func showSearchItem() {
        self.navigationItem.searchController = self.searchController
        
        let closeSearchButton = UIBarButtonItem(
            image: UIImage(systemName: "x.square"),
            style: .done,
            target: self,
            action: #selector(didTapCloseSearchButton)
        )
        self.navigationItem.rightBarButtonItem = closeSearchButton
        self.oopsTextLabel.text = "Нет такого автора..."
    }
    
    private func hideSearchItem() {
        self.navigationItem.searchController = nil
        
        let removeFavouritesPostsButton = UIBarButtonItem(
            image: UIImage(systemName: "trash"),
            style: .done,
            target: self,
            action: #selector(removeOllFavorites)
        )
        self.navigationItem.rightBarButtonItem = removeFavouritesPostsButton
        self.oopsTextLabel.text = "Тут должна быть милая картинка и текст, в духе: 'В вашем избранном пока пусто, но вы всегла можете добавить понравившиеся посты в избранное двойным тапом по посту'"
    }
    
    @objc
    private func didTapSearchButton() {
//        self.viewModel.doAction(action: .didTapSearchButton)
        CoreDataManager.shared.addFavourite(post: DataPosts.dataPosts[1], completion: {_ in })
    }
    
    @objc
    private func didTapCloseSearchButton() {
        self.viewModel.doAction(action: .didTapCloseSearchButton)
    }
    
    @objc
    private func removeOllFavorites() {
        self.viewModel.doAction(action: .removeOllFavourites)
    }
    
    
    // MARK: - Bind view model
    
    private func bindViewModel() {
        self.viewModel.stateChange = { [weak self] state in
            switch state {
            case .initial:
                ()
                
            case .noFavouritesPosts:
                self?.backView.isHidden = false
                self?.tableView.isHidden = true
                
            case .showOllFavouritesPosts:
//                self?.tableView.reloadData()
                self?.backView.isHidden = true
                self?.tableView.isHidden = false
                
            case .removeFavoritePost(let indexPath):
                self?.tableView.deleteRows(at: [indexPath], with: .automatic)
                
            case .showSearchItem:
                self?.showSearchItem()
                
            case .hideSearchItem:
                self?.hideSearchItem()
                
            }
        }
    }
    
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.backView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.backView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.backView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.backView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            self.oopsTextLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.oopsTextLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            self.oopsTextLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}



    // MARK: - UITableViewDataSourse

extension FavouritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.fetchResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCellID", for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        
        let favouritePost = self.fetchResultsController.object(at: indexPath)
        
        
        var imagePost: UIImage? {
            if let imageData = favouritePost.imageData {
               return UIImage(data: imageData)
            } else {
                return nil
            }
        }
        let postView = PostView(
            author: favouritePost.author,
            description: favouritePost.descriptionText,
            image: imagePost,
            likes: Int(favouritePost.likes),
            views: Int(favouritePost.views),
            id: favouritePost.uid
        )
        
        cell.setup(withPost: postView)
        cell.isFavourites = true
        return cell
    }
    
}



    // MARK: - UITableViewDelegate

extension FavouritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        self.viewModel.doAction(action: .removeFavouritePost(indexPath: indexPath))
    }
    
}



    // MARK: - UISearchResultsUpdating

extension FavouritesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.viewModel.doAction(action: .didChangesSearch(searchString: searchController.searchBar.text))
    }
    
}



extension FavouritesViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        guard let indexPath = indexPath else {
            return
        }
    
        switch type {
        case .delete:
            if controller.fetchedObjects!.count == 0 {
                self.tableView.reloadData()
            } else {
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            print("NSFetchedResultsControllerDelegate - удалили")
            
        case .update:
            self.tableView.reloadData()
            print("NSFetchedResultsControllerDelegate - изменили")
            
        case .insert:
            self.tableView.reloadData()
            print("NSFetchedResultsControllerDelegate - добавили")
            
        default:
            self.tableView.reloadData()
            print("NSFetchedResultsControllerDelegate - что то кроме удаления изменения или добавления ячейки")
            // так как мы не видим остальные изменения, тогда достаточно обновить таблицу
            
        }
        
//        self.tableView.reloadData()
        
    }
    
}

