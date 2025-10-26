//
//  WeatherConditionsView.swift
//  HUD
//
//  Created by Ярослав Куприянов on 26.10.2025.
//

import SwiftUI

struct WeatherConditionsView: View {
    @ObservedObject var weatherManager: WeatherManager

    var body: some View {
        content
    }
}

// MARK: - Content
private extension WeatherConditionsView {
    var content: some View {
        ZStack {
            rain
            snow
        }
    }

    var rain: some View {
        Image(systemName: "cloud.rain")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .foregroundStyle(.cyan)
            .frame(width: 30, height: 30)
            .opacity(weatherManager.isRain ? 1.0 : .zero)
    }

    var snow: some View {
        Image(systemName: "snowflake.road.lane.dashed")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .foregroundStyle(.cyan)
            .frame(width: 30, height: 30)
            .opacity(weatherManager.isSnow ? 1.0 : .zero)
    }
}
