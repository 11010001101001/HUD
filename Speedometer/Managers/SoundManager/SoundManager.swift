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
    private var players = [Sound: AVAudioPlayer]()
    private let format = "wav"
    
    init() {
        try? AVAudioSession.sharedInstance().setCategory(.playback, options: .mixWithOthers)
        try? AVAudioSession.sharedInstance().setActive(true)
        prewarm()
    }
    
    func prewarm() {
        Sound.allCases.forEach {
            let player = createPlayer(forResource: $0)
            players[$0] = player
        }
    }
    
    func createPlayer(forResource: Sound) -> AVAudioPlayer? {
        guard let url = Bundle.main.url(
            forResource: forResource.rawValue,
            withExtension: format
        ) else { return nil }

        let player = try? AVAudioPlayer(contentsOf: url)
        player?.prepareToPlay()
        return player
    }
    
    func play(_ sound: Sound) {
        players[sound]?.play()
    }
}
