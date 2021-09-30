//
//  Fond+mt.swift
//  MotionDesgin
//
//  Created by 梁泽 on 2021/9/7.
//

import SwiftUI

extension Spacer: MTCompatible {
    private func using() {
        _ = Spacer.mt
    }
}


public extension MT where Base == Spacer {
    /// 小间隙 8
    static func min() -> some View  { MTSpaceing.min.value }
    /// 中等间隙 16
    static func mid() -> some View  { MTSpaceing.mid.value }
    /// 大间隙 32
    static func max() -> some View  { MTSpaceing.max.value }
    /// tabbar
    static func tabbar() -> some View { Color.clear.frame(height: TabbarHeight) }
    /// navbar
    static func navbar() -> some View { Color.clear.frame(height: NavBarH) }
    /// custom
    static func custom(_ size: CGSize) -> some View { Color.clear.frame(width: size.width, height: size.height) }
    static func custom(_ height: CGFloat) -> some View { Color.clear.frame(height: height) }

}


//MARK: - Font
public enum MTSpaceing: CGFloat, CaseIterable, Identifiable {
    public var id: Int { Int(self.rawValue) }
    
    case min = 8.0
    case mid = 16.0
    case max = 32.0
  
    public var value: some View {
        Color(.clear).frame(width: self.rawValue, height: self.rawValue)
    }
    
    public var text: String {
        switch self {
        case .min: return "min 8"
        case .mid: return "mid 16"
        case .max: return "max 32"
        }
    }
}
