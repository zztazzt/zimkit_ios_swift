//
//  MessageAudioPlayer.swift
//  ZIMKit
//
//  Created by Kael Ding on 2022/9/6.
//

import Foundation
import AVFAudio
import AVFoundation

class MessageAudioPlayer: NSObject, AVAudioPlayerDelegate {
    private(set) var currentMessage: AudioMessage?
    private var player: AVAudioPlayer?
    weak var tableView: UITableView?

    convenience init(with tableView: UITableView) {
        self.init()
        self.tableView = tableView
    }

    func play(with message: AudioMessage) -> Bool {

        stopAudioAnimation()

        if message === currentMessage {
            if player?.isPlaying == true {
                player?.stop()
                player = nil
                return true
            }
        }

        player = nil
        currentMessage = message
        
        var isHeadphones = false
        for desc in AVAudioSession.sharedInstance().currentRoute.outputs
        where desc.portType == .bluetoothA2DP ||
        desc.portType == .headphones ||
        desc.portType == .bluetoothLE ||
        desc.portType == .bluetoothHFP {
            isHeadphones = true
            break
        }

        let isSpeakerOff = UserDefaults.standard.bool(forKey: "is_message_speaker_off")
        var options: AVAudioSession.CategoryOptions = []
        if !isSpeakerOff {
            options.insert(.defaultToSpeaker)
        }
        try? AVAudioSession.sharedInstance().setCategory(
            isHeadphones ? .playback : .playAndRecord,
            options: options)
        do {
            if isSpeakerOff {
                try AVAudioSession.sharedInstance().overrideOutputAudioPort(.none)
            }
            let data = try Data(contentsOf: URL(fileURLWithPath: message.fileLocalPath))
            player = try AVAudioPlayer(data: data)
        } catch let error {
            print(error)
            return false
        }

        guard let player = player else { return false }

        player.delegate = self
        if player.prepareToPlay() {
            startAudioAnimation()
            return player.play()
        }
        return false
    }

    func stop() {
        stopAudioAnimation()
        player?.stop()
        player = nil
    }

    private func startAudioAnimation() {
        currentMessage?.isPlayingAudio = true
        guard let cells = tableView?.visibleCells else { return }
        for cell in cells {
            guard let cell = cell as? AudioMessageCell else { continue }
            if cell.message === currentMessage {
                cell.startAudioAnimation()
                currentMessage?.isPlayingAudio = true
            }
        }
    }

    private func stopAudioAnimation() {
        currentMessage?.isPlayingAudio = false
        guard let cells = tableView?.visibleCells else { return }
        for cell in cells {
            guard let cell = cell as? AudioMessageCell else { continue }
            cell.stopAudioAnimation()
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        stopAudioAnimation()
    }
}
