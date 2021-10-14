//
//  MTAnimationViewModifier.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/10/8.
//

import SwiftUI


struct MTAnimationViewModifier: ViewModifier {
    let animationed: Animation?
    @State private var canAnimation = false
    func body(content: Content) -> some View {
        content
            .animation(canAnimation ? animationed : nil)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    canAnimation = true
                }
            }
    }
}
