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
        content
    }
}

// MARK: - Content
private extension ContentView {
    @ViewBuilder
    var content: some View {
        if let savedSettings = settings.first {
            buildMainView(savedSettings: savedSettings)
        } else {
            let `default` = Settings(
                maxSpeed: 55,
                speedExceededSound: .speed,
                speedAnimationEnabled: false,
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

    func buildMainView(savedSettings: Settings) -> some View {
        MainView(savedSettings: savedSettings)
            .rotation3DEffect(.degrees(savedSettings.mode == .HUD ? 180 : .zero), axis: (x: 0.0, y: 1.0, z: 0.0))
            .onAppear { UIApplication.shared.isIdleTimerDisabled = true }
            .onDisappear { UIApplication.shared.isIdleTimerDisabled = false }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Settings.self, inMemory: true)
}
