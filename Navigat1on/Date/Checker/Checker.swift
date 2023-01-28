//
//  Checker.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 20.01.2023.
//

import Foundation


public class Checker {
    static let shared = Checker()
    
    
    enum Resault {
        case success
        case wrongLogIn
        case wrongPswrd
        case noLogInData
    }
    

    
    #if DEBUG
    private var userServise = TestUserServise()
//    private let userLogIn = ""
    private let userPswrd = ""
    #else
    private var userServise = CurrentUserServise(User(login: "aria1401",
                                          fullName: "Ария",
                                          avatar: UIImage(named: "19"),
                                          status: "У меня вылез новый фуб")
    )
//    private let userLogIn = "aria1401"
    private let userPswrd = "qwe"
    #endif
    
    private init() {}
    
    func check(logIn: String?, pswrd: String?) -> Resault {
        sleep(3)
        guard logIn == "" else {
            return .noLogInData
        }
        guard userServise.checkLogin(login: logIn) != nil else {
            return .wrongLogIn
        }
        guard pswrd == self.userPswrd else {
            return .wrongPswrd
        }
        return .success
    }
    
}
