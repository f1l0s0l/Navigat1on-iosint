//
//  Planet.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 17.02.2023.
//

import Foundation

struct Planet: Codable {
    let orbitalPeriod: String
    let residentsURL: [String]

    enum CodingKeys: String, CodingKey {
        case orbitalPeriod = "orbital_period"
        case residentsURL = "residents"
    }
}
