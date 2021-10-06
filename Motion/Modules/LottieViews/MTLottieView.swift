//
//  LottieView.swift
//  RoadsidePicnic
//
//  Created by 凉炘 on 2021/2/25.
//

import SwiftUI
import Lottie

struct MTLottieView: UIViewRepresentable {
    
    //声明文件名作为Lottie变量以便于重复使用
    var lottieFliesName : String
    var loopMode: LottieLoopMode
    var speed : CGFloat = 1
    
    
    typealias UIViewType = UIView
    
    //装载洛丽塔动画
    // ——————————————————————————————————————————————————————————————————————————

    func makeUIView(context:
                        UIViewRepresentableContext<MTLottieView>) -> UIView {
        
        let view = UIView(frame: .zero)
        
        let animationView = AnimationView()
        let animation = Animation.named(lottieFliesName)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        //播放模式
        animationView.loopMode = loopMode
        //播放速度
        animationView.animationSpeed = speed
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        return view
    }
    //    —————————————————————————————————————————————————————————————————————
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<MTLottieView>) {
    }
}
