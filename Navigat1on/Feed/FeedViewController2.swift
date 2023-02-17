//
//  FeedViewController.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation
import UIKit

final class FeedViewController2: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: FeedViewModel
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private lazy var firstTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title: "
        return label
    }()
    
    private lazy var secondTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Orbital period: "
        return label
    }()
    
    private lazy var downloadDataButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Downoad information", for: .normal)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(didTabDownloadDataButton), for: .touchUpInside)
        return button
    }()
    @objc
    private func didTabDownloadDataButton() {
        self.viewModel.didTap(action: .didTapDownloadDataButton)
    }
    
    private lazy var showNameResidentsTatooineButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Downoad residents", for: .normal)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(didTabShowNameResidentsTatooineButton), for: .touchUpInside)
        return button
    }()
    @objc
    private func didTabShowNameResidentsTatooineButton() {
        self.viewModel.didTap(action: .didTapShowNameResidentsButton)
    }
    
    // MARK: - Life cycle
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraint()
        self.bindViewModel()
    }

    
    // MARK: - Methods
    
    private func setupView() {
        self.view.backgroundColor = .systemGray6
        self.title = "Feed"
        self.view.addSubview(firstTextLabel)
        self.view.addSubview(secondTextLabel)
        self.view.addSubview(downloadDataButton)
        self.view.addSubview(showNameResidentsTatooineButton)
        self.view.addSubview(activityIndicator)
    }
    
    private func bindViewModel() {
        viewModel.stateChenged = { [weak self] state in
            guard let self = self else {return}
            
            switch state {
            case .initial:
                ()
                
            case .loading:
                self.activityIndicator.startAnimating()
                
            case .loadedFirstTextLabel(let text):
                self.activityIndicator.stopAnimating()
                self.firstTextLabel.text = "Title: \(text)"
                
            case .loadedSecondTextLabel(let text):
                self.activityIndicator.stopAnimating()
                self.secondTextLabel.text = "Orbital period: \(text)"
                
            case .wrong(let text):
                self.setupAlertConfiguration(title: text)
                
            case .error:
                print("Какая то ошибка")
            }
        }
    }
    
    private func setupAlertConfiguration(title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Продолжить", style: .cancel)
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }

    
    // MARK: - Constraints
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            firstTextLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            firstTextLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            secondTextLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            secondTextLabel.topAnchor.constraint(equalTo: self.firstTextLabel.bottomAnchor, constant: 20),
            
            downloadDataButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            downloadDataButton.topAnchor.constraint(equalTo: self.secondTextLabel.bottomAnchor, constant: 20),
            downloadDataButton.heightAnchor.constraint(equalToConstant: 50),
            downloadDataButton.widthAnchor.constraint(equalToConstant: 200),
            
            showNameResidentsTatooineButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            showNameResidentsTatooineButton.topAnchor.constraint(equalTo: self.downloadDataButton.bottomAnchor, constant: 20),
            showNameResidentsTatooineButton.heightAnchor.constraint(equalToConstant: 50),
            showNameResidentsTatooineButton.widthAnchor.constraint(equalToConstant: 200),

            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),

        ])
    }
    
}
