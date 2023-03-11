//
//  AlertNotification.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 07.03.2023.
//

import UIKit

final class AlertNotification {
    static let shared = AlertNotification()
    
    func defaultAlertNotification(text: String, viewController: UIViewController) {
        let alertController = UIAlertController(
            title: text,
            message: nil,
            preferredStyle: .alert
        )
        let actionCansel = UIAlertAction(title: "Отменить", style: .cancel) { _ in}
        alertController.addAction(actionCansel)
        
        viewController.present(alertController, animated: true)
    }
    
}

