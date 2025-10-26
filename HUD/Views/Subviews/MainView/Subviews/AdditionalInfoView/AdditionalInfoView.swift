//
//  AdditionalInfoView.swift
//  HUD
//
//  Created by Ярослав Куприянов on 26.10.2025.
//

import SwiftUI

struct AdditionalInfoView: View {
    @ObservedObject var locationManager: LocationManager
    @ObservedObject var restManager: RestManager

    @Bindable var savedSettings: Settings

    var body: some View {
        content
    }
}

// MARK: - Content
private extension AdditionalInfoView {
    var content: some View {
        VStack(alignment: .leading, spacing: 16) {
            SpeedStateView(
                locationManager: locationManager,
                savedSettings: savedSettings
            )
            DriverStateView(restManager: restManager)
            units
        }
        .padding(.bottom, 45)
    }

    var units: some View {
        Text("км/ч")
            .font(.system(size: 40))
            .fontDesign(.rounded)
            .foregroundStyle(.white)
            .opacity(0.5)
    }
}


