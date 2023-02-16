//
//  NetworkService.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 15.02.2023.
//

import Foundation

struct NetworkService {
    static func reguest(for configurtion: AppConfiguration) {
        guard let url = configurtion.url else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { date, response, error in
            guard let date = date,
                  let response = response as? HTTPURLResponse
            else {
                guard let error = error else {
                    return
                }
                print(error.localizedDescription)
                return
            }
            
            do {
                guard let dateDictionari = try JSONSerialization.jsonObject(with: date) as? [String : Any] else {
                    print("Не удалось скастить данные из date до [String : Any]")
                    return
                }
                dateDictionari.forEach( {print("\nKey: \($0) \nValue: \($1)")} )
            }
            catch {
                print(error)
            }
            
            print("\nAll header fields")
            response.allHeaderFields.forEach({ print("\n\($0) \n\($1)") })
            
            print("\nStatus code: \(response.statusCode)")
        }
        task.resume()
    }
   
}


enum AppConfiguration {
    case ferstUrl(string: String)
    case secondUrl(string: String)
    case thirdUrl(string: String)
    
    var url: URL? {
        switch self {
        case .ferstUrl(string: let string):
            guard let url = URL(string: string) else {
                return nil
            }
            return url
            
        case .secondUrl(string: let string):
            guard let url = URL(string: string) else {
                return nil
            }
            return url
            
        case .thirdUrl(string: let string):
            guard let url = URL(string: string) else {
                return nil
            }
            return url
        }
    }
    
//    init(ferstUrl: String, secondUrl: String, thirdUrl: String) {
//        self = .ferstUrl(string: ferstUrl)
//        self = .secondUrl(string: secondUrl)
//        self = .thirdUrl(string: thirdUrl)
//    }
}
