//
//  Checker.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 20.01.2023.
//

import Foundation
import UIKit
import FirebaseAuth

protocol CheckerServiceProtocol: AnyObject {
    
    func signUp(logIn: String?, pswrd: String?, completion: @escaping (CheckerError?) -> Void)
    func checkCredentials(logIn: String?, pswrd: String?, completion: @escaping (CheckerError?) -> Void)
    func addStateDidChangeListener(completion: @escaping (User?) -> Void)
    
}

enum CheckerError: Error {
    case invalidEmail
    case wrongPswrd
    case userNotFound
    case unknowError
    case weakPswrd
    case emailAlreadyInUse
}

class CheckerService {
////    func signUp(logIn: String?, pswrd: String?, completion: @escaping (Error?) -> Void) {
////        <#code#>
////    }
////
////    func checkCredentials(logIn: String?, pswrd: String?, completion: @escaping (Result<User, Error>) -> Void) {
////        <#code#>
////    }
//
////    static let shared = Checker()
//
////    enum CheckerError: Error {
////        case invalidEmail
////        case wrongPswrd
////        case userNotFound
////        case unknowError
////    }
//
////    #if DEBUG
////    private var thisUser = User(
////        login: "test@gmail.com",
////        fullName: "Test User",
////        avatar: nil,
////        status: "Test status",
////        userID: "8qFExiZ0lTWSQeRSSaewBFVHbSo1"
////    )
////    private let userPswrd = "qwerty"
////    #else
////    private var thisUser = User(
////        login: "aria1401@gmail.ru",
////        fullName: "Ария",
////        avatar: UIImage(named: "19"),
////        status: "У меня вылез новый фуб",
////        userID: "eapTua2EHQR0QMN6WKSBRzCwEoe2"
////    )
////    private let userPswrd = "qwerty"
////    #endif
//
//
////    private init() {}
//    //
//    // это скорее всего будет статическая переменная
////    var isLogin: Bool = false
//
//
//    func signUp(logIn: String?, pswrd: String?, completion: @escaping (CheckerError?) -> Void) {
//        Auth.auth().createUser(withEmail: logIn!, password: pswrd!) { authDataResult, error in
//
//            if let error = error {
//                let nsError = error as NSError
//                switch nsError.code {
//
////                case AuthErrorCode.
////                    ()
//
//                default:
//                    completion(.unknowError)
//                }
//
//            } else {
//                guard let changeRequest = authDataResult?.user.createProfileChangeRequest() else {
//                    completion(.unknowError)
//                    return
//                }
//                changeRequest.displayName = "Новый пользователь"
//                changeRequest.commitChanges { error in
//                    guard let error = error else {
//                        print("Ошибки нет")
//                        completion(nil)
//                        return
//                    }
//                    print("Ошибка: \(error)")
//                }
//
//            }
//
////            guard let changeRequest = authDataResult?.user.createProfileChangeRequest() else {
////                return
////            }
////            print("в измерения попали")
//////            let t: String? = "@gmail.com"
////            changeRequest.displayName = "Новый пользователь"
////            changeRequest.commitChanges { error in
////                guard let error = error else {
////                    print("Ошибки нет")
////                    return
////                }
////                print("Ошибка: \(error)")
////            }
//
////            authDataResult?.user.
//
//        }
//    }
//
//
//    func checkCredentials(logIn: String?, pswrd: String?, completion: @escaping (CheckerError?) -> Void) {
//        print("мы в  череке, метод checkCredentials")
//        guard let logIn = logIn,
//              let pswrd = pswrd
//        else {
//            return
//        }
//
//        Auth.auth().signIn(withEmail: logIn, password: pswrd) {authResult, error in
//            sleep(5)
//            if let error = error {
//                print(error.localizedDescription)
//
//                let nsError = error as NSError
//                switch nsError.code {
//
//                case AuthErrorCode.userNotFound.rawValue:
//                    completion(.userNotFound)
//
//                case AuthErrorCode.invalidEmail.rawValue:
//                    completion(.invalidEmail)
//
//                case AuthErrorCode.wrongPassword.rawValue:
//                    completion(.wrongPswrd)
//
//                default:
//                    completion(.unknowError)
//                }
//
//            } else {
//                //Идем Дальше
    //                guard  authResult != nil//,
////                       self.thisUser.userID == authResult.user.uid
//                else {
//                    completion(.unknowError)
//                    return
//                }
//                completion(nil)
//            }
//
//
//        }
//
//
//
//    }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//    //
////
////    func check(
////        logIn: String?,
////        pswrd: String?,
////        completion: @escaping (Result<User, CheckerError>) -> Void
////    ) {
////
////        DispatchQueue.global(qos: .utility).async {
////            sleep(3)
////            do {
////                try completion(.success(self.checker(logIn: logIn, pswrd: pswrd)))
////            }
////            catch CheckerError.noLogInData {
////                completion(.failure(.noLogInData))
////            }
////            catch CheckerError.wrongLogIn {
////                completion(.failure(.wrongLogIn))
////            }
////            catch CheckerError.wrongPswrd {
////                completion(.failure(.wrongPswrd))
////            }
////            catch {
////                completion(.failure(.unknowError))
////            }
////
////        }
////    }
////
////    private func checker(logIn: String?, pswrd: String?) throws -> User {
////        guard logIn != "" else {
////            throw CheckerError.noLogInData
////        }
////
////        guard let user = userServise.checkLogin(login: logIn) else {
////            throw CheckerError.wrongLogIn
////        }
////
////        guard pswrd == self.userPswrd else {
////            throw CheckerError.wrongPswrd
////        }
////
////        return user
////    }

}

extension CheckerError: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .invalidEmail:
            return "Неправильный формат логина"
        case .wrongPswrd:
            return "Неправильный пароль"
        case .userNotFound:
            return "Нет такого пользователя"
        case .unknowError:
            return "Неизвестная ошибка"
        case .weakPswrd:
            return "Ваш пароль меньше 6 символов"
        case .emailAlreadyInUse:
            return "Этот электронный адрес уже занят"
        }
    }

}

extension CheckerService: CheckerServiceProtocol {
    
    func addStateDidChangeListener(completion: @escaping (User?) -> Void) {
        Auth.auth().addStateDidChangeListener { _, user in
            guard let user = user else {
                completion(nil)
                return
            }
            let newUser = User(
                fullName: user.email ?? "Имя",
                avatar: nil,
                status: user.uid,
                userID: user.uid
            )
            completion(newUser)
        }
    }
    
    
    func signUp(logIn: String?, pswrd: String?, completion: @escaping (CheckerError?) -> Void) {
        
        Auth.auth().createUser(withEmail: logIn!, password: pswrd!) { authDataResult, error in
            if let error = error {
                let nsError = error as NSError
                switch nsError.code {
                    
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    completion(.emailAlreadyInUse)
                   
                case AuthErrorCode.invalidEmail.rawValue:
                    completion(.invalidEmail)
                    
                case AuthErrorCode.weakPassword.rawValue:
                    completion(.weakPswrd)

//                case AuthErrorCode.emailAlreadyInUse.rawValue:
//                    completion(.emailAlreadyInUse)
                    
                default:
                    completion(.unknowError)
                }
                
            } else {
                completion(nil)
                
            }
     
        }
    
    }

    
    
    
    func checkCredentials(logIn: String?, pswrd: String?, completion: @escaping (CheckerError?) -> Void) {
        print("мы в  череке, метод checkCredentials")
        guard let logIn = logIn,
              let pswrd = pswrd
        else {
            completion(.unknowError)
            return
        }
        
        Auth.auth().signIn(withEmail: logIn, password: pswrd) {authResult, error in
//            sleep(5)
            if let error = error {
                print(error.localizedDescription)

                let nsError = error as NSError
                switch nsError.code {
                    
                case AuthErrorCode.userNotFound.rawValue:
                    completion(.userNotFound)
                    
                case AuthErrorCode.invalidEmail.rawValue:
                    completion(.invalidEmail)
                    
                case AuthErrorCode.wrongPassword.rawValue:
                    completion(.wrongPswrd)
                    
                default:
                    completion(.unknowError)
                }
                
            } else {
                completion(nil)
            }
        }
    }
}
    







