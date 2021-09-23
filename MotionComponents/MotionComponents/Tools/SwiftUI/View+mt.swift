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
    
    /// 添加bagdge
    func mtAddBadge( number : Int , isShow : Bool, size: CGSize = .init(width: 16, height: 16), offset: CGSize = .init(width: 8, height: -8)) -> some View {
        modifier(MTAddBadgeViewModifier(number: number, isShow: isShow, size: size, offset: offset))
    }
}



//MARK: - 圆形边框
struct MTImageBorder: ViewModifier {
    let color: Color
    let lineWidth: CGFloat
    func body(content: Content) -> some View {
        content
            .overlay(
                Capsule(style: .continuous)
                .strokeBorder(color, lineWidth: lineWidth)
            )
    }
}


//MARK: - 添加角标
struct MTAddBadgeViewModifier: ViewModifier {
    let number: Int
    let isShow: Bool
    let size: CGSize
    let offset: CGSize
    
    func body(content: Content) -> some View {
        if isShow {
            content
                .overlay(
                    Circle()
                        .frame(size: size)
                        .foregroundColor(.mt.accent_700)
                        .overlay(Text("\(number)").font(.mt.caption2.mtBlod() , textColor: .white))
                        .offset(offset)
                        .disabled(false)
                    , alignment: .topTrailing)
        } else {
            content
        }
    }
}




