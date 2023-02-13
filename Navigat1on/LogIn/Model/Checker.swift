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
    
    enum CheckerError: Error {
        case wrongLogIn
        case wrongPswrd
        case noLogInData
        case unknowError
    }
    
    #if DEBUG
    private var userServise = TestUserServise()
    private let userPswrd = "q"
    #else
    private var userServise = CurrentUserServise(user: User(login: "aria1401",
                                          fullName: "Ария",
                                          avatar: UIImage(named: "19"),
                                          status: "У меня вылез новый фуб")
    )
    private let userPswrd = "qwe"
    #endif
    
    
    private init() {}
    
    
    func check(
        logIn: String?,
        pswrd: String?,
        completion: @escaping (Result<User, CheckerError>) -> Void
    ) {
        
        DispatchQueue.global(qos: .utility).async {
            sleep(3)
            do {
                try completion(.success(self.checker(logIn: logIn, pswrd: pswrd)))
            }
            catch CheckerError.noLogInData {
                completion(.failure(.noLogInData))
            }
            catch CheckerError.wrongLogIn {
                completion(.failure(.wrongLogIn))
            }
            catch CheckerError.wrongPswrd {
                completion(.failure(.wrongPswrd))
            }
            catch {
                completion(.failure(.unknowError))
            }
            
        }
    }
    
    private func checker(logIn: String?, pswrd: String?) throws -> User {
        guard logIn != "" else {
            throw CheckerError.noLogInData
        }
        
        guard let user = userServise.checkLogin(login: logIn) else {
            throw CheckerError.wrongLogIn
        }

        guard pswrd == self.userPswrd else {
            throw CheckerError.wrongPswrd
        }

        return user
    }

}

extension Checker.CheckerError: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .wrongLogIn:
            return "Неправильный логин"
        case .wrongPswrd:
            return "Неправильный пароль"
        case .noLogInData:
            return "Введите логин"
        case .unknowError:
            return "Неизвестная ошибка"
        }
    }

}


