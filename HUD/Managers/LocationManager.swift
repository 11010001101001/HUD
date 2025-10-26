//
//  LocationManager.swift
//  HUD
//
//  Created by Ярослав Куприянов on 23.10.2025.
//

import Foundation
import CoreLocation
import Combine

final class LocationManager: NSObject, ObservableObject {
    @Published var speed: Double = 0.0
    @Published var coordinate: CLLocationCoordinate2D?

    private let locationManager = CLLocationManager()
    private let soundManager: SoundManagerProtocol
    private let maxSpeed: Double

    // MARK: Init
    init(
        soundManager: SoundManagerProtocol,
        maxSpeed: Double
    ) {
        self.soundManager = soundManager
        self.maxSpeed = maxSpeed
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
            speed = 0
            coordinate = nil
            return
        }
        speed = max(last.speed, .zero) * 3.6
        coordinate = last.coordinate
        
        if speed >= maxSpeed {
            soundManager.play(.speed)
        }
    }
}
