//
//  MoodViewModel.swift
//  HueMood
//
//  Created by Kevin Schubert on 13.04.25.
//

import Foundation

class MoodViewModel: ObservableObject {
    @Published var moods: [Mood] = [
        Mood(name: "Entspannung", colorHex: "#FFA07A", brightness: 120),
        Mood(name: "Fokus", colorHex: "#ADD8E6", brightness: 200),
        Mood(name: "Party", colorHex: "#9400D3", brightness: 255),
        Mood(name: "Lesen", colorHex: "#FFFACD", brightness: 180)
    ]

    func applyMood(_ mood: Mood) async {
        await HueAPIService.shared.sendMoodToBridge(mood: mood)
    }

    func addCustomMood(name: String, colorHex: String, brightness: Double) {
        let newMood = Mood(name: name, colorHex: colorHex, brightness: Int(brightness))
        moods.append(newMood)
    }
}
