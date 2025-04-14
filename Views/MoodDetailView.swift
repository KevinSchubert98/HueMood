//
//  MoodDetailView.swift
//  HueMood
//
//  Created by Kevin Schubert on 14.04.25.
//

import SwiftUI

struct MoodDetailView: View {
    let mood: Mood

    var body: some View {
        VStack(spacing: 24) {
            // 🔵 Dynamischer Kreis mit Text
            GeometryReader { geo in
                let size = min(geo.size.width, geo.size.height)

                ZStack {
                    Circle()
                        .fill(Color(hex: mood.colorHex))
                        .frame(width: size, height: size)
                        .shadow(color: Color(hex: mood.colorHex).opacity(0.4), radius: 10)
                        .position(x: geo.size.width / 2, y: geo.size.height / 2)

                    Text(mood.name)
                        .font(.system(size: size * 0.18, weight: .bold))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .frame(width: size * 0.8)
                        .position(x: geo.size.width / 2, y: geo.size.height / 2)
                }
            }
            .frame(height: 200) // 🔧 Höhe des Kreises

            // 📄 Mood-Details
            VStack(spacing: 8) {
                Text("Helligkeit: \(mood.brightness)")
                    .font(.headline)

                Text("Farbwert: \(mood.colorHex)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding()
        .navigationTitle(mood.name)
    }
}
#Preview {
    let sampleMood = Mood(
        name: "Entspannung",
        colorHex: "#FFA07A",
        brightness: 120
    )
    return NavigationView {
        MoodDetailView(mood: sampleMood)
    }
}
