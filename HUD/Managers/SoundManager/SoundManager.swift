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
    private var player: AVAudioPlayer?
    private var player1: AVAudioPlayer?
    private var player2: AVAudioPlayer?
    private let format = "wav"

    init() {
        try? AVAudioSession.sharedInstance().setCategory(.playback, options: .mixWithOthers)
        try? AVAudioSession.sharedInstance().setActive(true)
        prewarm()
    }

    func prewarm() {
        player = createPlayer(forResource: Sound.notification0.rawValue)
        player1 = createPlayer(forResource: Sound.notification1.rawValue)
        player2 = createPlayer(forResource: Sound.notification2.rawValue)
    }

    func createPlayer(forResource: String) -> AVAudioPlayer? {
        guard let url = Bundle.main.url(forResource: forResource, withExtension: format) else { return nil }
        let player = try? AVAudioPlayer(contentsOf: url)
        player?.prepareToPlay()
        return player
    }

    func play(_ sound: Sound) {
        switch sound {
        case .notification0:
            player?.play()
        case .notification1:
            player1?.play()
        case .notification2:
            player2?.play()
        }
    }
}
