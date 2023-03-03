//
//  Checker.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 03.03.2023.
//

import Foundation

final class CheckerPassword {
    
    func checkAuthData(login: String?, pswrd: String?, completion: @escaping (User?) -> Void) {
        // тут можно делать проверки на валидность email, слабый пароль, и так далее
        guard let login = login,
              let pswrd = pswrd
        else {
            return completion(nil)
        }
        
        RealmManager.shared.addCurrentUser(login: login, password: pswrd) { user in
            completion(user)
        }
    }
    
    
}
