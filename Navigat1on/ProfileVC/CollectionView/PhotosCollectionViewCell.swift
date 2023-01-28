//
//  PhotosCollectionViewCell.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 19.01.2023.
//

//import iOSIntPackage
//import UIKit
//
//class PhotosCollectionViewCell: UICollectionViewCell {
//    
//    // MARK: - Properties
//    
//    private lazy var imageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.clipsToBounds = true
//        imageView.contentMode = .scaleAspectFill
////        imageView.backgroundColor = .systemGray6
//        imageView.backgroundColor = .red
//        return imageView
//    }()
//    
//    
//    // MARK: - Life cycle
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.setupView()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // MARK: - Public
//    
//    func setup(withPhoto photo: UIImage?) {
//        self.imageView.image = photo
//    }
//
//    
//    // MARK: - Methods
//    
//    private func setupView() {
//        self.contentView.addSubview(imageView)
//        self.setupContraints()
//    }
//    
//    
//    // MARK: - Constraints
//
//    private func setupContraints(){
//        NSLayoutConstraint.activate([
//            imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
//            imageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
//            imageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
//            imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
//        ])
//    }
//}
//
