//
//  NameResidentsViewController.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 17.02.2023.
//

import Foundation
import UIKit

final class NameResidentsViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: NameResidentsViewModel
    private var residents: [String] = []
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        return tableView
    }()
    
    
    // MARK: - Life cycle
    
    init(viewModel: NameResidentsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraints()
    }
    
    
    // MARK: - Methods
    
    private func setupView() {
//        self.view.backgroundColor = .systemGray6
        self.view.backgroundColor = ColorConstant.background
        self.title = "Residents"
        self.view.addSubview(tableView)
        self.view.addSubview(activityIndicator)
        self.bindViewModel()
        self.viewModel.startView()
    }
    
    private func bindViewModel() {
        viewModel.stateChenged = { [weak self] state in
            guard let self = self else {return}
            
            switch state {
            case .initial:
                ()
                
            case .loading:
                self.activityIndicator.startAnimating()
                
            case .loaded(let resident):
                self.residents = resident
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                
            case .error:
                print("Какая то ошибка")
            }
            
            
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
    
}

extension NameResidentsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.residents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.residents[indexPath.row]
        return cell
    }
}

