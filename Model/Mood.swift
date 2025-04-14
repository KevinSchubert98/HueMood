//
//  Mood.swift
//  HueMood
//
//  Created by Kevin Schubert on 13.04.25.
//

import Foundation

struct Mood: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let colorHex: String
    let brightness: Int

    init(id: UUID = UUID(), name: String, colorHex: String, brightness: Int) {
        self.id = id
        self.name = name
        self.colorHex = colorHex
        self.brightness = brightness
    }
}
