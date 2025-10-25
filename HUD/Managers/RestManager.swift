//
//  RestManager.swift
//  HUD
//
//  Created by Ярослав Куприянов on 24.10.2025.
//

import Foundation
import Combine

final class RestManager: ObservableObject {
    @Published var isNeedRest = false

    private let soundManager: SoundManagerProtocol = SoundManager()
    private var timer: AnyCancellable?

    func startTimer(coffeeBreakDelay: TimeInterval) {
        timer?.cancel()
        timer = Timer
            .publish(every: coffeeBreakDelay, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.isNeedRest = true
                self?.soundManager.play(Sound.allCases.randomElement() ?? Sound.notification0)
            }
    }

    func stopTimer() {
        timer?.cancel()
        timer = nil
        isNeedRest = false
    }

    func handle(_ speed: Double, coffeeBreakDelay: Double) {
        if speed >= 10, timer == nil {
            startTimer(coffeeBreakDelay: coffeeBreakDelay)
        } else {
            stopTimer()
        }
    }
}
