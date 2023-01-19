//
//  UserServiswProtocol.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 20.01.2023.
//

import Foundation


protocol UserServise {
    func checkLogin(login: String) -> User?
}
