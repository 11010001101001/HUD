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

    private let soundManager: SoundManagerProtocol
    private var timer: AnyCancellable?

    // MARK: Init
    init(soundManager: SoundManagerProtocol) {
        self.soundManager = soundManager
    }
}

// MARK: - Public
extension RestManager {
    func checkIsNeedRest(_ speed: Double, coffeeBreakDelay: Double) {
        if speed >= 10 {
            guard timer == nil else { return }
            startTimer(coffeeBreakDelay: coffeeBreakDelay)
        } else {
            stopTimer()
        }
    }
}

// MARK: - Private
private extension RestManager {
    func startTimer(coffeeBreakDelay: TimeInterval) {
        timer?.cancel()
        timer = Just(())
            .delay(for: .seconds(coffeeBreakDelay), scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] in
                self?.isNeedRest = true
                self?.soundManager.play(.health)
            })
    }

    func stopTimer() {
        timer?.cancel()
        timer = nil
        isNeedRest = false
    }
}
