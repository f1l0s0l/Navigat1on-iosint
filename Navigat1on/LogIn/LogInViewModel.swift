//
//  LogInViewModel.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation

final class LogInViewModel {
    
    enum StateKeyboard {
        case didShowKeyboard(frameScrollView: Any, frameBottomItems: Any )
        case didHideKeyboard
    }
    
    enum Action {
        case didTapButton(log: String?, pswrd: String?)
        case didTapSuperView
    }
    
    enum State {
        case initial
        case loading
        case loaded
        case changeContentOffset(yPoint: Double)
        case HideKeyboard
        case wrong(text: String)
        case error
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
    private let servise = ServiseContentOfSet()
    
    
    // MARK: - Life cycle
    
    init(coordinator: Coordinatable) {
        self.coordinator = coordinator
    }
    
    
    // MARK: - Public methods
    
    func didTap(action: Action) {
        switch action {
            
        case .didTapButton(let log, let pswrd):
            self.state = .loading
            self.state = .HideKeyboard
            
            Checker.shared.check(logIn: log, pswrd: pswrd) { [weak self] result in
                DispatchQueue.main.sync {
                    switch result {
                    case .success(let user):
                        self?.state = .loaded
                        (self?.coordinator as? LogInCoordinator)?.pushMainTabBarController(user: user)
                        
                    case .failure(let error):
                        self?.state = .loaded
                        self?.state = .wrong(text: error.description)
                    }
                }
            }

        case .didTapSuperView:
            self.state = .HideKeyboard
            
        }
        
    }
    
    func keyboardNotification(_ stateKeyboard: ServiseContentOfSet.StateK, _ notification: Notification) {
        let y = self.servise.ServiseContentOfSet(notification, stateK: stateKeyboard)
        self.state = .changeContentOffset(yPoint: y)
    }
    
}
