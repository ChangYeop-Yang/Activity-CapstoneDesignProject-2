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
    private let notificationContent: UNMutableNotificationContent = UNMutableNotificationContent()
    
    // MARK: - Init
    internal init(title: String, subTitle: String, body: String) {
        notificationContent.title = title
        notificationContent.subtitle = subTitle
        notificationContent.body = body
        notificationContent.sound = UNNotificationSound(named: notiSoundName)
        notificationContent.badge = 1
        notificationContent.setValue(true, forKey: "shouldAlwaysAlertWhileAppIsForeground")
    }
    
    // MARK: - Method
    internal func occurNotification(id: String) {
        
        let trigger: UNTimeIntervalNotificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request: UNNotificationRequest = UNNotificationRequest(identifier: id, content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
}

// MARK: - LocalNotification Delegate Extension
extension LocalNotification: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
