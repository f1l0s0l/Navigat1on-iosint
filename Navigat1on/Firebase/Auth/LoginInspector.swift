//
//  LoginInspector.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 20.01.2023.
//
//
import Foundation

class LoginInspector {
    private var checkerServise: CheckerServiceProtocol
    
    init(checkerServise: CheckerServiceProtocol) {
        self.checkerServise = checkerServise
    }
}


extension LoginInspector: LogInViewControllerDelegate {
    
    func addStateDidChangeListener(completion: @escaping (User?) -> Void) {
        self.checkerServise.addStateDidChangeListener(completion: completion)
    }
    
    func checkCredentials(logIn: String?, pswrd: String?, completion: @escaping (CheckerError?) -> Void) {
        self.checkerServise.checkCredentials(logIn: logIn, pswrd: pswrd, completion: completion)
    }
    
    func signUp(logIn: String?, pswrd: String?, completion: @escaping (CheckerError?) -> Void) {
        self.checkerServise.signUp(logIn: logIn, pswrd: pswrd, completion: completion)
    }
    
}
