//
//  ProfileHeaderView.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 19.01.2023.
//

import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    
   private var statusText = StatusText(text: "Любимая доча")
    
    lazy var userPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "1")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .orange
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 55
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ария"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var buttonShowStatus: CustomButton = {
        let button = CustomButton(title: "Show status",
                                  backgroundColor: UIColor.systemBlue
        )
        button.target = { [weak self] in
            self?.tapOnButtonShowStatus()
        }
        // Вопрос, надо использовать так?
        // Или тут не будет возникать циклической ссылки и можно просывать так:
        //button.target = tapOnButtonShowStatus
        button.layer.cornerRadius = 14
        button.layer.shadowOffset.width = 4
        button.layer.shadowOffset.height = 4
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        return button
    }()
    
    private lazy var userStatus: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Любимая доча"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var changeUserStatus: TextFieldWithPadding = {
        let text = TextFieldWithPadding()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .white
        text.placeholder = "Любимая доча"
        text.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        text.textColor = .black
        text.layer.cornerRadius = 12
        text.textPadding.left = 7
        text.textPadding.right = 7
        return text
    }()
    
 
    // MARK: - Life cycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViewItems()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public
    
    func setup(user: User) {
        self.userName.text = user.fullName
        self.userStatus.text = user.status
        self.statusText.text = user.status
        self.changeUserStatus.placeholder = user.status
        self.userPhoto.image = user.avatar
    }
    
    
    // MARK: - Methods
    
    private func setupViewItems() {
        self.addSubview(userName)
        self.addSubview(buttonShowStatus)
        self.addSubview(userStatus)
        self.addSubview(changeUserStatus)
        self.addSubview(userPhoto)
        //Добавил изменение текста на кнопке в "Set status" согласно макету
        self.changeUserStatus.addTarget(self, action: #selector(titleButtonShowStatusChange), for: .touchDown) //!!!!!!!!
        self.changeUserStatus.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        self.setupConstraint()
    }
    
    private func tapOnButtonShowStatus() {
        userStatus.text = statusText.text
        changeUserStatus.placeholder = statusText.text
        print(userStatus.text ?? "Нет статуса")
        self.endEditing(true)
        buttonShowStatus.setTitle("Show status", for: .normal)
    }
    
    
    @objc
    private func statusTextChanged(_ textField: UITextField){
        statusText.text = textField.text ?? statusText.text
    }
    //Добавил изменение текста на кнопке в "Set status" согласно макету
    @objc
    private func titleButtonShowStatusChange(){
        buttonShowStatus.setTitle("Set status", for: .normal)
    }
    
    
    // MARK: - Constraints
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            userPhoto.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            userPhoto.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            userPhoto.widthAnchor.constraint(equalToConstant: 110),
            userPhoto.heightAnchor.constraint(equalToConstant: 110),
            
            userName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
            userName.heightAnchor.constraint(equalToConstant: 18),
            userName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            buttonShowStatus.topAnchor.constraint(equalTo: self.userPhoto.bottomAnchor, constant: 31), //было значение 16
            buttonShowStatus.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            buttonShowStatus.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            buttonShowStatus.heightAnchor.constraint(equalToConstant: 50),
            buttonShowStatus.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            userStatus.bottomAnchor.constraint(equalTo: self.buttonShowStatus.topAnchor, constant: -59), // было значение -34
            userStatus.heightAnchor.constraint(equalToConstant: 14),
            userStatus.leftAnchor.constraint(equalTo: self.userName.leftAnchor, constant: 0),
            
            changeUserStatus.topAnchor.constraint(equalTo: self.userStatus.bottomAnchor, constant: 10),
            changeUserStatus.leftAnchor.constraint(equalTo: self.userStatus.leftAnchor, constant: 0),
            changeUserStatus.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            changeUserStatus.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
}
