//
//  FeedModel.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 25.01.2023.
//

import Foundation


protocol FeedModelProtocol: AnyObject {
    func check(word: String?) -> Bool
}

class FeedModel: FeedModelProtocol {
    
    private var passwodr = ""
    
    func check(word: String?) -> Bool {
        word == self.passwodr
    }
    
}
