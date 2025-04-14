//
//  ScheduledMood.swift
//  HueMood
//
//  Created by Kevin Schubert on 14.04.25.
//

import Foundation

struct ScheduledMood: Identifiable, Codable, Hashable {
    var id = UUID()
    var mood: Mood
    var scheduledTime: Date
}
