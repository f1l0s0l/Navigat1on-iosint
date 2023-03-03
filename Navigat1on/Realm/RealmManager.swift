//
//  RealmManager.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 03.03.2023.
//

import Foundation
import RealmSwift
import UIKit

final class RealmManager {
    static let shared = RealmManager()
    
    func userIsLogin() -> User? {
        let realm = try! Realm()
        
        let currentUser1 = realm.objects(CurrentUser.self)
        
        switch currentUser1.count {
        case 1:
            let user = currentUser1[0]
            
            if user.isLogin {
                return User(fullName: user.name, avatar: UIImage(data: user.imageData), status: user.status)
            } else {
                return nil
            }
            
        default:
            return nil
        }
        
        
    }
    
    
    func addCurrentUser(login: String, password: String, completion: @escaping (User) -> Void) {
        let currentUser = CurrentUser(login: login, password: password)
        let user = User(
            fullName: currentUser.name,
            avatar: UIImage(data: currentUser.imageData),
            status: currentUser.status
        )
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(currentUser)
        }
        
        completion(user)
    }
    
}
