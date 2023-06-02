//
//  FeedViewModel.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation

protocol IFeedViewModel {
    var stateChenged: ((FeedViewModel.State) -> Void)? { get set }
    func didTapDownloadDataButton()
    func didTapShowNameResidentsButton()
}

final class FeedViewModel {
    
    enum State {
        case initial
        case loading
        case loadedFirstTextLabel(text: String)
        case loadedSecondTextLabel(text: String)
        case wrong(text: String)
        case error
    }
    
    
    // MARK: - Public Properties
    
    var stateChenged: ((State) -> Void)?
    
    
    // MARK: - Private properties
    
    private weak var coordinator: IFeedCoordinator?
    
    private var residents: [String] = []
    
    private(set) var state: State = .initial {
        didSet {
            self.stateChenged?(self.state)
        }
    }
    
    
    // MARK: - Init
    
    init(coordinator: IFeedCoordinator?) {
        self.coordinator = coordinator
    }
    
}



    // MARK: - IFeedViewModel
extension FeedViewModel: IFeedViewModel {
    
    func didTapDownloadDataButton() {
        self.state = .loading
        
        FeedNetworkService1.request { [weak self] text in
            self?.state = .loadedFirstTextLabel(text: text)
        }
        FeedNetworkService2.request { [weak self] text, residents in
            self?.state = .loadedSecondTextLabel(text: text)
            self?.residents = residents
        }
    }
    
    
    func didTapShowNameResidentsButton() {
        guard residents.count != 0 else {
            self.state = .wrong(text: "Нет данных")
            return
        }
        self.coordinator?.pushNameResidentsViewController(residents: self.residents)
    }
}
