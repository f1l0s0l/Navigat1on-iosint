//
//  Resident.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 17.02.2023.
//

import Foundation

struct Resident: Codable {
    let name: String
    
    enum CodingKeys: CodingKey {
        case name
    }
}
