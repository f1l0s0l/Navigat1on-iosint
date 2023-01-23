//
//  Checker.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 20.01.2023.
//

import Foundation


public class Checker {
    static let shared = Checker()
    
    #if DEBUG
    private let logIn = ""
    private let password = ""
    #else
    private let logIn = "aria1401"
    private let password = "qwe"
    #endif
    
    private init() {}
    
    func check(logIn: String?, password: String?) -> Bool {
        logIn == self.logIn && password == self.password
    }
    
    
}
