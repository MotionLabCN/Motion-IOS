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
}
