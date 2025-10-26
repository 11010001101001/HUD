//
//  SoundManager.swift
//  HUD
//
//  Created by Ярослав Куприянов on 24.10.2025.
//

import Foundation
import AVFoundation

protocol SoundManagerProtocol {
    func play(_ sound: Sound)
}

final class SoundManager: SoundManagerProtocol {
    private var speedPlayer: AVAudioPlayer?
    private var healthPlayer: AVAudioPlayer?
    private let format = "wav"
    
    init() {
        try? AVAudioSession.sharedInstance().setCategory(.playback, options: .mixWithOthers)
        try? AVAudioSession.sharedInstance().setActive(true)
        prewarm()
    }
    
    func prewarm() {
        speedPlayer = createPlayer(forResource: Sound.speed.rawValue)
        healthPlayer = createPlayer(forResource: Sound.health.rawValue)
    }
    
    func createPlayer(forResource: String) -> AVAudioPlayer? {
        guard let url = Bundle.main.url(forResource: forResource, withExtension: format) else { return nil }
        let player = try? AVAudioPlayer(contentsOf: url)
        player?.prepareToPlay()
        return player
    }
    
    func play(_ sound: Sound) {
        switch sound {
        case .speed:
            speedPlayer?.play()
        case .health:
            healthPlayer?.play()
        }
    }
}
