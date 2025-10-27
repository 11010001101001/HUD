//
//  WeatherManager.swift
//  HUD
//
//  Created by Ярослав Куприянов on 26.10.2025.
//

import Foundation
import Combine
import CoreLocation

final class WeatherManager: ObservableObject {
    @Published var locationName = ""
    @Published var temperature = ""
    @Published var isSnow = false
    @Published var isRain = false

    private let tenMinutes: TimeInterval = 600
    private let apiKey = "03d688b745c444359ca66b771bccd5f4"
    private var isTimerLaunched = false

    private var coordinate: CLLocationCoordinate2D? {
        didSet {
            guard !isTimerLaunched, coordinate != nil else { return }
            launchTimer()
            isTimerLaunched = true
        }
    }

    private var cancellables = Set<AnyCancellable>()
}

// MARK: - Public
extension WeatherManager {
    func updateCoordinate(_ coordinate: CLLocationCoordinate2D?) {
        self.coordinate = coordinate
    }
}

// MARK: - Private
private extension WeatherManager {
    func launchTimer() {
        updateWeatherConditions()

        Timer
            .publish(every: tenMinutes, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] value in
                self?.updateWeatherConditions()
            }
            .store(in: &cancellables)
    }

    func updateWeatherConditions() {
        guard let coordinate else { return }

        let lat = coordinate.latitude
        let lon = coordinate.longitude

        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric&lang=ru") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .retry(3)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.handle(error)
                }
            } receiveValue: { [weak self] value in
                self?.handle(value)
            }
            .store(in: &cancellables)
    }

    func handle(_ error: any Error) {
        locationName = ""
        temperature = ""
        isSnow = false
        isRain = false
    }

    func handle(_ response: WeatherResponse) {
        locationName = response.name ?? ""
        let temperature = Int(response.main?.temp ?? .zero)
        self.temperature = String(temperature) + " °C"

        if temperature <= 3 {
            isSnow = true
            isRain = false
        } else {
            isSnow = false
            let description = (response.weather?.first?.description ?? "").lowercased()
            guard let regex = try? NSRegularExpression(pattern: "\\bдожд\\w*\\b", options: []) else { return }
            isRain = regex.firstMatch(in: description, options: [], range: NSRange(description.startIndex..., in: description)) != nil
        }
    }
}
