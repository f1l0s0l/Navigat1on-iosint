//
//  PhotosTableViewCell.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 19.01.2023.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Photos"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.right" ), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var firstPhotoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.image = UIImage(named:  "logo")
        return imageView
    }()
    
    private lazy var secondPhotoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    private lazy var thirdPhotoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    private lazy var fourthPhotoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    

    // MARK: - Life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public
    
    func setup(withPhoto photos: [String]){
        for (index, photo) in photos.enumerated() {
            switch index {
            case 0:
                self.firstPhotoImage.image = UIImage(named: photo)
            case 1:
                self.secondPhotoImage.image = UIImage(named: photo)
            case 2:
                self.thirdPhotoImage.image = UIImage(named: photo)
            case 3:
                self.fourthPhotoImage.image = UIImage(named: photo)
            default:
                break
            }
        }
    }

    
    // MARK: - Methods
    
    private func setupView() {
        self.backgroundColor = .white
        self.addSubview(titleLabel)
        self.addSubview(nextButton)
        self.addSubview(stackView)
        self.stackView.addArrangedSubview(firstPhotoImage)
        self.stackView.addArrangedSubview(secondPhotoImage)
        self.stackView.addArrangedSubview(thirdPhotoImage)
        self.stackView.addArrangedSubview(fourthPhotoImage)
        self.setupConstraints()
    }
    
    
    // MARK: - COnstraints

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            titleLabel.bottomAnchor.constraint(equalTo: self.stackView.topAnchor, constant: -12),
            
            nextButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
            nextButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
            
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            stackView.heightAnchor.constraint(equalToConstant: (self.frame.width - 48) / 4 + 24 + self.titleLabel.frame.height),
        ])
    }
    
}

