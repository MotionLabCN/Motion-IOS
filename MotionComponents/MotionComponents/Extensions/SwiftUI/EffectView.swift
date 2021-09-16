//
//  EffectView.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/15.
//

import SwiftUI

public struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    public init(style: UIBlurEffect.Style = .systemMaterial) {
        self.style = style
    }
    
    public func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    public func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
