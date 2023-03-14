//
//  RealmManager.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 03.03.2023.
//

import Foundation
import RealmSwift
import UIKit
import KeychainAccess

final class RealmManager {
    static let shared = RealmManager()
    
    
    // MARK: - Public methods
    
    func userIsLogin() -> User? {
        guard let realmm = self.getRealm(),
              let currentUser = realmm.objects(CurrentUser.self).first,
              currentUser.isLogin
        else {
            return nil
        }
        
        let user = User(
            fullName: currentUser.name,
            avatar: UIImage(data: currentUser.imageData),
            status: currentUser.status
        )
        return user
    }
    
    
    func addCurrentUser(login: String, password: String, completion: @escaping (User?) -> Void) {
        guard let realm = self.getRealm() else {
            return completion(nil)
        }
        let currentUser = CurrentUser(login: login, password: password)
        do {
            try realm.write {
                realm.add(currentUser)
            }
        } catch {
            print(error)
            return completion(nil)
        }
        
        let user = User(
            fullName: currentUser.name,
            avatar: UIImage(data: currentUser.imageData),
            status: currentUser.status
        )
        return completion(user)
    }
    
    
    
    // MARK: - Methods
    
    private func addNewValue(key: String, for keychain: Keychain) {
        let valueDataString = UUID().uuidString
        let valueData = Data(valueDataString.utf8)
        do {
            try keychain.set(valueData, key: key)
        } catch {
            print(error)
        }
    }
    
    private func getConfigKey() -> Data? {
        let key = "configKeyData"
        let keychain = Keychain(service: "configKey")
        
        do {
            return try keychain.getData(key)
        } catch {
            self.addNewValue(key: key, for: keychain)
            return nil
        }
    }
    
    
    private func getRealm() -> Realm? {
        var config = Realm.Configuration.defaultConfiguration
        config.encryptionKey = self.getConfigKey()
        
        do {
           return try Realm(configuration: config)
        } catch let error as NSError {
            print(error)
            return nil
        }
    }
    
}
