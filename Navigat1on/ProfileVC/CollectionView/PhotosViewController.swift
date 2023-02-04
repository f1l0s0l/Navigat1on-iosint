//
//  PhotosViewController.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 19.01.2023.
//

import iOSIntPackage
import UIKit

class PhotosViewController: UIViewController {

    // MARK: - Constants

    private enum Constants {
        static let numberOfColums: CGFloat = 3
        static let minimumInteritemSpacing: CGFloat = 8
        static let minimumLineSpacing: CGFloat = 8
        static let sectionInset: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    
    // MARK: - Properties
    
    private let publisher = ImagePublisherFacade()
    
    private var thisArrayPhotos: [UIImage] = []
     
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = Constants.minimumInteritemSpacing
        layout.minimumLineSpacing = Constants.minimumLineSpacing
        layout.sectionInset = Constants.sectionInset
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollectionViewCellID")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCellID")
        return collectionView
    }()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraint()
        self.initTimerInPublisher()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.publisher.removeSubscription(for: self)
    }
    
    
    // MARK: - Methods
    
    private func setupView() {
        self.view.backgroundColor = .systemGray6
        self.view.addSubview(collectionView)
    }
    
    private func initTimerInPublisher() {
        publisher.subscribe(self)
        publisher.addImagesWithTimer(time: 1, repeat: 10, userImages: Photos.photos.compactMap({ $0 }) )
    }
    
    
    // MARK: - Constraints

    private func setupConstraint() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
  
}



    // MARK: - Extension UICollectionViewDataSourse

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        Photos.photos.count
        thisArrayPhotos.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCellID", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCellID", for: indexPath)
            cell.backgroundColor = .orange
            return cell
        }
//
//        cell.setup(withPhoto: Photos.photos[indexPath.item])
        if thisArrayPhotos.count != 0 {
            cell.setup(withPhoto: thisArrayPhotos[indexPath.item])
        }

        return cell
    }
}


    // MARK: - Extension UICollectionViewDelegateFlowLayout

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - (Constants.numberOfColums - 1) * Constants.minimumInteritemSpacing - Constants.sectionInset.left - Constants.sectionInset.right
        let itemWidth = (width / Constants.numberOfColums)
         return CGSize(width: itemWidth, height: itemWidth)
    }
    
}


    // MARK: - Extension ImageLibrarySubscriber

extension PhotosViewController: ImageLibrarySubscriber {
    
    func receive(images: [UIImage]) {
        thisArrayPhotos = images
        self.collectionView.reloadData()
    }
}
