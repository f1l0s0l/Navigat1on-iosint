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
//        case didTabSignUpButton(log: String?, pswrd: String?)
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
    private let serviseContentOfSet = ServiseContentOfSet()
    private let checkerPassword = CheckerPassword()
    
    
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
            
            self.checkerPassword.checkAuthData(login: log, pswrd: pswrd) { [weak self] user in
                guard let user = user else {
                    self?.state = .loaded
                    self?.state = .wrong(text: "Неизвестная ошибка")
                    return
                }
                self?.state = .loaded
                (self?.coordinator as? CoordinatableLogin)?.switchToTabBarController(user: user)
                
            }
            
//        case .didTabSignUpButton(let log, let pswrd):
//            self.state = .loading
//            self.state = .HideKeyboard
            

        case .didTapSuperView:
            self.state = .HideKeyboard
            
        }
        
    }
    
    func keyboardNotification(_ stateKeyboard: ServiseContentOfSet.StateKayboard, _ notification: Notification) {
        let y = self.serviseContentOfSet.ServiseContentOfSet(notification, stateKayboard: stateKeyboard)
        self.state = .changeContentOffset(yPoint: y)
    }
    
}
