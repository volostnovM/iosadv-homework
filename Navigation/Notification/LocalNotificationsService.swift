//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by TIS Developer on 15.06.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit


class LocalNotificationsService: NSObject {

    let center = UNUserNotificationCenter.current()

    func registeForLatestUpdatesIfPossible() {
        registerUpdatesCategory()
        
        center.requestAuthorization(options: [.badge, .provisional, .sound]) { (success, error) in
            if success {
                print("Permission granted")
                self.center.removeAllPendingNotificationRequests()
                
                let content = UNMutableNotificationContent()
     
                content.sound = .default
                content.title = "Новое сообщение"
                content.body = "Посмотрите последние обновления"
                content.badge = 1
                content.categoryIdentifier = "updates"
                
                var components = DateComponents()
                components.hour = 13
                components.minute = 27
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                self.center.add(request)
            } else {
                print("Permission denied")
            }
        }
    }

}

extension LocalNotificationsService: UNUserNotificationCenterDelegate {

    func registerUpdatesCategory() {
        center.delegate = self

        let actionShow = UNNotificationAction(identifier: "update", title: "Update", options: .authenticationRequired)
        let category = UNNotificationCategory(identifier: "updates", actions: [actionShow], intentIdentifiers: [], options: [])

        center.setNotificationCategories([category])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            print("Press Default")
        case "update":
            print("Press update")
        default:
            break
        }
        completionHandler()
    }
}
