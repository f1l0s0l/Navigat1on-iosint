//
//  Model.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 03.03.2023.
//

import Foundation
import RealmSwift
import UIKit

final class CurrentUser: Object {
    @Persisted var login: String
    @Persisted var passwrod: String
    @Persisted var isLogin: Bool = true
    @Persisted var name: String
    @Persisted var status: String = ""
    @Persisted var imageData: Data
    
    convenience init(login: String, password: String) {
        self.init()
        self.login = login
        self.passwrod = password
        self.name = login
    }
}
