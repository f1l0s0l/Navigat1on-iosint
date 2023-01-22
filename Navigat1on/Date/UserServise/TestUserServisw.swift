//
//  TestUserServisw.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 20.01.2023.
//

import Foundation
import UIKit


class TestUserServise: UserServise {
    
    let user = User(login: "",
                    fullName: "TestLogin",
                    avatar: UIImage(systemName: "person.fill.questionmark"),
                    status: "TestStatus"
    )
    
    func checkLogin(login: String?) -> User? {
        if login  == self.user.login {
            return user
        }
        
        return nil
    }

}
