//
//  SpeedView.swift
//  HUD
//
//  Created by Ярослав Куприянов on 26.10.2025.
//

import SwiftUI

struct SpeedView: View {
    @ObservedObject var locationManager: LocationManager

    @Bindable var savedSettings: Settings

    var body: some View {
        speed
    }
}

// MARK: - Content
private extension SpeedView {
    @ViewBuilder
    var speed: some View {
        let contentTransition: ContentTransition = savedSettings.speedAnimationEnabled ? .numericText(value: locationManager.speed) : .identity
        let animation: Animation? = savedSettings.speedAnimationEnabled ? .easeInOut(duration: 0.3) : .none
        
        HStack {
            Spacer()
            Text("\(locationManager.speed, specifier: "%.0f")")
                .font(.system(size: 200))
                .fontDesign(.rounded)
                .foregroundStyle(.white)
                .contentTransition(contentTransition)
                .animation(animation, value: locationManager.speed)
        }
    }
}


