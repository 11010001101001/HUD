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
        .onReceive(locationManager.$speed) { speed in
            restManager.checkIsNeedRest(speed, coffeeBreakDelay: savedSettings.coffeeBreakDelay)
        }
    }
}

// MARK: - Content
private extension MainView {
    var content: some View {
        HStack(alignment: .bottom, spacing: 26) {
            speed
            info
        }
        .frame(width: 500, height: 200)
    }

    var info: some View {
        VStack(alignment: .leading, spacing: 16) {
            attention
            leaf
            coffee
            measurement
        }
        .padding(.bottom, 45)
    }

    var speed: some View {
        HStack {
            Spacer()
            Text("\(locationManager.speed, specifier: "%.0f")")
                .font(.system(size: 200))
                .fontDesign(.rounded)
                .foregroundStyle(.white)
        }
    }

    var attention: some View {
        Image(systemName: "exclamationmark.triangle.fill")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .foregroundStyle(.red)
            .frame(width: 30, height: 30)
            .opacity(locationManager.speed > savedSettings.maxSpeed ? 1.0 : .zero)
    }

    var coffee: some View {
        Image(systemName: "cup.and.heat.waves.fill")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .foregroundStyle(.orange)
            .frame(width: 40, height: 40)
            .opacity(restManager.isNeedRest ? 1.0 : .zero)
    }

    @ViewBuilder
    var leaf: some View {
        let isEcoMode = locationManager.speed >= savedSettings.fuelEconomyMinSpeed && locationManager.speed <= savedSettings.fuelEconomyMaxSpeed

        Image(systemName: "leaf.fill")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .foregroundStyle(.green)
            .frame(width: 30, height: 30)
            .opacity(isEcoMode ? 1.0 : .zero)
    }

    var measurement: some View {
        Text("км/ч")
            .font(.system(size: 40))
            .fontDesign(.rounded)
            .foregroundStyle(.white)
    }
}

#Preview {
    MainView(savedSettings: .init(maxSpeed: 60, fuelEconomyMinSpeed: 90, fuelEconomyMaxSpeed: 120, coffeeBreakDelay: 10, mode: .dashboard))
}
