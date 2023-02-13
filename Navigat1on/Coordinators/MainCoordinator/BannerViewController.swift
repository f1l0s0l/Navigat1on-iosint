//
//  BannerViewController.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 13.02.2023.
//

import UIKit

protocol BannerViewControllerDelegate: AnyObject {
    func popBannerVC()
}

final class BannerViewController: UIViewController {
    
    // MARK: - Public Properties
    
    weak var delegate: BannerViewControllerDelegate?

    
    // MARK: - Properties
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.isHidden = true
        button.addTarget(self, action: #selector(backOnMainTabBarController), for: .touchUpInside)
        return button
    }()
    
    private lazy var testTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = """
Это рекламный банер!
Через 3 секунды повится кнопка назад!
"""
        return label
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraints()
    }
    
    
    // MARK: - Methods
    
    private func setupView() {
        self.view.backgroundColor = .orange
        self.view.addSubview(self.backButton)
        self.startTimerForBackButton()
        self.view.addSubview(self.testTextLabel)
    }
    
    private func startTimerForBackButton() {
        Timer.scheduledTimer(
            withTimeInterval: 3,
            repeats: false
        ) { timer in
            timer.invalidate()
            self.backButton.isHidden = false
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            backButton.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            
            testTextLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            testTextLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 32),
        ])
    }
    
    @objc
    private func backOnMainTabBarController() {
        self.delegate?.popBannerVC()
    }
    
}
