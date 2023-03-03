//
//  test.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 03.03.2023.
//

import Foundation

class NameResidentsViewModel {
    
    enum State {
        case initial
        case loading
        case loaded(resident: [String])
        case error
    }
    
    
    // MARK: - Public Properties
    
    var stateChenged: ((State) -> Void)?
    private(set) var state: State = .initial {
        didSet {
            stateChenged?(state)
        }
    }
    
    
    // MARK: - Properties
    
    private var residents: [String]
    
    
    // MARK: - Life cycle
    
    init(residents: [String]) {
        self.residents = residents
    }
    
    
    // MARK: - Public methods
    
    func startView() {
        self.state = .loading
        var newResidents: [String] = []
        
        let group = DispatchGroup()
        residents.forEach {
            group.enter()
            FeedNetworkService2.loadResidents(url: $0) {name in
                newResidents.append(name)
                group.leave()
            }
        }
        group.notify(queue: .main) { [weak self] in
            self?.state = .loaded(resident: newResidents)
        }
        
    }
    
    
}
