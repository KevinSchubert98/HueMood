//
//  Untitled.swift
//  HueMood
//
//  Created by Kevin Schubert on 14.04.25.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255
        let green = Double((rgb & 0x00FF00) >> 8) / 255
        let blue = Double(rgb & 0x0000FF) / 255

        self.init(red: red, green: green, blue: blue)
    }
}
