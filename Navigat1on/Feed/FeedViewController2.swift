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
    
    
    private lazy var showStarWarsFlow: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitle("Далекая далекая галактика...", for: .normal)
        button.addTarget(self, action: #selector(didTapShowStarWarsFlow), for: .touchUpInside)
        return button
    }()
    
    @objc
    private func didTapShowStarWarsFlow() {
        self.viewModel.didTap(action: .didTapShowStarWarsFlow)
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
        self.view.backgroundColor = UIColor.green
        self.title = "Проверка"
        self.view.addSubview(showStarWarsFlow)
    }
    
    private func bindViewModel() {
        viewModel.stateChenged = { state in // [weak self]
//            guard let self = self else {return}
            
            switch state {
            case .initial:
                ()
                
            case .error:
                print("Какая то ошибка")
            }
        }
        
    }
    

    // MARK: - Constraints
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            showStarWarsFlow.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            showStarWarsFlow.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            showStarWarsFlow.widthAnchor.constraint(equalToConstant: 200),
            showStarWarsFlow.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
}
