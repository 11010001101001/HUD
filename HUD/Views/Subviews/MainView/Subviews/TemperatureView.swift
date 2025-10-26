//
//  TemperatureView.swift
//  HUD
//
//  Created by Ярослав Куприянов on 26.10.2025.
//

import SwiftUI

struct TemperatureView: View {
    @ObservedObject var weatherManager: WeatherManager

    var body: some View {
        content
    }
}

// MARK: - Content
private extension TemperatureView {
    var content: some View {
        HStack(spacing: 8) {
            locationIcon
            locationName
            temperature
        }
        .opacity(0.5)
    }

    var temperature: some View {
        buildText(weatherManager.temperature)
    }

    @ViewBuilder
    var locationIcon: some View {
        let name = weatherManager.locationName
        let systemName = name.isEmpty ? "wifi.slash" : "location.fill"

        Image(systemName: systemName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .foregroundStyle(.white)
            .frame(width: 20, height: 20)
    }

    var locationName: some View {
        buildText(weatherManager.locationName)
    }

    func buildText(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 20))
            .fontDesign(.rounded)
            .foregroundStyle(.white)
    }
}
