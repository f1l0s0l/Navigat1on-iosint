//
//  FeedViewModel.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation

final class FeedViewModel {
    
    
    enum State {
        case initial
//        case loading
        case error
    }
    
    enum Action {
        case didTapShowStarWarsFlow
    }
    
    
    // MARK: - Public Properties
    
    var stateChenged: ((State) -> Void)?
    private(set) var state: State = .initial {
        didSet {
            stateChenged?(state)
        }
    }
    
    
    // MARK: - Properties
    
    private let coordinator: Coordinatable
    
    // MARK: - Life cycle
    
    init(coordinator: Coordinatable) {
        self.coordinator = coordinator
    }
    
    
    // MARK: - Public methods
    
    func didTap(action: Action) {
        switch action {
        case .didTapShowStarWarsFlow:
            (self.coordinator as? FeedCoordinator)?.pushStartStarWarsViewController()
      
        }
    }
    
    
}
