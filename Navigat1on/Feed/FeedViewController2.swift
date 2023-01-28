//
//  FeedViewController.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation
import UIKit

final class FeedViewController2: UIViewController {
    
    // MARK: - Properties
    
    let viewModel: FeedViewModel
    
    
    // MARK: - Life cycle
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
    }
    
    
}
