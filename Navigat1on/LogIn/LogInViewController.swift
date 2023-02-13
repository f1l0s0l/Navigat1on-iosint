//
//  LogInViewController.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import UIKit

final class LogInViewController2: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: LogInViewModel
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var logoImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "logo"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.clipsToBounds = true
        stackView.distribution = .fillEqually
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        return stackView
    }()
    
    private lazy var userEmailTextField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray6
        
        textField.keyboardType = .emailAddress
        textField.placeholder = "Email or phone"
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.clearButtonMode = .whileEditing
        textField.autocapitalizationType = .none
        textField.textPadding.left = 8
//        textField.delegate = self
        textField.tag = 0
        return textField
    }()
    
    private lazy var userPasswordTextField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray6
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        
        textField.returnKeyType = .done
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.autocapitalizationType = .none
        textField.textPadding.left = 8
//        textField.delegate = self
        textField.tag = 1
        return textField
    }()
    
    private lazy var logInButton: CustomButton = {
        let button = CustomButton(title: "Log In",
                                  backgroundImage: UIImage(named: "blue_pixel")
        )
        button.target = { [weak self] in
            self?.didTabLogInButton()
        }
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var loadingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.alpha = 0
        return view
    }()
        
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activitiIndicator = UIActivityIndicatorView(style: .medium)
        activitiIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activitiIndicator
    }()
    
    
    // MARK: - Life cycle
    
    init(viewModel: LogInViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didShowKeyboard(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil
        )
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didHideKeyboard(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil
        )
    }

    
    // MARK: - Methods

    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.scrollView)
        setupScrollView()
        setupGestures()
        self.view.addSubview(loadingView)
        self.view.addSubview(activityIndicator)
        setupConstraint()
    }
    
    private func setupScrollView() {
        self.scrollView.addSubview(self.logoImage)
        self.scrollView.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.userEmailTextField)
        self.stackView.addArrangedSubview(self.userPasswordTextField)
        self.scrollView.addSubview(self.logInButton)
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapSuperView))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    
    @objc
    private func didHideKeyboard(_ notification: Notification) {
        self.viewModel.keyboardNotification(.Hide, notification)
    }
    
    @objc
    private func didShowKeyboard(_ notification: Notification) {
        self.viewModel.keyboardNotification(.Show(frameScrollView:  self.scrollView.frame,
                                                  frameBottomItems: self.logInButton.frame
                                                 ), notification
        )
    }

    private func setupAlertConfiguration(title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Продолжить", style: .cancel)
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
    
    private func didTabLogInButton() {
        self.viewModel.didTap(action: .didTapButton(log: self.userEmailTextField.text,
                                                          pswrd: self.userPasswordTextField.text)
        )
    }
    
    private func bindViewModel() {
        viewModel.stateChenged = { [weak self] state in
            guard let self = self else {return}
            
            switch state {
            case .initial:
                ()
                
            case .loading:
                self.loadingView.alpha = 0.6
                self.activityIndicator.startAnimating()
                print("Загрузка идет")
                
            case .loaded:
                print("Загрузка закончилась")
                self.loadingView.alpha = 0
                self.activityIndicator.stopAnimating()
                
            case .changeContentOffset(yPoint: let yPoint):
                self.scrollView.setContentOffset(CGPoint(x: 0, y: yPoint), animated: true)
                
            case .HideKeyboard:
                self.view.endEditing(true)
                
            case .wrong(text: let text):
                self.setupAlertConfiguration(title: text)

            case .error:
                print("Какая то ошибка!!!")
            }
            
        }
    }
    
    
    // MARK: - Constraint

    private func setupConstraint() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            logoImage.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 120),
            logoImage.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            
            stackView.topAnchor.constraint(equalTo: self.logoImage.bottomAnchor, constant: 120),
            stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            logInButton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 16),
            logInButton.widthAnchor.constraint(equalTo: self.stackView.widthAnchor),
            logInButton.centerXAnchor.constraint(equalTo: self.stackView.centerXAnchor),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            
            loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            loadingView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            loadingView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: self.loadingView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.loadingView.centerYAnchor),

        ])
    }
    
    @objc
    private func didTapSuperView() {
        self.viewModel.didTap(action: .didTapSuperView)
    }
    
}


////MARK: - Extension UITextFieldDelegate
//
//extension LogInViewController: UITextFieldDelegate {
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField.tag == 0 {
//            self.userPasswordTextField.becomeFirstResponder()
//        } else {
//            self.forcedHidingKeyboard()
//        }
//        return true
//    }
//}



