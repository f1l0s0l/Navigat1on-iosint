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
        DispatchQueue.global().async {
            guard let login = login,
                  let pswrd = pswrd
            else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            RealmManager.shared.addCurrentUser(login: login, password: pswrd) { user in
                DispatchQueue.main.async {
                    completion(user)
                }
            }
        }
        
    }
    
    
}
