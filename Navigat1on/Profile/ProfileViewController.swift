//
//  ProfileViewController.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation
import UIKit

final class ProfileViewController: UIViewController {
    
    
    private enum LocalizedKeys: String {
        case title = "profileViewController.title"
    }
    
    // MARK: - Properties
    
    private let viewModel: ProfileViewModel
    
    private lazy var profileView = ProfileView()
    
    
    // MARK: - Life cycle
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
//        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    
    // MARK: - Methods
    
    private func setupView() {
        #if DEBUG
        self.view.backgroundColor = .red
        #else
        self.view.backgroundColor = ColorConstant.background
        #endif
        self.profileView.configureTableView(dataSource: self, delegate: self, dragDelegate: self, dropDelegate: self)
        self.view = profileView
        self.title = String(localized: String.LocalizationValue(LocalizedKeys.title.rawValue))
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    private func getDragItemsFromCell(for indexPath: IndexPath) -> [UIDragItem] {
        guard let image = self.viewModel.dataPosts[indexPath.row].image,
              let description = self.viewModel.dataPosts[indexPath.row].description
        else {
            return []
        }
        let imageItemProvider = NSItemProvider(object: image as NSItemProviderWriting)
        let descriptionItemProvider = NSItemProvider(object: description as NSItemProviderWriting)
        
        let dragItems = [
            UIDragItem(itemProvider: imageItemProvider),
            UIDragItem(itemProvider: descriptionItemProvider),
        ]
        return dragItems
    }
    
}



    // MARK: - Extension UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        return self.viewModel.dataPosts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCellID", for: indexPath) as? PhotosTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCellID", for: indexPath)
                return cell
            }
            
            cell.setup(withPhoto: self.viewModel.arrayPhotos)
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCellID", for: indexPath) as? PostTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCellID", for: indexPath)
                return cell
            }
            
            cell.setup(withPost: self.viewModel.dataPosts[indexPath.row])
            cell.parentTableView = self
            return cell
        }
    }
    
}



    // MARK: - Extension UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProfileHeaderViewID") as? ProfileHeaderView {
                
                headerView.setup(user: self.viewModel.user)
                return headerView
            }
        }

        return nil
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            self.viewModel.didTapPhotosCell()
        }
    }
    
}



    // MARK: - UITableViewDragDelegate

extension ProfileViewController: UITableViewDragDelegate {
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        self.getDragItemsFromCell(for: indexPath)
    }
    
    
}




// MARK: - UITableViewDropDelegate

extension ProfileViewController: UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        
        guard session.items.count == 1 else {
            return UITableViewDropProposal(operation: .cancel)
        }
        return UITableViewDropProposal(operation: .copy, intent: .insertIntoDestinationIndexPath)
        
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        coordinator.session.loadObjects(ofClass: UIImage.self) { [weak self] items in
            guard let image = items.first as? UIImage else {
                return
            }
            let newPostView = PostView(
                author: "Drag & Drop",
                description: "Drag & Drop description",
                image: image,
                likes: 0,
                views: 0,
                id: UUID().uuidString
            )
            self?.viewModel.dataPosts.insert(newPostView, at: destinationIndexPath.row)
            tableView.insertRows(at: [destinationIndexPath], with: .automatic)
        }
    }

}
