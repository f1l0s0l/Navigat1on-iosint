//
//  PostViewController.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 19.01.2023.
//

import UIKit

class PostViewController: UIViewController {
    
    // MARK: - Properties

    var titlePost: String = ""
  
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    // MARK: - Methods
    
    private func setupView() {
        self.view.backgroundColor = .gray
        self.title = titlePost
        setupBarButtonItem()
    }
    
    private func setupBarButtonItem() {
        let barItem = UIBarButtonItem(image: UIImage(systemName: "folder"), style: .plain, target: self, action: #selector(buttonAction))
        barItem.tintColor = .black
        self.navigationItem.rightBarButtonItem = barItem
    }
    
    @objc
    private func buttonAction() {
        let infoViewController = InfoViewController()
        navigationController?.present(infoViewController, animated: true)
    }

}
