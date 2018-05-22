//
//  LocalNotification.swift
//  SAIOT
//
//  Created by 양창엽 on 2018. 5. 16..
//  Copyright © 2018년 Yang-Chang-Yeop. All rights reserved.
//

import UserNotifications

class LocalNotification: NSObject {
    
    // MARK: - Variables
    private let notiSoundName = "star.m4a"
    private let notiRepeatSoundName = "nowhere.m4a"
    private let notificationContent: UNMutableNotificationContent = UNMutableNotificationContent()
    
    // MARK: - Init
    internal init(title: String, subTitle: String, body: String) {
        notificationContent.title = title
        notificationContent.subtitle = subTitle
        notificationContent.body = body
        notificationContent.categoryIdentifier = CategoryID.Emergency.rawValue
        notificationContent.sound = UNNotificationSound(named: notiSoundName)
        notificationContent.setValue(true, forKey: "shouldAlwaysAlertWhileAppIsForeground")
    }
    internal init(title: String, subTitle: String, body: String, repeat: Bool) {
        notificationContent.title = title
        notificationContent.subtitle = subTitle
        notificationContent.body = body
        notificationContent.categoryIdentifier = CategoryID.SmartBox.rawValue
        notificationContent.sound = UNNotificationSound(named: notiRepeatSoundName)
        notificationContent.setValue(true, forKey: "shouldAlwaysAlertWhileAppIsForeground")
    }
    
    // MARK: - Method
    internal func occurNotification(id: String) {
        
        let trigger: UNTimeIntervalNotificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request: UNNotificationRequest = UNNotificationRequest(identifier: id, content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    internal func occurRepeatNotification(id: String) {
        
        var dateComponents: DateComponents = DateComponents()
        dateComponents.second = 10
        
        let trigger: UNCalendarNotificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request: UNNotificationRequest = UNNotificationRequest(identifier: id, content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    internal func removeNotification(id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}
