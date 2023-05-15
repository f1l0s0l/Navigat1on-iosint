//
//  LogInViewController.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import UIKit

final class LogInViewController2: UIViewController {
    
    private enum LocalizedKeys: String {
        case userEmailTextFieldPlaceholder = "userEmailTextField.placeholder"
        case userPasswordTextFieldPlaceholder = "userPasswordTextField.placeholder"
        case logInButtonTitle = "logInButton.title"
        
    }
    
    // MARK: - Properties
    
    private let viewModel: ILogInViewModel
    
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
        stackView.layer.borderColor = UIColor.lightGray.cgColor // !!!!!!!!!!!!
        return stackView
    }()
    
    private lazy var userEmailTextField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = ColorConstant.backgroundTextFieldLogin
        
        textField.keyboardType = .emailAddress
        textField.placeholder = String(localized: String.LocalizationValue(LocalizedKeys.userEmailTextFieldPlaceholder.rawValue))
        textField.textColor = ColorConstant.label
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.clearButtonMode = .whileEditing
        textField.autocapitalizationType = .none
        textField.textPadding.left = 8
        textField.tag = 0
        return textField
    }()
    
    private lazy var userPasswordTextField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = ColorConstant.backgroundTextFieldLogin
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor // !!!!!!!
        
        textField.returnKeyType = .done
        textField.isSecureTextEntry = true
        textField.placeholder = String(localized: String.LocalizationValue(LocalizedKeys.userPasswordTextFieldPlaceholder.rawValue))
        textField.textColor = ColorConstant.label
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.autocapitalizationType = .none
        textField.textPadding.left = 8
//        textField.delegate = self
        textField.tag = 1
        return textField
    }()
    
    private lazy var logInButton: CustomButton = {
        let button = CustomButton(
            title: String(localized: String.LocalizationValue(LocalizedKeys.logInButtonTitle.rawValue)),
            backgroundImage: UIImage(named: "blue_pixel")
        )
        button.target = { [weak self] in
            self?.didTabLogInButton()
        }
        button.isEnabled = false
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var localAuthorizationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.addTarget(self, action: #selector(self.didTapLocalAuthorizationButton), for: .touchUpInside)
        return button
    }()
        
    private lazy var loadingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorConstant.background
        view.alpha = 0
        return view
    }()
        
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activitiIndicator = UIActivityIndicatorView(style: .medium)
        activitiIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activitiIndicator
    }()
    
    
    // MARK: - Life cycle
    
    init(viewModel: ILogInViewModel) {
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
        self.viewModel.checkCanEvaluete()
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

    
    // MARK: - Private methods
    
    private func bindViewModel() {
        viewModel.stateChenged = { [weak self] state in
            guard let self = self else {return}
            
            switch state {
            case .canEvaluete(let image):
                self.localAuthorizationButton.setImage(image, for: .normal)
                self.localAuthorizationButton.isHidden = false
                
            case .loading:
                self.loadingView.alpha = 0.6
                self.activityIndicator.startAnimating()
                
            case .loaded:
                self.loadingView.alpha = 0
                self.activityIndicator.stopAnimating()
                
            case .wrong(text: let text):
                self.setupAlertConfiguration(title: text)
            }
            
        }
    }

    private func setupView() {
        self.view.backgroundColor = ColorConstant.backgroundLoginFlow
        self.view.addSubview(self.scrollView)
        setupScrollView()
        setupGestures()
        self.view.addSubview(loadingView)
        self.view.addSubview(activityIndicator)
        self.setupTextField()
        self.setupConstraint()
    }
    
    private func setupScrollView() {
        self.scrollView.addSubview(self.logoImage)
        self.scrollView.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.userEmailTextField)
        self.stackView.addArrangedSubview(self.userPasswordTextField)
        self.scrollView.addSubview(self.logInButton)
        self.scrollView.addSubview(self.localAuthorizationButton)
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapToSuperView))
        self.view.addGestureRecognizer(tapGesture)
    }

    private func setupAlertConfiguration(title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Продолжить", style: .cancel)
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
    
    private func didTabLogInButton() {
        self.viewModel.didTapButton(
            log: self.userEmailTextField.text,
            pswrd: self.userPasswordTextField.text
        )
    }
    
    private func setupTextField() {
        self.userPasswordTextField.addTarget(self, action: #selector(editingChangedTextField), for: .editingChanged)
        self.userEmailTextField.addTarget(self, action: #selector(editingChangedTextField), for: .editingChanged)
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
            
            localAuthorizationButton.topAnchor.constraint(equalTo: self.logInButton.bottomAnchor, constant: 5),
            localAuthorizationButton.centerXAnchor.constraint(equalTo: self.logInButton.centerXAnchor),
            localAuthorizationButton.heightAnchor.constraint(equalTo: self.logInButton.heightAnchor),
            localAuthorizationButton.widthAnchor.constraint(equalTo: self.localAuthorizationButton.heightAnchor),
            
            loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            loadingView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            loadingView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: self.loadingView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.loadingView.centerYAnchor),

        ])
    }
    
    @objc
    private func didHideKeyboard(_ notification: Notification) {
//        self.view.endEditing(true)
        self.scrollView.setContentOffset(.zero, animated: true)
    }
    
    @objc
    private func didTapToSuperView() {
        self.view.endEditing(true)
    }
    
    @objc
    private func didShowKeyboard(_ notification: Notification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {

            let keyboardHeight = keyboardFrame.cgRectValue.height
                        
            let buttonBottomPointY = self.logInButton.frame.origin.y + self.logInButton.frame.height
            let keyboardOriginY = self.scrollView.frame.height - keyboardHeight
            
            let yOffset = keyboardOriginY < buttonBottomPointY ? buttonBottomPointY - keyboardOriginY : 0
            
            self.scrollView.contentOffset = CGPoint(x: 0, y: yOffset)
        }
        
    }
    
    @objc
    private func editingChangedTextField() {
        guard let emailText = self.userEmailTextField.text,
              let pswrdText = self.userPasswordTextField.text,
              emailText.count > 0,
              pswrdText.count > 0
        else {
            self.logInButton.isEnabled = false
            return
        }
        self.logInButton.isEnabled = true
    }
    
    @objc
    private func didTapLocalAuthorizationButton() {
        self.viewModel.didTaplocalAuthorizationButton()
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



