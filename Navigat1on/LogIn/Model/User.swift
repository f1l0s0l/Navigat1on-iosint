//
//  User.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import UIKit

class User {
    
    var fullName: String
    var avatar: UIImage?
    var status: String
    
    init(fullName: String, avatar: UIImage?, status: String) {
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
    
}
