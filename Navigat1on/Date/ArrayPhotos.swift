//
//  ArrayPhotos.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 19.01.2023.
//

import Foundation
import UIKit


class Photos {
    static var photos: [UIImage?] = Array(1...20).map { UIImage(named: String($0)) }
    
}
