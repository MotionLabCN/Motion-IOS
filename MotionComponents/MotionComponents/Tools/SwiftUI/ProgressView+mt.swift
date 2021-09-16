//
//  Progress+mt.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/13.
//

import SwiftUI


public extension ProgressView {
    @ViewBuilder
    func mt(style: MTProgressViewStyle, withText text: String? = nil) -> some View {
        if let text = text, text.count > 0 {
            self
                .modifier(MTProgressViewModifier(style: style))
                .modifier(MTAttachTextModifier(text: text, attached: .progressView))
                .padding(17)
                .frame(maxWidth: ScreenWidth() - 150)
                .background(Color.mt.gray_200.cornerRadius(12))
        } else {
            self
                .modifier(MTProgressViewModifier(style: style))
        }
    }
    
    func mtProgressLine() -> some View {
        self.progressViewStyle(MTProgressLineStyle())
    }
}

//MARK: - 线
struct MTProgressLineStyle: ProgressViewStyle {
    let height: CGFloat = 4
    let fillColor: Color = .white
    func makeBody(configuration: Configuration) -> some View {
        Capsule()
            .fill(fillColor)
            .frame(height: height)
            .overlay(
                GeometryReader(content: { geometry in
                    Capsule()
                        .fill(Color.mt.accent_800)
                        .frame(width: geometry.width * CGFloat((configuration.fractionCompleted ?? 0)), height: geometry.height)
                        .animation(.easeInOut)
                })
            )
    }
}

//MARK: - 菊花
struct MTProgressViewModifier: ViewModifier {
    let style: MTProgressViewStyle
    
    func body(content: Content) -> some View {
        switch style {
        case .mini: content
        case .mid:
            content
                .scaleEffect(1.5)
                .padding(5)
        }
    }
}

////MARK: - Font
public enum MTProgressViewStyle: Int {
    case mini //系统直接初始化 默认大小为20
    case mid
}



