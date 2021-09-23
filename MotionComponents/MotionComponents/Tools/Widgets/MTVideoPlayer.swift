//
//  MTVideoPlayer.swift
//  MotionDesgin
//
//  Created by 梁泽 on 2021/9/22.
//

import SwiftUI
import AVKit


public typealias MTVideoPlayerStatus = AVPlayerLooper.Status
public struct MTVideoPlayer: UIViewControllerRepresentable {
    private var player: AVQueuePlayer
    private var playerLooper: AVPlayerLooper
    
    @Binding var status: MTVideoPlayerStatus?

    public init(_ item: AVPlayerItem, status: Binding<MTVideoPlayerStatus?>) {
        player =  AVQueuePlayer()
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
        player.play()
        _status = status
    }
    
    public func makeUIViewController(context: Context) -> AVPlayerViewController {
        let vc = AVPlayerViewController()
        
        vc.showsPlaybackControls = false
        vc.videoGravity = .resizeAspectFill
        vc.player = player
        return vc
    }
    
    public func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
//        uiViewController.player = player
//        player.play()
    }
    
    public func makeCoordinator() -> MTVideoPlayer.Coordinator {
        let ob = Coordinator(playerLooper: playerLooper)
        ob.statusDidChange =  { status in
            self.status = status
        }
        return ob
    }
}

extension MTVideoPlayer {
    public class Coordinator {
        private var itemObservation: NSKeyValueObservation?
        var statusDidChange: ((MTVideoPlayerStatus) -> Void)?
        
        init(playerLooper: AVPlayerLooper) {
            itemObservation?.invalidate()
            
            itemObservation = playerLooper.observe(\.status, changeHandler: { [weak self] looper, change in
                self?.statusDidChange?(looper.status)
            })
        }
        
        deinit {
            itemObservation?.invalidate()
        }
    }
}
