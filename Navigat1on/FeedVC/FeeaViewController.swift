//
//  FeeaViewController.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 19.01.2023.
//

import StorageServise
import UIKit

class FeedViewController: UIViewController {
    
    // MARK: - Properties
    
    var post = Post(title: "Title of this Post")
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    private let buttonFirst: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("First post", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 14
        return button
    }()
    
    private let buttonSecond: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Second post", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 14
        return button
    }()

    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
 
    // MARK: - Methods
    
    private func setupViewController() {
        self.view.backgroundColor = .white
        self.title = "Feed"
        self.view.addSubview(stackView)
        self.setupStackView()
        self.setupConstraints()
    }
    
    private func setupStackView() {
        stackView.addArrangedSubview(buttonFirst)
        stackView.addArrangedSubview(buttonSecond)
        setupTapOnButton()
    }
    
    private func setupTapOnButton() {
        buttonFirst.addTarget(self, action: #selector(tochDownOnButtonFirst), for: .touchDown)
        buttonFirst.addTarget(self, action: #selector(tochUpInsideOnButtonFirst), for: .touchUpInside)
        
        buttonSecond.addTarget(self, action: #selector(tochDownOnButtonSecond), for: .touchDown)
        buttonSecond.addTarget(self, action: #selector(tochUpInsideOnButtonSecond), for: .touchUpInside)
    }
    
    @objc
    private func tochDownOnButtonFirst() {
        buttonFirst.alpha = 0.6
    }
    
    @objc
    private func tochUpInsideOnButtonFirst() {
        buttonFirst.alpha = 1
        let postViewController = PostViewController()
        postViewController.titlePost = post.title
        navigationController?.pushViewController(postViewController, animated: true)
    }
    @objc
    private func tochDownOnButtonSecond() {
        buttonSecond.alpha = 0.6
    }
    @objc
    private func tochUpInsideOnButtonSecond() {
        buttonSecond.alpha = 1
        let postViewController = PostViewController()
        postViewController.titlePost = post.title
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            buttonFirst.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 10),
            buttonFirst.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -10),
            buttonFirst.heightAnchor.constraint(equalToConstant: 50),
            
            buttonSecond.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 10),
            buttonSecond.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -10),
            buttonSecond.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
