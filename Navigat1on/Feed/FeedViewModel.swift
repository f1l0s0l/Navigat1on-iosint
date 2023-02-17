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
        case loading
        case loadedFirstTextLabel(text: String)
        case loadedSecondTextLabel(text: String)
        case wrong(text: String)
        case error
    }
    
    enum Action {
        case didTapDownloadDataButton
        case didTapShowNameResidentsButton
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
    private var residents: [String] = []
    
    // MARK: - Life cycle
    
    init(coordinator: Coordinatable) {
        self.coordinator = coordinator
    }
    
    
    // MARK: - Public methods
    
    func didTap(action: Action) {
        switch action {
        case .didTapDownloadDataButton:
            self.state = .loading
            
            FeedNetworkService1.request { [weak self] text in
                self?.state = .loadedFirstTextLabel(text: text)
            }
            FeedNetworkService2.request { [weak self] text, residents in
                self?.state = .loadedSecondTextLabel(text: text)
                self?.residents = residents
            }
            
        case .didTapShowNameResidentsButton:
            guard residents.count != 0 else {
                self.state = .wrong(text: "Нет данных")
                return
            }
            (self.coordinator as? FeedCoordinator)?.pushNameResidentsViewController(residents: self.residents)
        }
    }
    
    
}
