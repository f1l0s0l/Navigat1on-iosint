//
//  PlanetTableViewCell.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 17.02.2023.
//

import Foundation
import UIKit

final class PlanetTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private lazy var namePlanetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - Life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
        self.setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public methods
    
    func setupConfiguration(namePlanet: String) {
        self.namePlanetLabel.text = namePlanet
    }
    
    
    // MARK: - Methods

    private func setupView() {
        self.addSubview(namePlanetLabel)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            namePlanetLabel.topAnchor.constraint(equalTo: self.topAnchor),
            namePlanetLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            namePlanetLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            namePlanetLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
