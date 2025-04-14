//
//  HueAPIService.swift
//  HueMood
//
//  Created by Kevin Schubert on 13.04.25.
//

import Foundation

class HueAPIService {
    static let shared = HueAPIService()

    private let bridgeIP = "localhost:3001" // Deine Bridge-IP
    private let username = "mock-username"  // Dein API-Username

    func sendMoodToBridge(mood: Mood) async {
        guard let url = URL(string: "http://\(bridgeIP)/api/\(username)/groups/0/action") else {
            print("Ungültige URL")
            return
        }

        let body: [String: Any] = [
            "on": true,
            "bri": mood.brightness,
            "xy": convertHexToXY(mood.colorHex)
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            if let responseString = String(data: data, encoding: .utf8) {
                print("Antwort vom Mock-Server: \(responseString)")
            }
        } catch {
            print("Fehler beim Senden: \(error.localizedDescription)")
        }
    }

    private func convertHexToXY(_ hex: String) -> [Double] {
        switch hex {
        case "#FFA07A": return [0.5016, 0.4152]
        case "#ADD8E6": return [0.3, 0.3]
        case "#9400D3": return [0.2725, 0.1096]
        case "#FFFACD": return [0.44, 0.40]
        default: return [0.5, 0.5]
        }
    }
}
