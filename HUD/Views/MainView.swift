//
//  MainView.swift
//  HUD
//
//  Created by Ярослав Куприянов on 24.10.2025.
//

import Foundation
import SwiftUI

struct MainView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var restManager = RestManager()

    @Bindable var savedSettings: Settings

    var body: some View {
        ZStack {
            Color.black
            content
        }
        .ignoresSafeArea()
        .onReceive(locationManager.$speed) { speed in
            if speed >= 10 {
                restManager.startTimer(coffeeBreakDelay: savedSettings.coffeeBreakDelay)
            } else {
                restManager.stopTimer()
            }
        }
    }
}

// MARK: - Content
private extension MainView {
    var content: some View {
        HStack(spacing: 20) {
            speed
            additional
        }
    }

    var additional: some View {
        VStack(alignment: .leading) {
            icons
            measurement
        }
    }

    var icons: some View {
        HStack(spacing: 20) {
            leaf
            coffee
        }
    }

    @ViewBuilder
    var speed: some View {
        let isSpeedExceeded = locationManager.speed > savedSettings.maxSpeed
        let color: Color = isSpeedExceeded ? .red : .white

        Rectangle()
            .fill(.clear)
            .frame(width: 400)
            .overlay {
                HStack {
                    Spacer()
                    Text("\(locationManager.speed, specifier: "%.0f")")
                        .font(.system(size: 200))
                        .fontDesign(.monospaced)
                        .foregroundStyle(color)
                }
            }
    }

    var coffee: some View {
        Image(systemName: "cup.and.heat.waves.fill")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .foregroundStyle(.orange)
            .frame(width: 70, height: 70)
            .opacity(restManager.isNeedRest ? 1.0 : .zero)
    }

    @ViewBuilder
    var leaf: some View {
        let isEcoMode = locationManager.speed >= savedSettings.fuelEconomyMinSpeed && locationManager.speed <= savedSettings.fuelEconomyMaxSpeed

        Image(systemName: "leaf.fill")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .foregroundStyle(.green)
            .frame(width: 60, height: 60)
            .opacity(isEcoMode ? 1.0 : .zero)
    }

    var measurement: some View {
        Text("км/ч")
            .font(.system(size: 50))
            .fontDesign(.monospaced)
            .foregroundStyle(.white)
    }
}
