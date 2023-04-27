//
//  PostTableViewCell.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 19.01.2023.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    weak var parentTableView: ProfileViewController?
    
    // MARK: - Properties
    
    private let likeFormatterString = NSLocalizedString("likes", comment: "")
    private let viewsFormatterString = NSLocalizedString("views", comment: "")
    
    private var thisPost: PostView?
    var isFavourites: Bool = false
    
    private lazy var titleView: UIView = {
        let view = UIView()
//        view.backgroundColor = .white
        view.backgroundColor = ColorConstant.backgroundCell
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
//        label.textColor = .black
        label.textColor = ColorConstant.label
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.backgroundColor = .black
        imageView.backgroundColor = ColorConstant.backgroundPostImageView
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var addFavouritePostImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "heart"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        return imageView
    }()
    
    private lazy var footerView: UIView = {
        let view = UIView()
//        view.backgroundColor = .white
        view.backgroundColor = ColorConstant.backgroundCell
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var footerTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
//        label.textColor = .systemGray
        label.textColor = ColorConstant.secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var likesCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
//        label.textColor = .black
        label.textColor = ColorConstant.label
        return label
    }()
    
    private lazy var viewsCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
//        label.textColor = .black
        label.textColor = ColorConstant.label
        return label
    }()
    
    
    // MARK: - Life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupTableViewCell()
        self.setupConstraints()
        self.setupGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public Methods
    
    func setup(withPost post: PostView) {
        self.thisPost = post
        
        
        self.titleTextLabel.text = thisPost?.author
        self.postImageView.image = thisPost?.image
        self.footerTextLabel.text = thisPost?.description
        
        self.likesCountLabel.text = String(format: self.likeFormatterString, post.likes)
        self.viewsCountLabel.text = String(format: self.viewsFormatterString, post.views)
//        self.likesCountLabel.text = "Likes: \(thisPost?.likes ?? 0)"
//        self.viewsCountLabel.text = "Views: \(thisPost?.views ?? 0)"
    }
    
    
    // MARK: - Methods

    private func setupTableViewCell(){
        self.contentView.addSubview(self.titleView)
        self.contentView.addSubview(self.postImageView)
        self.contentView.addSubview(self.addFavouritePostImage)
        self.contentView.addSubview(self.footerView)

        self.titleView.addSubview(self.titleTextLabel)
        self.footerView.addSubview(self.footerTextLabel)
        self.footerView.addSubview(self.likesCountLabel)
        self.footerView.addSubview(self.viewsCountLabel)
    }
    
    private func setupGestureRecognizer() {
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTapAction))
        doubleTapGesture.numberOfTapsRequired = 2
        
        self.contentView.addGestureRecognizer(doubleTapGesture)
    }
    
    @objc
    private func doubleTapAction() {
        guard let thisPost = thisPost else {
            return
        }
        if self.isFavourites == false {
            CoreDataManager.shared.addFavourite(post: thisPost) { [weak self] textError in
                DispatchQueue.main.async {
                    if let textError = textError, let parentTableView = self?.parentTableView {
                        AlertNotification.shared.defaultAlertNotification(text: textError, viewController: parentTableView)
                    } else {
                        UIView.animate(
                            withDuration: 0.4,
                            delay: 0,
                            options: [.curveEaseInOut],
                            animations: {
                                self?.addFavouritePostImage.alpha = 1
                            }) { _ in
                                self?.addFavouritePostImage.alpha = 0
                            }
                    }
                }
            }
        }
    }
    
    
    // MARK: - Constraints

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            titleView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            titleView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            
            titleTextLabel.topAnchor.constraint(equalTo: self.titleView.topAnchor, constant: 16),
            titleTextLabel.leftAnchor.constraint(equalTo: self.titleView.leftAnchor, constant: 10),
            titleTextLabel.rightAnchor.constraint(equalTo: self.titleView.rightAnchor, constant: -10),
            titleTextLabel.bottomAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: -12),
            
            postImageView.topAnchor.constraint(equalTo: self.titleView.bottomAnchor),
            postImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            postImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: self.contentView.bounds.width),
            
            addFavouritePostImage.topAnchor.constraint(equalTo: self.titleView.bottomAnchor),
            addFavouritePostImage.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            addFavouritePostImage.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            addFavouritePostImage.heightAnchor.constraint(equalToConstant: self.contentView.bounds.width),
            
            footerView.topAnchor.constraint(equalTo: self.postImageView.bottomAnchor),
            footerView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            footerView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            footerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            footerTextLabel.topAnchor.constraint(equalTo: self.footerView.topAnchor, constant: 16),
            footerTextLabel.leftAnchor.constraint(equalTo: self.footerView.leftAnchor, constant: 16),
            footerTextLabel.rightAnchor.constraint(equalTo: self.footerView.rightAnchor, constant: -16),

            likesCountLabel.topAnchor.constraint(equalTo: self.footerTextLabel.bottomAnchor, constant: 16),
            likesCountLabel.leftAnchor.constraint(equalTo: self.footerView.leftAnchor, constant: 16),
            likesCountLabel.bottomAnchor.constraint(equalTo: self.footerView.bottomAnchor, constant: -16),
            
            viewsCountLabel.rightAnchor.constraint(equalTo: self.footerView.rightAnchor, constant: -16),
            viewsCountLabel.centerYAnchor.constraint(equalTo: self.likesCountLabel.centerYAnchor),
            viewsCountLabel.bottomAnchor.constraint(equalTo: self.footerView.bottomAnchor, constant: -16),
        ])
    }
    
}
