//
//  ProfileViewController.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation
import UIKit

final class ProfileViewController2: UIViewController {
    
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
//        self.view.backgroundColor = .systemGray6
        self.view.backgroundColor = .blue
        #endif
//        self.view.backgroundColor = UIColor.orange
        self.profileView.configureTableView(dataSource: self, delegate: self)
//        self.view.addSubview(profileView)
        self.view = profileView
//        self.title = "Profile"
//        self.navigationController?.navigationBar.isHidden = true
    }
    
}



    // MARK: - Extension UITableViewDataSource

extension ProfileViewController2: UITableViewDataSource {
    
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
            return cell
        }
    }
    
}



    // MARK: - Extension UITableViewDelegate

extension ProfileViewController2: UITableViewDelegate {
    
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
            self.viewModel.didPab()
//            let photosViewController = PhotosViewController()
//            photosViewController.title = "Photo Gallery"
//            // Тут должен работать coordinator
//            navigationController?.pushViewController(photosViewController, animated: true)
        }
    }
    
}
