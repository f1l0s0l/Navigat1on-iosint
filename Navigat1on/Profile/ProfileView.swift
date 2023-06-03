//
//  ProfileView.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 01.02.2023.
//

import Foundation
import UIKit


final class ProfileView: UIView {
    
    
    // MARK: - Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 44
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCellID")
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "ProfileHeaderViewID")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCellID")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCellID")
        tableView.dragInteractionEnabled = true
        return tableView
    }()
    
    
    // MARK: - Life Cycle
    
    init() {
        super.init(frame: .zero)
        self.setupView()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public Methods
    
    func configureTableView(dataSource: UITableViewDataSource, delegate: UITableViewDelegate, dragDelegate: UITableViewDragDelegate, dropDelegate: UITableViewDropDelegate) {
        self.tableView.dataSource = dataSource
        self.tableView.delegate = delegate
        self.tableView.dragDelegate = dragDelegate
        self.tableView.dropDelegate = dropDelegate
    }
    
    
    // MARK: - Methods
    
    private func setupView() {
        self.addSubview(tableView)
//        self.backgroundColor = .systemGray6
        self.backgroundColor = ColorConstant.background
    }
    
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}
