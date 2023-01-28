//
//  LogInViewModel.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation

protocol LogInCheckerProtocol {
    func check(log: String?, pasw: String?) -> Bool
}

protocol LogInVerificationDelegate: AnyObject {

}



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

//    var stateKeyboardChenged: ((StateKeyboard) -> Void)?
//    private(set) var stateKeyboard: StateKeyboard = .initial {
//        didSet {
//            stateKeyboardChenged?(stateKeyboard)
//        }
//    }
    
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
    
    
    // MARK: - Life cycle
    
    init(coordinator: Coordinatable) {
        self.coordinator = coordinator
    }
    
    
    // MARK: - Public methods
    
    func didTap(action: Action) {
        switch action {
        case .didTapButton(let log, let pswrd):
            state = .loading
            sleep(2)
            state = .loaded
            let result = Checker.shared.check(logIn: log, pswrd: pswrd)
            
            switch result {
            case .success:
                state = .loaded
                (coordinator as? LogInCoordinator)?.pushMainTabBarController()
            case .noLogInData:
//                state = .loaded
                state = .wrong(text: "Введите логин")
            case .wrongLogIn:
//                state = .loaded
                state = .wrong(text: "Неправильный логин")
            case .wrongPswrd:
//                state = .loaded
                state = .wrong(text: "Неправильный пароль")
            }
            
            
        case .didTapSuperView:
            state = .HideKeyboard
        }
    }
    
    
    
    
    //!!!!!!!!!!!!!!!!!!!
    func keyboardNotification(_ stateKeyboard: ServiseContentOfSet.StateK, _ notification: Notification) {
        
        let t = self.servise.ServiseContentOfSet(notification, stateK: stateKeyboard)
        self.state = .changeContentOffset(yPoint: t)
    }
    
    
    
    
    // MARK: - Properties
    
    #if DEBUG
    var userServise: UserServise?
    #else
    var userServise = CurrentUserServise(user: User(login: "aria1401",
                                                    fullName: "Ария",
                                                    avatar: UIImage(named: "19"),
                                                    status: "У меня вылез новый фуб")
    )
    #endif
 
    
    let coordinator: Coordinatable
    
    private let servise = ServiseContentOfSet()
    
//    private weak var logInViewControlle: LogInViewController2?
    
    private var logInChecker: LogInCheckerProtocol?
    
    
    
    
    
    
    
    
    
}
