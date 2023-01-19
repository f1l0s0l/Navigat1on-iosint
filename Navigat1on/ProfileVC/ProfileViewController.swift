//
//  ProfileViewController.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 19.01.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    static var user = User(login: "aria1401",
                           fullName: "Ария",
                           avatar: UIImage(named: "19"),
                           status: "У меня вылез уже пятый фуб!"
   )
    
    
    // MARK: - Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 44
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCellID")
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "ProfileHeaderViewID")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCellID")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCellID")
        return tableView
    }()
    
        
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
  

    // MARK: - Methods
    
    private func setupView() {
        self.navigationController?.navigationBar.isHidden = true
        
        #if DEBUG
        self.view.backgroundColor = .red
        #else
        self.view.backgroundColor = .systemGray6
        #endif
        
        self.view.addSubview(tableView)
    }
    
    
    // MARK: - Constraints

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}



    //MARK: - Extension UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        return DataPosts.dataPosts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCellID", for: indexPath) as? PhotosTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCellID", for: indexPath)
                return cell
            }
            
            cell.setup(withPhoto: Photos.photos)
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCellID", for: indexPath) as? PostTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCellID", for: indexPath)
                return cell
            }
            
            cell.setup(withPost: DataPosts.dataPosts[indexPath.row])
            return cell
        }
    }
    
}



    //MARK: - Extension UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProfileHeaderViewID") as? ProfileHeaderView {
                
                headerView.setup(user: ProfileViewController.user)
                return headerView
            }
        }

        return nil
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            let photosViewController = PhotosViewController()
            photosViewController.title = "Photo Gallery"
            navigationController?.pushViewController(photosViewController, animated: true)
        }
    }
    
}
