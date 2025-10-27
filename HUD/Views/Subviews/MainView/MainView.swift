//
//  MainView.swift
//  HUD
//
//  Created by Ярослав Куприянов on 24.10.2025.
//

import Foundation
import SwiftUI

struct MainView: View {
    @StateObject var locationManager: LocationManager
    @StateObject var restManager: RestManager
    @StateObject var weatherManager: WeatherManager

    @Bindable var savedSettings: Settings

    // MARK: Init
    init(savedSettings: Settings) {
        self.savedSettings = savedSettings
        let soundManager: SoundManagerProtocol = SoundManager()
        
        _locationManager = StateObject(wrappedValue: LocationManager(soundManager: soundManager, savedSettings: savedSettings))
        _restManager = StateObject(wrappedValue: RestManager(soundManager: soundManager))
        _weatherManager = StateObject(wrappedValue: WeatherManager())
    }

    var body: some View {
        ZStack {
            Color.black
            content
        }
        .onReceive(locationManager.$speed) {
            restManager.checkIsNeedRest($0, coffeeBreakDelay: savedSettings.coffeeBreakDelay)
        }
        .onReceive(locationManager.$coordinate) {
            weatherManager.updateCoordinate($0)
        }
        .overlay(alignment: .top) {
            WeatherConditionsView(weatherManager: weatherManager)
                .padding(.top, 20)
        }
        .overlay(alignment: .topLeading) {
            TemperatureView(weatherManager: weatherManager)
                .padding([.top, .leading], 20)
        }
        .overlay(alignment: .topTrailing) {
            SettingsView(savedSettings: savedSettings)
                .padding([.top, .trailing], 20)
        }
        .ignoresSafeArea()
    }
}

// MARK: - Content
private extension MainView {
    var content: some View {
        HStack(alignment: .bottom, spacing: 26) {
            SpeedView(
                locationManager: locationManager,
                savedSettings: savedSettings
            )
            AdditionalInfoView(
                locationManager: locationManager,
                restManager: restManager,
                savedSettings: savedSettings
            )
        }
        .frame(width: 500, height: 200)
    }
}

#Preview {
    MainView(
        savedSettings: .init(
            maxSpeed: 60,
            speedExceededSound: .speed,
            speedAnimationEnabled: false,
            fuelEconomyMinSpeed: 90,
            fuelEconomyMaxSpeed: 120,
            coffeeBreakDelay: 10,
            mode: .dashboard
        )
    )
}
