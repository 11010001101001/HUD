//
//  SettingsView.swift
//  HUD
//
//  Created by Ярослав Куприянов on 24.10.2025.
//

import SwiftUI

struct SettingsView: View {
    @Bindable var savedSettings: Settings
    @Environment(\.dismiss) private var dismiss

    @State private var isSettingsShown = false

    var body: some View {
        content
    }
}

// MARK: - Content
private extension SettingsView {
    var content: some View {
        Button {
            isSettingsShown = true
        } label: {
            Image(systemName: "gear")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .foregroundStyle(.white)
                .frame(width: 25, height: 25)
                .opacity(0.5)
        }
        .sheet(isPresented: $isSettingsShown) { sheet }
    }

    var sheet: some View {
        Form {
            Section("Скорость") {
                Stepper("Макс. разрешенная: \(Int(savedSettings.maxSpeed)) км/ч", value: $savedSettings.maxSpeed, in: 40...160)
                Stepper("Экономия топлива от: \(Int(savedSettings.fuelEconomyMinSpeed)) км/ч", value: $savedSettings.fuelEconomyMinSpeed, in: 60...150)
                Stepper("Экономия топлива до: \(Int(savedSettings.fuelEconomyMaxSpeed)) км/ч", value: $savedSettings.fuelEconomyMaxSpeed, in: 60...200)
            }

            Section("Перерыв на кофе") {
                Picker("Задержка", selection: $savedSettings.coffeeBreakDelay) {
                    Text("1 мин").tag(60.0)
                    Text("1 час").tag(3600.0)
                    Text("2 часа").tag(7200.0)
                    Text("3 часа").tag(10800.0)
                }
                .pickerStyle(.segmented)
            }

            Section("Режим") {
                Picker("Интерфейс", selection: $savedSettings.mode) {
                    Text("HUD").tag(Mode.HUD)
                    Text("Панель приборов").tag(Mode.dashboard)
                }
                .pickerStyle(.segmented)
            }
        }
        .scrollIndicators(.hidden)
    }
}
