//
//  LocationManager.swift
//  HUD
//
//  Created by Ярослав Куприянов on 23.10.2025.
//

import Foundation
import CoreLocation
import Combine
import SwiftUI

final class LocationManager: NSObject, ObservableObject {
    @Published var isNoGps = false
    @Published var speed: Double = 0.0
    @Published var coordinate: CLLocationCoordinate2D?

    @Bindable var savedSettings: Settings

    private let locationManager = CLLocationManager()
    private let soundManager: SoundManagerProtocol
    private var speedExceeded = false

    // MARK: Init
    init(
        soundManager: SoundManagerProtocol,
        savedSettings: Settings
    ) {
        self.soundManager = soundManager
        self.savedSettings = savedSettings
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let last = locations.last else {
            isNoGps = true
            speed = 0
            coordinate = nil
            return
        }
        isNoGps = false
        speed = max(last.speed, .zero) * 3.6
        coordinate = last.coordinate
        notify()
    }

    func notify() {
        if speed >= savedSettings.maxSpeed {
            if !speedExceeded {
                soundManager.play(savedSettings.speedExceededSound)
            }
            speedExceeded = true
        } else {
            speedExceeded = false
        }
    }
}
