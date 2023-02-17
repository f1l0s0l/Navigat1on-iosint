//
//  PlanetDetailsTableViewCell.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 17.02.2023.
//

import Foundation
import UIKit

final class PlanetDetailsViewController: UIViewController {
    
    // MARK: - Properties

    private let namePlanet: String
    
    
    // MARK: - Life cycle
    
    init(namePlanet: String) {
        self.namePlanet = namePlanet
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
