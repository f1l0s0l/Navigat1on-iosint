//
//  CurrentUserServise.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import UIKit

class CurrentUserServise: UserServise {
    
    private let user: User
    
    func checkLogin(login: String?) -> User? {
        if login  == self.user.login {
            return user
        }
        
        return nil
    }
    
    init(user: User) {
        self.user = user
    }
    
}
