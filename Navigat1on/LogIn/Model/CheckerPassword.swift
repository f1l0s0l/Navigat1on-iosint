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
        
        // Тут можно и без перехода на другой поток желать, но я заметил
        // Что на авторизацию тратиьься доли секунды, и без перехода на другой поток
        // Не запускается анимация ожидания (activityIndicator)
        // а так все работает плавно
        
        DispatchQueue.global().async {
            RealmManager.shared.addCurrentUser(login: login, password: pswrd) { user in
                DispatchQueue.main.async {
                    
                    guard let user = user else {
                        return completion(nil)
                    }
                    completion(user)
                }
                
            }
        }
        
    }
    
}
