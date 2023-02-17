//
//  FeedNetworkService2.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 17.02.2023.
//

import Foundation

struct FeedNetworkService2 {
    private static let defaultURL = "https://swapi.dev/api/planets/3"
    
    static func request(completion: @escaping (String, [String]) -> Void) {
        guard let url = URL(string: defaultURL) else {
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let planet = try? JSONDecoder().decode(Planet.self, from: data)
            else {
                DispatchQueue.main.async {
                    completion("", [])
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(planet.orbitalPeriod, planet.residentsURL)
                print("Ура")
            }

        }
        task.resume()
    }
    
    
    static func loadResidents(url: String, completion: @escaping (String) -> Void) {
        

        guard let url = URL(string: url) else {
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data,
                  let resident = try? JSONDecoder().decode(Resident.self, from: data)
            else {
                return
            }
//            DispatchQueue.main.sync {
//                completion(resident.name)
//                print(resident.name)
//            }
            completion(resident.name)
//            print(resident.name)

        }
        task.resume()
        
        
        
    }
    
}
