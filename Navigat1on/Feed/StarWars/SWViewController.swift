//
//  SWViewController.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 17.02.2023.
//

import Foundation
import UIKit

final class StarWarsViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: StarWarsViewModel
    
    
    private lazy var activityView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.6
        view.backgroundColor = .white
        view.isHidden = true
        return view
    }()
    
    private lazy var firstHeaderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Привествую тебя юный падаван!"
        return label
    }()
    
    private lazy var secondHeaderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Примени силу, что бы получить информацию о планетах"
        return label
    }()
    
    private lazy var loadedPlanetInfoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitle("Применить силу", for: .normal)
        button.addTarget(self, action: #selector(didTabLoadedPlanetInfoButton), for: .touchUpInside)
        return button
    }()
    @objc
    private func didTabLoadedPlanetInfoButton() {
        self.viewModel.didTap(action: .didTabLoadedPlanetInfoButton)
    }

    

    
    // MARK: - Life cycle
    
    init(viewModel: StarWarsViewModel) {
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
//        self.bindViewModel()
//        self.viewModel.test()
    }
    
    
    // MARK: - Methods
    
    private func setupView() {
        self.view.backgroundColor = UIColor.green
        self.title = "Проверка"
        self.view.addSubview(firstHeaderLabel)
        self.view.addSubview(secondHeaderLabel)
        self.view.addSubview(loadedPlanetInfoButton)
        self.view.addSubview(activityView)
    }
    
    private func bindViewModel() {
        viewModel.stateChenged = { [weak self] state in
            guard let self = self else {return}

            switch state {
            case .initial:
                ()

            case .loading:
                self.activityView.isHidden = false
                print("state = .loading")

            case .loaded:
                ()
                
            case .error:
                print("Какая то ошибка")
            }


        }
    }
    
    private func stopAnimation() {
//        self.activityIndicator.stopAnimating()
//        self.activityView.isHidden = true
    }

    // MARK: - Constraints
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
//            firstHeaderLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            firstHeaderLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            firstHeaderLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            firstHeaderLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),

            
//            secondHeaderLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            secondHeaderLabel.topAnchor.constraint(equalTo: self.firstHeaderLabel.bottomAnchor, constant: 20),
            secondHeaderLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            secondHeaderLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            
            loadedPlanetInfoButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loadedPlanetInfoButton.topAnchor.constraint(equalTo: self.secondHeaderLabel.bottomAnchor, constant: 20),
            loadedPlanetInfoButton.heightAnchor.constraint(equalToConstant: 50),
            loadedPlanetInfoButton.widthAnchor.constraint(equalToConstant: 200),
            
            activityView.topAnchor.constraint(equalTo: self.view.topAnchor),
            activityView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            activityView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            activityView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
}

