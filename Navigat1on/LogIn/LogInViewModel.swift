//
//  LogInViewModel.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation

protocol LogInViewControllerDelegate: AnyObject {
    func checkCredentials(logIn: String?, pswrd: String?, completion: @escaping (CheckerError?) -> Void)
    func signUp(logIn: String?, pswrd: String?, completion: @escaping (CheckerError?) -> Void)
    func addStateDidChangeListener(completion: @escaping (User?) -> Void)
}


final class LogInViewModel {
    
    enum StateKeyboard {
        case didShowKeyboard(frameScrollView: Any, frameBottomItems: Any )
        case didHideKeyboard
    }
    
    enum Action {
        case didTapButton(log: String?, pswrd: String?)
        case didTabSignUpButton(log: String?, pswrd: String?)
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


            (self.coordinator as? LogInCoordinator)?.logInInspectorDelegate?.checkCredentials(
                logIn: log,
                pswrd: pswrd
            ) { [weak self] error in
                DispatchQueue.main.async {
                    guard let error = error else {
                        self?.state = .loaded
                        return
                    }
                    self?.state = .loaded
                    self?.state = .wrong(text: error.description)
                }
            }
            
        case .didTabSignUpButton(let log, let pswrd):
            self.state = .loading
            self.state = .HideKeyboard
            (self.coordinator as? LogInCoordinator)?.logInInspectorDelegate?.signUp(
                logIn: log,
                pswrd: pswrd
            ) { [weak self] error in
                guard let error = error else {
                    self?.state = .loaded
                    return
                }
                self?.state = .loaded
                self?.state = .wrong(text: error.description)
            }

        case .didTapSuperView:
            self.state = .HideKeyboard
            
        }
        
    }
    
    func keyboardNotification(_ stateKeyboard: ServiseContentOfSet.StateKayboard, _ notification: Notification) {
        let y = self.servise.ServiseContentOfSet(notification, stateKayboard: stateKeyboard)
        self.state = .changeContentOffset(yPoint: y)
    }
    
}
