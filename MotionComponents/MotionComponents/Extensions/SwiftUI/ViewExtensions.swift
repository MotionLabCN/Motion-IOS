//
//  ViewExtension.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/7.
//

import SwiftUI

public extension View {
    /// 直接给size和对齐
    func frame(size: CGSize, alignment: Alignment = .center) -> some View {
        self.frame(width: size.width, height: size.height, alignment: alignment)
    }
    
    /// 单边圆角
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    /// 隐藏 List 中的 分割线
    func hideRowSeparator(background: Color = .white) -> some View {
        modifier(HideRowSeparatorModifier(background: background))
    }
    
}




struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}



struct HideRowSeparatorModifier: ViewModifier {

  static let defaultListRowHeight: CGFloat = 44

  var background: Color

  init( background: Color) {
    var alpha: CGFloat = 0
    if #available(iOS 14.0, *) {
        UIColor(background).getWhite(nil, alpha: &alpha)
        assert(alpha == 1, "Setting background to a non-opaque color will result in separators remaining visible.")
    }
    self.background = background
  }

  func body(content: Content) -> some View {
    content
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: Self.defaultListRowHeight)
        .listRowInsets(EdgeInsets())
        .overlay(
            VStack {
                background
                .frame(maxWidth: .infinity)
                .frame(height: 1)
                .background(background)
                Spacer()
                background
                .frame(maxWidth: .infinity)
                .frame(height: 1)
                .background(background)
            }
            .padding(.top, -1)
        )
  }
}


