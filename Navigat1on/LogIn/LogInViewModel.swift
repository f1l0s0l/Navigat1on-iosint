//
//  LogInViewModel.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation
import UIKit

protocol ILogInViewModel: AnyObject {
    var stateChenged: ((LogInViewModel.State) -> Void)? { get set }
    func checkCanEvaluete()
    func didTapButton(log: String?, pswrd: String?)
    func didTaplocalAuthorizationButton()
}

final class LogInViewModel {
    
    // MARK: - Enum
    
    enum State {
        case loading
        case loaded
        case wrong(text: String)
        case canEvaluete(image: UIImage?)
    }
    
    
    // MARK: - Public Properties
    
    var stateChenged: ((State) -> Void)?
    
    
    // MARK: - Private properties
    
    private weak var coordinator: ILoginCoordinator?
    private let checkerPassword: CheckerPassword
    private let localAuthorizationService: LocalAuthorizationService
    
    private var state: State = .loading {
        didSet {
            self.stateChenged?(state)
        }
    }
    
    
    // MARK: - Init
    
    init(coordinator: ILoginCoordinator, checkerPassword: CheckerPassword, localAuthorizationService: LocalAuthorizationService) {
        self.coordinator = coordinator
        self.checkerPassword = checkerPassword
        self.localAuthorizationService = localAuthorizationService
    }
    
}



    // MARK: - ILogInViewModel

extension LogInViewModel: ILogInViewModel {
    func didTapButton(log: String?, pswrd: String?) {
        self.state = .loading
        
        self.checkerPassword.checkAuthData(login: log, pswrd: pswrd) { [weak self] user in
            guard let user = user else {
                self?.state = .loaded
                self?.state = .wrong(text: "Неизвестная ошибка")
                return
            }
            self?.state = .loaded
            self?.coordinator?.switchToTabBarController(user: user)
            
        }
    }
    
    func didTaplocalAuthorizationButton() {
        self.state = .loaded
        
        self.localAuthorizationService.evaluate { [weak self] isSuccess, error in
            guard isSuccess else {
                self?.state = .wrong(text: error.localizedDescription)
                return
            }
            // Берем авторизированного юзера из реалма (в нашем примере там храняться пользователи)
            // но так как у нас другой функционал, для примера просто создадим пользователя
            // в реалм его добавлять не будетм для того, что бы каждый раз заходя, он требовал опять авторизации
            let user = User(fullName: "ТестЮзер", avatar: nil, status: "ТестСтатус")
            self?.coordinator?.switchToTabBarController(user: user)
        }
    }
    
    func checkCanEvaluete() {
        self.localAuthorizationService.canEvaluate { [weak self] isSuccess, biometryType, error in
            guard isSuccess else {
                return
            }
            
            switch biometryType {
            case .faceID:
                self?.state = .canEvaluete(image: UIImage(systemName: "faceid"))
                
            case .touchID:
                self?.state = .canEvaluete(image: UIImage(systemName: "touchid"))
                
            default:
                ()
            }
        }
    }
}
