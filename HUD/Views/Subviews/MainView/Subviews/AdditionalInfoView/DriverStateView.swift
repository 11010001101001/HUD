//
//  DriverStateView.swift
//  HUD
//
//  Created by Ярослав Куприянов on 26.10.2025.
//

import SwiftUI

struct DriverStateView: View {
    @ObservedObject var restManager: RestManager

    var body: some View {
        coffee
    }
}

// MARK: - Content
private extension DriverStateView {
    var coffee: some View {
        Image(systemName: "cup.and.heat.waves.fill")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .foregroundStyle(.orange)
            .frame(width: 40, height: 40)
            .opacity(restManager.isNeedRest ? 1.0 : .zero)
    }
}


