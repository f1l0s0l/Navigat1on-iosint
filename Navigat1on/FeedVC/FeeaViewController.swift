//
//  FeeaViewController.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 19.01.2023.
//

//import StorageServise
//import UIKit
//
//class FeedViewController: UIViewController {
//    
//    // MARK: - Properties
//    
//    private let feedModel: FeedModelProtocol
//    
//    var post = Post(title: "Title of this Post")
//    
//    private let stackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .vertical
//        stackView.spacing = 10
//        stackView.alignment = .center
//        return stackView
//    }()
//    
//    private lazy var buttonFirst: CustomButton = {
//        let button = CustomButton(title: "First post",
//                                  titleColor: UIColor.black,
//                                  backgroundColor: UIColor.lightGray
//        )
//        button.layer.cornerRadius = 14
//        button.target = { [weak self] in
//            self?.tochUpInsideOnButtonFirst()
//        }
//        // Вопрос, надо использовать так?
//        // Или тут не будет возникать циклической ссылки и можно просывать так:
//        //button.target = tochUpInsideOnButtonFirst
//        return button
//    }()
//    
//    private lazy var buttonSecond: CustomButton = {
//        let button = CustomButton(title: "Second post",
//                                  titleColor: UIColor.black,
//                                  backgroundColor: UIColor.lightGray
//        )
//        button.layer.cornerRadius = 14
//        button.target = { [weak self] in
//            self?.tochUpInsideOnButtonSecond()
//        }
//        // Вопрос, надо использовать так?
//        // Или тут не будет возникать циклической ссылки и можно просывать так:
//        //button.target = tochUpInsideOnButtonSecond
//        return button
//    }()
//    
//    private lazy var checkPasswordTextField: UITextField = {
//        let textField = UITextField()
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.backgroundColor = .systemGray6
//        textField.layer.cornerRadius = 5
//        return textField
//    }()
//    
//    private lazy var checkGuessButton: CustomButton = {
//        let button = CustomButton(title: "Check",
//                                  titleColor: UIColor.black,
//                                  backgroundColor: UIColor.lightGray
//        )
//        button.target = { [weak self] in
//            self?.didPabCheckGuessButton()
//        }
//        // Вопрос, надо использовать так?
//        // Или тут не будет возникать циклической ссылки и можно просывать так:
//        //button.target = didPabCheckGuessButton
//        button.layer.cornerRadius = 14
//        return button
//    }()
//
//    
//    // MARK: - Life cycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupViewController()
//    }
//    
//    init(feedModel: FeedModelProtocol) {
//        self.feedModel = feedModel
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
// 
//    // MARK: - Methods
//    
//    private func setupViewController() {
//        self.view.backgroundColor = .white
//        self.title = "Feed"
//        self.view.addSubview(stackView)
//        self.setupStackView()
//        self.view.addSubview(checkPasswordTextField)
//        self.view.addSubview(checkGuessButton)
//        self.setupConstraints()
//    }
//    
//    private func setupStackView() {
//        stackView.addArrangedSubview(buttonFirst)
//        stackView.addArrangedSubview(buttonSecond)
//    }
//    
//  
//    private func tochUpInsideOnButtonFirst() {
//        let postViewController = PostViewController()
//        postViewController.titlePost = post.title
//        navigationController?.pushViewController(postViewController, animated: true)
//    }
//    
//    private func tochUpInsideOnButtonSecond() {
//        let postViewController = PostViewController()
//        postViewController.titlePost = post.title
//        navigationController?.pushViewController(postViewController, animated: true)
//    }
//    
//    private func didPabCheckGuessButton() {
//        self.view.endEditing(true)
//        if feedModel.check(word: checkPasswordTextField.text) {
//            checkGuessButton.backgroundColor = UIColor.green
//        } else {
//            checkGuessButton.backgroundColor = UIColor.red
//        }
//       
//    }
//    
//    
//    // MARK: - Constraints
//    
//    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
//            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
//            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            
//            buttonFirst.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 10),
//            buttonFirst.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -10),
//            buttonFirst.heightAnchor.constraint(equalToConstant: 50),
//            
//            buttonSecond.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 10),
//            buttonSecond.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -10),
//            buttonSecond.heightAnchor.constraint(equalToConstant: 50),
//            
//            checkPasswordTextField.bottomAnchor.constraint(equalTo: checkGuessButton.topAnchor, constant: -10),
//            checkPasswordTextField.widthAnchor.constraint(equalTo: buttonFirst.widthAnchor),
//            checkPasswordTextField.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
//            
//            checkGuessButton.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -50),
//            checkGuessButton.widthAnchor.constraint(equalTo: checkPasswordTextField.widthAnchor),
//            checkGuessButton.centerXAnchor.constraint(equalTo: checkPasswordTextField.centerXAnchor),
//            checkGuessButton.heightAnchor.constraint(equalTo: buttonFirst.heightAnchor),
//
//            
//        ])
//    }
//}
