//
//  Checker.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 20.01.2023.
//

//import Foundation
//import UIKit
//import FirebaseAuth
//
//protocol CheckerServiceProtocol: AnyObject {
//    
//    func signUp(logIn: String?, pswrd: String?, completion: @escaping (CheckerError?) -> Void)
//    func checkCredentials(logIn: String?, pswrd: String?, completion: @escaping (CheckerError?) -> Void)
//    func addStateDidChangeListener(completion: @escaping (User?) -> Void)
//    
//}
//
//enum CheckerError: Error {
//    case invalidEmail
//    case wrongPswrd
//    case userNotFound
//    case unknowError
//    case weakPswrd
//    case emailAlreadyInUse
//}
//
//extension CheckerError: CustomStringConvertible {
//    
//    public var description: String {
//        switch self {
//        case .invalidEmail:
//            return "Неправильный формат логина"
//        case .wrongPswrd:
//            return "Неправильный пароль"
//        case .userNotFound:
//            return "Нет такого пользователя"
//        case .unknowError:
//            return "Неизвестная ошибка"
//        case .weakPswrd:
//            return "Ваш пароль меньше 6 символов"
//        case .emailAlreadyInUse:
//            return "Этот электронный адрес уже занят"
//        }
//    }
//
//}
//
//
//final class CheckerService {
//
//}
//
//extension CheckerService: CheckerServiceProtocol {
//    
//    func addStateDidChangeListener(completion: @escaping (User?) -> Void) {
//        Auth.auth().addStateDidChangeListener { _, user in
//            guard let user = user else {
//                completion(nil)
//                return
//            }
//            let newUser = User(
//                fullName: user.email ?? "Имя",
//                avatar: nil,
//                status: user.uid,
//                userID: user.uid
//            )
//            completion(newUser)
//        }
//    }
//    
//    
//    func signUp(logIn: String?, pswrd: String?, completion: @escaping (CheckerError?) -> Void) {
//        
//        Auth.auth().createUser(withEmail: logIn!, password: pswrd!) { authDataResult, error in
//            if let error = error {
//                let nsError = error as NSError
//                switch nsError.code {
//                    
//                case AuthErrorCode.emailAlreadyInUse.rawValue:
//                    completion(.emailAlreadyInUse)
//                   
//                case AuthErrorCode.invalidEmail.rawValue:
//                    completion(.invalidEmail)
//                    
//                case AuthErrorCode.weakPassword.rawValue:
//                    completion(.weakPswrd)
//
////                case AuthErrorCode.emailAlreadyInUse.rawValue:
////                    completion(.emailAlreadyInUse)
//                    
//                default:
//                    completion(.unknowError)
//                }
//                
//            } else {
//                completion(nil)
//                
//            }
//     
//        }
//    
//    }
//
//    
//    
//    
//    func checkCredentials(logIn: String?, pswrd: String?, completion: @escaping (CheckerError?) -> Void) {
//        print("мы в  череке, метод checkCredentials")
//        guard let logIn = logIn,
//              let pswrd = pswrd
//        else {
//            completion(.unknowError)
//            return
//        }
//        
//        Auth.auth().signIn(withEmail: logIn, password: pswrd) {authResult, error in
////            sleep(5)
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
//                completion(nil)
//            }
//        }
//    }
//}
//    
//
//
//
//
//
//
//
