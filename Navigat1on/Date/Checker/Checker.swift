//
//  Checker.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 20.01.2023.
//

import Foundation
import UIKit


public class Checker {
    static let shared = Checker()
    
    
    enum Resault {
        case success(user: User)
        case wrongLogIn
        case wrongPswrd
        case noLogInData
    }
    

    
    #if DEBUG
    private var userServise = TestUserServise()
//    private let userLogIn = ""
    private let userPswrd = ""
    #else
    private var userServise = CurrentUserServise(user: User(login: "aria1401",
                                          fullName: "Ария",
                                          avatar: UIImage(named: "19"),
                                          status: "У меня вылез новый фуб")
    )
//    private let userLogIn = "aria1401"
    private let userPswrd = "qwe"
    #endif
    
    private init() {}
    
    func check(logIn: String?, pswrd: String?) -> Resault {
//        sleep(3)                          
       
        guard let user = userServise.checkLogin(login: logIn) else {
            return .wrongLogIn
        }
        
        guard pswrd == self.userPswrd else {
            return .wrongPswrd
        }
        
        return .success(user: user)
    }
    
}
