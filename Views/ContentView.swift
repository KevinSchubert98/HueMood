//
//  ContentView.swift
//  HueMood
//
//  Created by Kevin Schubert on 13.04.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MoodViewModel()
    @State private var appliedMoodID: UUID?
    @State private var activeGradient: Gradient = Gradient(colors: [Color.white, Color.white])
    @State private var fadeInAnimation: Bool = false
    @State private var showingSettings = false

    // 🔷 Optional: Feste Farbverläufe je Stimmung
    let moodGradients: [UUID: Gradient] = [:] // Leere Map oder deine Zuordnung

    var body: some View {
        NavigationView {
            ZStack {
                // 🔆 Dynamischer Hintergrund
                LinearGradient(
                    gradient: activeGradient,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .animation(.easeInOut(duration: 1.0), value: activeGradient)
                .edgesIgnoringSafeArea(.all)

                VStack {
                    List(viewModel.moods) { mood in
                        NavigationLink(destination: MoodDetailView(mood: mood)) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white)
                                    .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)

                                HStack {
                                    ZStack {
                                        Circle()
                                            .fill(Color(hex: mood.colorHex))
                                            .frame(width: 40, height: 40)

                                        if appliedMoodID == mood.id {
                                            Circle()
                                                .stroke(Color(hex: mood.colorHex).opacity(0.4), lineWidth: 8)
                                                .scaleEffect(1.2)
                                                .opacity(1)
                                                .blur(radius: 3)
                                                .animation(.easeInOut(duration: 0.5), value: appliedMoodID)
                                        }
                                    }

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(mood.name)
                                            .font(.headline)
                                        Text("Helligkeit: \(mood.brightness)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }

                                    Spacer()

                                    Button(action: {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            appliedMoodID = mood.id
                                            if let gradient = moodGradients[mood.id] {
                                                activeGradient = gradient
                                            }
                                        }

                                        Task {
                                            await viewModel.applyMood(mood)
                                        }

                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                            withAnimation {
                                                appliedMoodID = nil
                                            }
                                        }
                                    }) {
                                        Text("Anwenden")
                                            .font(.subheadline)
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(appliedMoodID == mood.id ? Color.green : Color.blue)
                                            .cornerRadius(8)
                                            .scaleEffect(appliedMoodID == mood.id ? 1.1 : 1)
                                            .shadow(radius: 5)
                                    }
                                }
                                .padding()
                            }
                            .padding(.vertical, 4)
                        }
                        .opacity(fadeInAnimation ? 1 : 0)
                        .onAppear {
                            withAnimation(.easeIn(duration: 0.5)) {
                                fadeInAnimation = true
                            }
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showingSettings.toggle()
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.accentColor)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                                .padding()
                        }
                        .sheet(isPresented: $showingSettings) {
                            SettingsView(moodViewModel: viewModel)
                        }
                    }
                }
            }
            .navigationTitle("Lichtstimmungen")
        }
    }
}
#Preview {
    ContentView()
}
