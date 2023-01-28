//
//  LogInView.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 26.01.2023.
//

//import UIKit
//
//class LogInView: UIView {
//
//    // MARK: - Properties
//
//    private lazy var scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        return scrollView
//    }()
//
//    private lazy var logoImage: UIImageView = {
//        let image = UIImageView(image: UIImage(named: "logo"))
//        image.translatesAutoresizingMaskIntoConstraints = false
//        image.clipsToBounds = true
//        return image
//    }()
//
//    private lazy var stackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .vertical
//        stackView.clipsToBounds = true
//        stackView.distribution = .fillEqually
//        stackView.layer.cornerRadius = 10
//        stackView.layer.borderWidth = 0.5
//        stackView.layer.borderColor = UIColor.lightGray.cgColor
//        return stackView
//    }()
//
//    private lazy var userEmailTextField: TextFieldWithPadding = {
//        let textField = TextFieldWithPadding()
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.backgroundColor = .systemGray6
//
//        textField.keyboardType = .emailAddress
//        textField.placeholder = "Email or phone"
//        textField.textColor = .black
//        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
//        textField.clearButtonMode = .whileEditing
//        textField.autocapitalizationType = .none
//        textField.textPadding.left = 8
////        textField.delegate = self
//        textField.tag = 0
//        return textField
//    }()
//
//    private lazy var userPasswordTextField: TextFieldWithPadding = {
//        let textField = TextFieldWithPadding()
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.backgroundColor = .systemGray6
//        textField.layer.borderWidth = 0.5
//        textField.layer.borderColor = UIColor.lightGray.cgColor
//
//        textField.returnKeyType = .done
//        textField.isSecureTextEntry = true
//        textField.placeholder = "Password"
//        textField.textColor = .black
//        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
//        textField.autocapitalizationType = .none
//        textField.textPadding.left = 8
////        textField.delegate = self
//        textField.tag = 1
//        return textField
//    }()
//
//    private lazy var logInButton: CustomButton = {
//        let button = CustomButton(title: "Log In",
//                                  backgroundImage: UIImage(named: "blue_pixel")
//
//        )
//        button.target = { [weak self] in
//            self?.touchUpInsideOnLogInButton()
//        }
//        button.layer.cornerRadius = 10
//        return button
//    }()
//
//
//
//
//
//    // MARK: - Life cycle
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//
//        self.setupConstraint()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//
//    // MARK: - Methods
//
//    private func touchUpInsideOnLogInButton() {
//
//    }
//
//
//    // MARK: - Methods
//
//
//
//    // MARK: - Constraints
//
//    private func setupConstraint() {
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
//            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
//            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
//
//            logoImage.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 120),
//            logoImage.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
//            logoImage.widthAnchor.constraint(equalToConstant: 100),
//            logoImage.heightAnchor.constraint(equalToConstant: 100),
//
//            stackView.topAnchor.constraint(equalTo: self.logoImage.bottomAnchor, constant: 120),
//            stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
//            stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
//            stackView.heightAnchor.constraint(equalToConstant: 100),
//
//            logInButton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 16),
//            logInButton.widthAnchor.constraint(equalTo: self.stackView.widthAnchor),
//            logInButton.centerXAnchor.constraint(equalTo: self.stackView.centerXAnchor),
//            logInButton.heightAnchor.constraint(equalToConstant: 50),
//        ])
//    }
//
//
//}
