//
//  LogInViewModel.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation
//import UIKit

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
    
    enum StateWronVerification {
        case notWrong
        case wrongLogIn
        case wrongPswrd
    }
    
    // MARK: - Public Properties
    
    var stateChenged: ((State) -> Void)?
    private(set) var state: State = .initial {
        didSet {
            stateChenged?(state)
        }
    }
    
    var stateWronVerification: ((StateWronVerification) -> Void)?
    private(set) var stateWronVerificationChenged: StateWronVerification = .notWrong {
        didSet {
            stateWronVerification?(stateWronVerificationChenged)
        }
    }
    
    
    // MARK: - Properties
    
    private let coordinator: Coordinatable
    private let servise = ServiseContentOfSet()
    
//    #if DEBUG
//    private var userServise: UserServise?
//    #else
//    private var userServise = CurrentUserServise(user: User(login: "aria1401",
//                                                    fullName: "Ария",
//                                                    avatar: UIImage(named: "19"),
//                                                    status: "У меня вылез новый фуб")
//    )
//    #endif
    
    
    // MARK: - Life cycle
    
    init(coordinator: Coordinatable) {
        self.coordinator = coordinator
    }
    
    
    // MARK: - Public methods
    
    func didTap(action: Action) {
        switch action {
        case .didTapButton(let log, let pswrd):
            state = .loading
            sleep(1)
            state = .loaded
            let result = Checker.shared.check(logIn: log, pswrd: pswrd)
            
            switch result {
            case let .success(user):
                print("Логин правильный")
                state = .loaded
                (coordinator as? LogInCoordinator)?.pushMainTabBarController(user: user)
            case .noLogInData:
                state = .wrong(text: "Введите логин")
            case .wrongLogIn:
                state = .wrong(text: "Неправильный логин")
            case .wrongPswrd:
                state = .wrong(text: "Неправильный пароль")
            }
            
        case .didTapSuperView:
            state = .HideKeyboard
        }
    }
    
    
    func keyboardNotification(_ stateKeyboard: ServiseContentOfSet.StateK, _ notification: Notification) {
        let y = self.servise.ServiseContentOfSet(notification, stateK: stateKeyboard)
        self.state = .changeContentOffset(yPoint: y)
    }
    
}
