//
//  FeedNetworkService1.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 17.02.2023.
//

import Foundation

struct FeedNetworkService1 {
    private static let defaultURL = "https://jsonplaceholder.typicode.com/todos/7"
    
    static func request(completion: @escaping (String) -> Void) {
        guard let url = URL(string: defaultURL) else {
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion("")
                }
                return
            }
            guard let data = data,
                  let dateDictionary = try? JSONSerialization.jsonObject(with: data) as? [String : Any],
                  let titleText = dateDictionary["title"] as? String
            else {
                DispatchQueue.main.async {
                    completion("")
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(titleText)
            }
            
            
            
        }
        task.resume()
    }
    
}
