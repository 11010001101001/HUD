//
//  SpeedStateView.swift
//  HUD
//
//  Created by Ярослав Куприянов on 26.10.2025.
//

import SwiftUI

struct SpeedStateView: View {
    @ObservedObject var locationManager: LocationManager

    @Bindable var savedSettings: Settings

    var body: some View {
        content
    }
}

// MARK: - Content
private extension SpeedStateView {
    var content: some View {
        VStack(spacing: 16) {
            attention
            leaf
        }
    }

    @ViewBuilder
    var attention: some View {
        let isSpeedExceeded = locationManager.speed > savedSettings.maxSpeed

        Image(systemName: "exclamationmark.triangle.fill")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .foregroundStyle(.red)
            .frame(width: 30, height: 30)
            .opacity(isSpeedExceeded ? 1.0 : .zero)
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
}


