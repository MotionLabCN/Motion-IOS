//
//  View+mt.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/16.
//

import SwiftUI


public extension View {
    func mtFrame(width: CGFloat, height: CGFloat, alignment: Alignment = .center) -> some View {
//        frame(width: width * MTSCALE(), height: height * MTSCALE(), alignment: alignment)
        frame(width: width, height: height, alignment: alignment)
    }
    
    /// 加圆边框
    func mtBoderCircle(_ color: Color = .white, lineWidth: CGFloat = 3) -> some View {
        modifier(MTImageBorder(color: color, lineWidth: lineWidth))
    }
}



//MARK: - 圆形边框
struct MTImageBorder: ViewModifier {
    let color: Color
    let lineWidth: CGFloat
    func body(content: Content) -> some View {
        content
            .overlay(
                Circle()
                    .strokeBorder(color, lineWidth: lineWidth)
            )
    }
}

