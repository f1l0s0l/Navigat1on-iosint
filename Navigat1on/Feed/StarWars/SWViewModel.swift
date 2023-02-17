//
//  SWViewModel.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 17.02.2023.
//

import Foundation

final class StarWarsViewModel {
    
    
    enum State {
        case initial
        case loading
        case loaded
        case error
    }
    
    enum Action {
        case didTabLoadedPlanetInfoButton
    }
    
    
    // MARK: - Public Properties
    
    var stateChenged: ((State) -> Void)?
    private(set) var state: State = .initial {
        didSet {
            stateChenged?(state)
        }
    }
    
    
    // MARK: - Properties
    
    private let coordinator: Coordinatable
    private var residents: [String] = []
    
    // MARK: - Life cycle
    
    init(coordinator: Coordinatable) {
        self.coordinator = coordinator
    }
    
    
    // MARK: - Public methods
    
    func didTap(action: Action) {
        
        switch action {
        case .didTabLoadedPlanetInfoButton:
            self.state = .loading
            
            (self.coordinator as? FeedCoordinator)?.pushPlanetDetailsViewController()
            
        }
       
        
        
        
        
//        switch action {
//        case .didTabLoadedPlanetInfoButton:
//            self.state = .loading
//
//            FeedNetworkService1.request { [weak self] text in
//                self?.state = .loadedFirstTextLabel(text: text)
//            }
//            FeedNetworkService2.request { [weak self] text, residents in
//                self?.state = .loadedSecondTextLabel(text: text)
//                self?.residents = residents
//            }
//
//        case .didTapShowNameResidentsTatooineButton:
//            print(residents.count)
//
//            var newResidents: [String] = []
//
//            let group = DispatchGroup()
//            residents.forEach {
//                group.enter()
//                FeedNetworkService2.loadResidents(url: $0) {name in
//                    newResidents.append(name)
//                    group.leave()
//                }
//            }
//            group.notify(queue: .main) { [weak self] in
//                self?.residents = newResidents
//                print(self?.residents.count)
//                self?.residents.forEach({print($0)})
//            }
//
//            ()
//        }
    }
    
    
}
