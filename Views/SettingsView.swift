//
//  SettingsView.swift
//  HueMood
//
//  Created by Kevin Schubert on 14.04.25.
//

import SwiftUI
struct SettingsView: View {
    @ObservedObject var moodViewModel: MoodViewModel
    @StateObject var scheduledMoodViewModel = ScheduledMoodViewModel()
    
    // Zusätzliche State-Variablen für benutzerdefinierte Stimmung
    @State private var customMoodName: String = ""
    @State private var customMoodColorHex: String = "#FFFFFF"  // Standardfarbe weiß
    @State private var customMoodBrightness: Double = 100

    @State private var selectedMoodID: UUID?
    @State private var scheduledTime: Date = Date()

    var body: some View {
        NavigationView {
            Form {
                // 🔧 Picker für Stimmungsauswahl
                Section(header: Text("Smart Scheduling")) {
                    Picker("Stimmung auswählen", selection: $selectedMoodID) {
                        ForEach(moodViewModel.moods) { mood in
                            Text(mood.name)
                                .tag(mood.id as UUID?)
                        }
                    }

                    // 🕓 Zeit wählen
                    DatePicker("Wähle eine Uhrzeit", selection: $scheduledTime, displayedComponents: .hourAndMinute)

                    // ✅ Planungsbutton
                    Button("Planen") {
                        if let moodID = selectedMoodID,
                           let selectedMood = moodViewModel.moods.first(where: { $0.id == moodID }) {
                            scheduledMoodViewModel.scheduleMood(mood: selectedMood, at: scheduledTime)
                        }
                    }
                }

                // 📋 Geplante Stimmungen anzeigen + löschen
                Section {
                    ForEach(scheduledMoodViewModel.scheduledMoods) { scheduledMood in
                        HStack {
                            Text(scheduledMood.mood.name)
                            Spacer()
                            Text("\(scheduledMood.scheduledTime, formatter: dateFormatter)")
                                .font(.subheadline)
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                scheduledMoodViewModel.removeScheduledMood(scheduledMood)
                            } label: {
                                Label("Löschen", systemImage: "trash")
                            }
                        }
                    }
                }

                // 📦 Benutzerdefinierte Stimmung hinzufügen
                Section(header: Text("Benutzerdefinierte Stimmung hinzufügen")) {
                    TextField("Name der Stimmung", text: $customMoodName)
                        .padding()
                    TextField("Farbe (HEX)", text: $customMoodColorHex)
                        .padding()
                        .keyboardType(.default)
                    Slider(value: $customMoodBrightness, in: 0...255, step: 1) {
                        Text("Helligkeit")
                    }
                    .accentColor(Color(hex: customMoodColorHex))

                    Button("Hinzufügen") {
                        if !customMoodName.isEmpty {
                            moodViewModel.addCustomMood(name: customMoodName, colorHex: customMoodColorHex, brightness: customMoodBrightness)
                            // Leere die Felder nach dem Hinzufügen
                            customMoodName = ""
                            customMoodColorHex = "#FFFFFF"
                            customMoodBrightness = 100
                        }
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(8)
                    .padding(.top, 10)
                }
            }
            .navigationTitle("Einstellungen")
        }
    }

    // 📆 Datum formatieren
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}

#Preview {
    let previewViewModel = MoodViewModel()
    SettingsView(moodViewModel: previewViewModel)
}
