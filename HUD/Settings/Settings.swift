//
//  Item.swift
//  HUD
//
//  Created by Ярослав Куприянов on 23.10.2025.
//

import Foundation
import SwiftData

@Model
final class Settings {
    var maxSpeed: Double
    var fuelEconomyMinSpeed: Double
    var fuelEconomyMaxSpeed: Double
    var coffeeBreakDelay: Double
    var mode: Mode

    init(
        maxSpeed: Double,
        fuelEconomyMinSpeed: Double,
        fuelEconomyMaxSpeed: Double,
        coffeeBreakDelay: Double,
        mode: Mode
    ) {
        self.maxSpeed = maxSpeed
        self.fuelEconomyMinSpeed = fuelEconomyMinSpeed
        self.fuelEconomyMaxSpeed = fuelEconomyMaxSpeed
        self.coffeeBreakDelay = coffeeBreakDelay
        self.mode = mode
    }
}
