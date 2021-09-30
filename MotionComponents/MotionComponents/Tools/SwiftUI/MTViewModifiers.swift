//
//  MTViewModifiers.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/13.
//

import SwiftUI

//MARK: - 下滑线
public struct MTUnderlineModifier: ViewModifier {
    public var lineColor: Color
    
    public init(lineColor: Color) {
        self.lineColor = lineColor
    }
    
    public func body(content: Content) -> some View {
        content
            .overlay(
                lineColor.frame(height: 1)
                    .frame(maxWidth: .infinity)
                , alignment: .bottom)
    }
}

//MARK: - 附加文字
public struct MTAttachTextModifier: ViewModifier {
    public var text: String?
    public let attached: Attached

    public enum Attached {
        case progressView
        case textField
    }
    
    public init(text: String?, attached: Attached) {
        self.text = text
        self.attached = attached
    }
    
    
    public func body(content: Content) -> some View {
        if let text = text, text.count > 0 {
            newContentWith(content: content, text: text)
        } else {
            content
        }
    }
    
    @ViewBuilder
    private func newContentWith(content: Content, text: String) -> some View {
        switch attached {
        case .progressView:
            HStack(spacing: 8, content: {
                content
                Text(text)
                    .font(.mt.body2, textColor: .mt.gray_900)
            })
            .padding()
        case .textField:
            VStack(spacing: nil, content: {
                content
                Text(text)
                    .font(.mt.caption1, textColor: .mt.gray_600)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
            })
        }
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
                    .stroke(lineWidth: 3)
                    .foregroundColor(color)
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



//MARK: - 添加角标
struct MTCardStyleViewModifier :ViewModifier {
    let insets: EdgeInsets
    
    func body(content: Content) -> some View {
        content
            .padding(insets)
            .background(Color.white)
            .clipShape(RoundedRectangle.init(cornerSize: CGSize(width: 18, height: 24), style: .continuous))
            .mtShadow(type: .shadowLow)
    }
}

