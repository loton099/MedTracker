//
//  NotificationManager.swift
//  MedTracker
//
//  Created by Shakti Prakash Srichandan on 23/06/21.
//

import Foundation
import UserNotifications
import UIKit

class NotificationManager: ObservableObject {
    
    static let shared = NotificationManager()
    
    //MARK: RequestAuthorisation
    func requestAuthorization() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) {  [weak self] granted, _  in
                if granted {
                    self?.setMedicineReminder()
                }
            }
    }
    
    //MARK: Remove Pending Notification
    func removePendingNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    //MARK: Setting Reminder
    func setMedicineReminder() {
        self.removePendingNotification()
        let center = UNUserNotificationCenter.current()
        for medicinedose  in  MedicineTimings.allCases {
            let (reminderBody, medicinetime) = medicinedose.getReminderMessageAndTime()
            let content = UNMutableNotificationContent()
            content.title = "medicine_reminder".localized
            content.body = reminderBody
            content.categoryIdentifier = "alarm"
            content.sound = UNNotificationSound.default
            var dateComponents = DateComponents()
            dateComponents.hour = medicinetime
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
    }
}
