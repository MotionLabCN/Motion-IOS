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
    
    func mtProgressLine(height: CGFloat = 4, fillColor: Color = .white) -> some View {
        self.progressViewStyle(MTProgressLineStyle(height: height, fillColor: fillColor))
    }
}

//MARK: - 线
struct MTProgressLineStyle: ProgressViewStyle {
    let height: CGFloat
    let fillColor: Color
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




//MARK: - 扩展
struct MTViewTopProgressViewModifier: ViewModifier {
    let isShow: Bool
    let text: String?
    let usingBackgorund: Bool
    
    func body(content: Content) -> some View {
        if isShow {
            content
                .overlay(
                    ZStack {
                        if usingBackgorund {
                            Color.black.opacity(0.3)
                                .ignoresSafeArea(edges: .all)
                        }
                        
                        ProgressView().mt(style: .mid, withText: text)
                    }
                )
        } else {
            content
        }
      
    }
}

struct MTPlaceholderProgressViewModifier: ViewModifier {
    let isPlaceholder: Bool
    let progressColor: Color
    
    func body(content: Content) -> some View {
        if isPlaceholder {
            ProgressView().mt(style: .mini)
                .progressViewStyle(CircularProgressViewStyle(tint: progressColor))
        } else {
            content
        }
            
    }
}



