//
//  NotificationManager.swift
//  MacData
//
//  Created by Alberto Lourenço on 28/09/20.
//  Copyright © 2020 Digit.all. All rights reserved.
//

import Foundation
import UserNotifications

final class NotificationManager {
    
    static let shared = NotificationManager()
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    func showNotification(title: String, body: String, categoryIdentifier: String) {
        
        notificationCenter.getNotificationSettings { (settings) in
            
            DispatchQueue.main.async {

                if settings.authorizationStatus == .authorized {
                    self.scheduleNotification(title: title,
                                              body: body,
                                              categoryIdentifier: categoryIdentifier)
                }else{
                    self.requestPermission { (success) in
                        self.scheduleNotification(title: title,
                                                  body: body,
                                                  categoryIdentifier: categoryIdentifier)
                    }
                }
            }
        }
    }
    
    private func scheduleNotification(title: String, body: String, categoryIdentifier: String) {

        let notificationContent = self.prepareNotificationContent(title: title,
                                                                  body: body,
                                                                  categoryIdentifier: categoryIdentifier)
        
        self.scheduleNotification(content: notificationContent.content,
                                  dateComponents: notificationContent.dateComponents,
                                  repeats: notificationContent.repeats)
    }
    
    private func prepareNotificationContent(title: String,
                                            body: String,
                                            categoryIdentifier: String) -> (content: UNMutableNotificationContent,
                                                                            dateComponents: DateComponents,
                                                                            repeats: Bool) {

        let calendar = Calendar.current
        let date = calendar.date(byAdding: .second, value: 1, to: Date()) ?? Date()

        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.categoryIdentifier = categoryIdentifier

        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        dateComponents.hour = calendar.component(.hour, from: date)
        dateComponents.minute = calendar.component(.minute, from: date)
        dateComponents.second = calendar.component(.second, from: date)
        
        return (content: content, dateComponents: dateComponents, false)
    }
    
    private func scheduleNotification(content: UNMutableNotificationContent,
                                      dateComponents: DateComponents,
                                      repeats: Bool) {
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: repeats)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in

            DispatchQueue.main.async {
                
                if error == nil {
                    print("MacData - Cleaned: Notification scheduled")
                }else{
                    print(error.debugDescription)
                }
            }
        }
    }
    
    private func requestPermission(completion: @escaping (_ success: Bool) -> Void) {
        
        notificationCenter.requestAuthorization(options: UNAuthorizationOptions.alert) { (success, error) in
            completion(success)
        }
    }
}
