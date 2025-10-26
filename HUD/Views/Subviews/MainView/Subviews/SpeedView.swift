//
//  SpeedView.swift
//  HUD
//
//  Created by Ярослав Куприянов on 26.10.2025.
//

import SwiftUI

struct SpeedView: View {
    @ObservedObject var locationManager: LocationManager

    var body: some View {
        speed
    }
}

// MARK: - Content
private extension SpeedView {
    var speed: some View {
        HStack {
            Spacer()
            Text("\(locationManager.speed, specifier: "%.0f")")
                .font(.system(size: 200))
                .fontDesign(.rounded)
                .foregroundStyle(.white)
                .contentTransition(.numericText(value: locationManager.speed))
                .animation(.easeInOut(duration: 0.3), value: locationManager.speed)
        }
    }
}


