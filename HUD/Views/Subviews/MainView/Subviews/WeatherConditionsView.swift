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
        buildImage(systemName: "cloud.rain")
            .opacity(weatherManager.isRain ? 1.0 : .zero)
    }
    
    var snow: some View {
        buildImage(systemName: "snowflake.road.lane.dashed")
            .opacity(weatherManager.isSnow ? 1.0 : .zero)
    }
    
    func buildImage(systemName: String) -> some View {
        Image(systemName: systemName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .foregroundStyle(.cyan)
            .frame(width: 30, height: 30)
    }
}
