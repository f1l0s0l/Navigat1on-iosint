//
//  FavouritesViewController.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 06.03.2023.
//

import Foundation
import UIKit

final class FavouritesViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: FavouritesViewModel
    
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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCellID")
        tableView.dataSource = self
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
    }
    
    
    // MARK: - Methods
    
    private func setupView() {
        self.title = "Favourites"
        self.view.backgroundColor = .systemGray6
        self.view.addSubview(self.backView)
        self.view.addSubview(self.oopsTextLabel)
        self.view.addSubview(self.tableView)
    }
    
    private func setupNavigationBarItem() {
        let removeButton = UIBarButtonItem(
            image: UIImage(systemName: "trash"),
            style: .done,
            target: self,
            action: #selector(removeOllFavorites)
        )
        self.navigationItem.rightBarButtonItem = removeButton
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
                
            case .noFavourites:
                self?.backView.isHidden = false
                self?.tableView.isHidden = true
                
            case .haveFavourites:
                self?.tableView.reloadData()
                self?.backView.isHidden = true
                self?.tableView.isHidden = false
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
        self.viewModel.favouritesPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCellID", for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        
        let favouritePost = self.viewModel.favouritesPosts[indexPath.row]
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
            views: Int(favouritePost.views)
        )
        
        cell.setup(withPost: postView)
        cell.isFavourites = true
        return cell
    }
    
    
}
