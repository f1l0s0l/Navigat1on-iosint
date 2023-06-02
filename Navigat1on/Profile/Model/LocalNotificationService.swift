//
//  LocalNotificationService.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 02.06.2023.
//

import Foundation
import UserNotifications

protocol ILocalNotificationService {
    func setDelegate(_ object: UNUserNotificationCenterDelegate)
    func registeForLatestUpdatesIfPossible()
}

final class LocalNotificationService {
    
    // MARK: - Private properties
    
    private lazy var userNotificationCenter: UNUserNotificationCenter = {
        let center = UNUserNotificationCenter.current()
//        center.delegate = self
        return center
    }()
    
    
    // MARK: - Private methods
    
    private func scheduleNotification() {
        self.userNotificationCenter.removeAllPendingNotificationRequests()
        self.registerUpdatesCategory()
        
        let content = UNMutableNotificationContent()
        content.title = "Посмотрите последние обновления"
        content.body = "Нужно настроить уведомления для приложения ВК"
        content.categoryIdentifier = "updates"
        content.userInfo = ["CustomData": "qwerty"]
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 19
        dateComponents.minute = 30
        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        let register = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        self.userNotificationCenter.add(register)
    }
    
    private func registerUpdatesCategory() {
        let show = UNNotificationAction(
            identifier: "Показать",
            title: "Показать больше",
            options: [.foreground]
        )
        
        let category = UNNotificationCategory(
            identifier: "updates",
            actions: [show],
            intentIdentifiers: []
        )
        
        self.userNotificationCenter.setNotificationCategories([category])
        
    }
    
}



    // MARK: - ILocalNotificationService

extension LocalNotificationService: ILocalNotificationService {
    
    func setDelegate(_ object: UNUserNotificationCenterDelegate) {
        self.userNotificationCenter.delegate = object
    }
    
    func registeForLatestUpdatesIfPossible() {
        self.userNotificationCenter.requestAuthorization(
            options: [.alert, .sound, .badge])
        { isTrue, error in
            guard isTrue else {
                print(error)
                return
            }
            self.scheduleNotification()
        }
    }
    
}



    // MARK: - UNUserNotificationCenterDelegate

//extension LocalNotificationService: UNUserNotificationCenterDelegate {
//
//}



