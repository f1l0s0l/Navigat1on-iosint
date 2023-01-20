//
//  MyLoginFactory.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 20.01.2023.
//

import Foundation

struct MyLoginFactory {
    
}

extension MyLoginFactory: LoginFactory {
    
    func makeLoginInspector() -> LoginInspector {
        LoginInspector()
    }
    
}
