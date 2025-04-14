//
//  ScheduledMoodViewModel.swift
//  HueMood
//
//  Created by Kevin Schubert on 14.04.25.
//

import Foundation

class ScheduledMoodViewModel: ObservableObject {
        @Published var scheduledMoods: [ScheduledMood] = [] {
            didSet {
                saveScheduledMoods()
            }
        }

        private let storageKey = "scheduledMoods"

        init() {
            loadScheduledMoods()
        }

        // Funktion zum Planen der Stimmung
        func scheduleMood(mood: Mood, at time: Date) {
            let scheduledMood = ScheduledMood(mood: mood, scheduledTime: time)
            scheduledMoods.append(scheduledMood)

            // Benachrichtigung planen
            NotificationManager.shared.scheduleNotification(
                title: "Lichtstimmung",
                body: "Die Stimmung \(mood.name) wird jetzt aktiviert.",
                timeInterval: time.timeIntervalSinceNow,
                scheduledTime: time // Übergabe des geplanten Zeitpunkts
            )
        }

        // Funktion zum Entfernen einer geplanten Stimmung
        func removeScheduledMood(_ scheduledMood: ScheduledMood) {
            if let index = scheduledMoods.firstIndex(where: { $0.id == scheduledMood.id }) {
                scheduledMoods.remove(at: index)
            }
        }

        // Speichern der geplanten Stimmungen
        private func saveScheduledMoods() {
            if let data = try? JSONEncoder().encode(scheduledMoods) {
                UserDefaults.standard.set(data, forKey: storageKey)
            }
        }

        // Laden der geplanten Stimmungen aus UserDefaults
        private func loadScheduledMoods() {
            if let data = UserDefaults.standard.data(forKey: storageKey),
               let decoded = try? JSONDecoder().decode([ScheduledMood].self, from: data) {
                scheduledMoods = decoded
                print("Geladene geplante Stimmungen: \(scheduledMoods)")
            }
        }
    }
