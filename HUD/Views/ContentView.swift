//
//  ContentView.swift
//  HUD
//
//  Created by Ярослав Куприянов on 23.10.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var settings: [Settings]

    var body: some View {
        NavigationStack {
            if let savedSettings = settings.first {
                buildMainView(savedSettings: savedSettings)
            } else {
                let `default` = Settings(
                    maxSpeed: 55,
                    fuelEconomyMinSpeed: 90,
                    fuelEconomyMaxSpeed: 120,
                    coffeeBreakDelay: 60 * 60 * 2,
                    mode: .HUD
                )
                buildMainView(savedSettings: `default`)
                    .onAppear {
                        modelContext.insert(`default`)
                        try? modelContext.save()
                    }
            }
        }
    }
}

// MARK: - Private
private extension ContentView {
    func buildSettingsView(savedSettings: Settings) -> some View {
        SettingsView(savedSettings: savedSettings)
    }

    func buildMainView(savedSettings: Settings) -> some View {
        MainView(savedSettings: savedSettings)
            .rotation3DEffect(.degrees(savedSettings.mode == .HUD ? 180 : .zero), axis: (x: 0.0, y: 1.0, z: 0.0))
            .onAppear { onAppear() }
            .onDisappear { onDisappear() }
            .toolbar { buildToolbar(savedSettings: savedSettings) }
    }
    
    func buildToolbar(savedSettings: Settings) -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            NavigationLink {
                buildSettingsView(savedSettings: savedSettings)
            } label: {
                Image(systemName: "gear").opacity(0.5)
            }
        }
    }

    func onAppear() {
        UIApplication.shared.isIdleTimerDisabled = true
        if let screen = UIApplication
            .shared.connectedScenes.compactMap({ ($0 as? UIWindowScene)?.screen })
            .first {
            screen.brightness = 1.0
        }
    }

    func onDisappear() {
        UIApplication.shared.isIdleTimerDisabled = false
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Settings.self, inMemory: true)
}
