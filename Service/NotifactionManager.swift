//
//  NotifactionManager.swift
//  HueMood
//
//  Created by Kevin Schubert on 14.04.25.
//

import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()

    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Benachrichtigungen erlaubt")
            } else {
                print("Benachrichtigungen nicht erlaubt")
            }
        }
    }

    func scheduleNotification(title: String, body: String, timeInterval: TimeInterval, scheduledTime: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        // Erstellen der Komponenten für den geplanten Zeitpunkt
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: scheduledTime)

        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Fehler beim Planen der Benachrichtigung: \(error.localizedDescription)")
            }
        }
    }
}
