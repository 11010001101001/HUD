//
//  SettingsView.swift
//  HUD
//
//  Created by Ярослав Куприянов on 24.10.2025.
//

import SwiftUI

struct SettingsView: View {
    @Bindable var savedSettings: Settings

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
                    .sensoryFeedback(.increase, trigger: savedSettings.maxSpeed)
                Stepper("Экономия топлива от: \(Int(savedSettings.fuelEconomyMinSpeed)) км/ч", value: $savedSettings.fuelEconomyMinSpeed, in: 60...150)
                    .sensoryFeedback(.decrease, trigger: savedSettings.fuelEconomyMinSpeed)
                Stepper("Экономия топлива до: \(Int(savedSettings.fuelEconomyMaxSpeed)) км/ч", value: $savedSettings.fuelEconomyMaxSpeed, in: 60...200)
                    .sensoryFeedback(.increase, trigger: savedSettings.fuelEconomyMaxSpeed)
            }
            .padding(.top)

            Section("Уведомление о превышении скорости:") {
                Picker("Уведомление", selection: $savedSettings.speedExceededSound) {
                    Text(Sound.airplane.rawValue).tag(Sound.airplane)
                    Text(Sound.speed.rawValue).tag(Sound.speed)
                }
                .sensoryFeedback(.selection, trigger: savedSettings.speedExceededSound)
                .pickerStyle(.segmented)
            }

            Section("Анимация изменения скорости:") {
                Picker("Анимация", selection: $savedSettings.speedAnimationEnabled) {
                    Text("вкл").tag(true)
                    Text("выкл").tag(false)
                }
                .sensoryFeedback(.selection, trigger: savedSettings.speedAnimationEnabled)
                .pickerStyle(.segmented)
            }

            Section("Перерыв на кофе") {
                Picker("Перерыв", selection: $savedSettings.coffeeBreakDelay) {
                    Text("1 час").tag(3600.0)
                    Text("2 часа").tag(7200.0)
                    Text("3 часа").tag(10800.0)
                }
                .sensoryFeedback(.selection, trigger: savedSettings.coffeeBreakDelay)
                .pickerStyle(.segmented)
            }

            Section("Режим") {
                Picker("Интерфейс", selection: $savedSettings.mode) {
                    Text("HUD").tag(Mode.HUD)
                    Text("Панель приборов").tag(Mode.dashboard)
                }
                .sensoryFeedback(.selection, trigger: savedSettings.mode)
                .pickerStyle(.segmented)
            }
        }
        .scrollIndicators(.hidden)
    }
}
