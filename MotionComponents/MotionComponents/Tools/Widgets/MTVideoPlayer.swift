//
//  MTVideoPlayer.swift
//  MotionDesgin
//
//  Created by 梁泽 on 2021/9/22.
//

import SwiftUI
import AVKit


public struct MTVideoPlayer: UIViewControllerRepresentable {
    public var player: AVPlayer
    
    public init(_ player: AVPlayer) {
        self.player = player
    }
    
    public func makeUIViewController(context: Context) -> AVPlayerViewController {
        let vc = AVPlayerViewController()
        vc.showsPlaybackControls = false
        vc.videoGravity = .resize
        return vc
        
    }
    
    public func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        uiViewController.player = player
        player.play()
    }
}
