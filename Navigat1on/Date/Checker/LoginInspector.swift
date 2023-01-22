//
//  LoginInspector.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 20.01.2023.
//

import Foundation

struct LoginInspector {
    
}



extension LoginInspector: LogInViewControllerDelegate {
    
    func check(log: String?, pasw: String?) -> Bool {
        return Checker.shared.check(logIn: log, password: pasw)
    }
    
}
