//
//  Button+mt.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/9.
//

import SwiftUI


public enum MTTapAnimationStyle {
    // normal 啥反应都没有
    case system, normal, rotation3D
    case overlayOrScale(isOverlay: Bool = true, scale: CGFloat = 0.97)
}


//MARK: - 按钮样式类型
public enum MTButtonStyle {
    case smallDefult(isEnable: Bool = true), smallStorker(isEnable: Bool = true)
    case mainDefult(isEnable: Bool = true), mainStorKer(isEnable: Bool = true)
    case cricleDefult(_ color: Color), cricleMini(_ color: Color = Color.mt.accent_500)
    case mainGradient
}


//MARK: - 样式Style Modifier
struct MTButtonStyleModifier: ViewModifier {
    let style: MTButtonStyle
    let customBackground: Bool
    
    func body(content: Content) -> some View {
        if customBackground {
            beforeBackGroundView(content: content)
                .contentShape(Capsule(style: .continuous))
        } else {
            beforeBackGroundView(content: content)
                .background(style.backgroundShape())
                .contentShape(Capsule(style: .continuous))
        }
    }
    
    @ViewBuilder
    func beforeBackGroundView(content: Content) -> some View {
        switch style {
        case .smallDefult, .smallStorker:
            content
                .foregroundColor(style.colors.text)
                .font(style.textFont)
                .padding(.init(horizontal: 32, vertical: 12))
        case  .mainDefult, .mainStorKer, .mainGradient:
            content
                .foregroundColor(style.colors.text)
                .font(style.textFont)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
        case .cricleDefult, .cricleMini:
            content
                .frame(width: style.size.width, height: style.size.height)
        }
    }
}



//MARK: - 自定义ButtonSytle
extension ButtonStyle {
    @ViewBuilder
    func makeOverlay(isPressed: Bool) -> some View {
        if isPressed {
            Color.white
                .clipShape(Capsule(style: .continuous))
                .blur(radius: 0.3)
                .opacity(0.4)
        } else {
            EmptyView()
        }
        
    }
}

/// 无样式
struct MTButtonNormalStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
/// 3D动画
struct MTRotation3DButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed
        
        configuration.label
            .rotation3DEffect(Angle(degrees: isPressed ? 7 : 0), axis: (x: -1, y: 0, z: 0), anchor: .leading)
            .animation(.spring())
    }
}

/// 可选isOverlay scale
struct MTButtonAnimationStyle: ButtonStyle  {
    let isOverlay: Bool
    let scale: CGFloat
    
    public func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed
        
        if isOverlay {
            configuration.label
                .overlay(makeOverlay(isPressed: isPressed))
                .scaleEffect(isPressed ? scale : 1)
        } else {
            configuration.label
                .scaleEffect(isPressed ? scale : 1)
        }
    }
    
}
// 特殊 使
struct MTButtonCustomStyle: ButtonStyle  {
    let style: MTButtonStyle
    let customBackground: Bool
   
    func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed
        let scale: CGFloat = 0.97
        
        configuration.label
            .modifier(MTButtonStyleModifier(style: style, customBackground: customBackground))
            .overlay(makeOverlay(isPressed: isPressed))
            .scaleEffect(isPressed ? scale : 1)
    }
    
}



//MARK: - 按钮类型扩展
extension MTButtonStyle: Identifiable {
    public var id: Int {
        switch self {
        case let .smallDefult(isEnable): return 10 + (isEnable ? 0 : 1)
        case let .smallStorker(isEnable): return 20 + (isEnable ? 0 : 1)
        case let .mainDefult(isEnable): return 30 + (isEnable ? 0 : 1)
        case let .mainStorKer(isEnable): return 40 + (isEnable ? 0 : 1)
        case .cricleDefult(let color):  return 50 + color.hashValue
        case .cricleMini(let color): return 60 + color.hashValue
        case .mainGradient: return 70
        }
    }
    
    public var title: String {
        switch self {
        case  let .smallDefult(isEnable), let .mainDefult(isEnable): return isEnable ? "Defult" : "Unable"
        case let .smallStorker(isEnable), let .mainStorKer(isEnable): return isEnable ? "Storker" : "StorkerUnable"
        case .cricleDefult: return "Defult"
        case .cricleMini: return "Unable"
        case .mainGradient: return "gradient"
        }
    }
    
    //配置
    public var colors: (tint: Color, text: Color) {
        switch self {
        case  .smallDefult(let isEnable), .mainDefult(let isEnable):
            return isEnable ? (tint: .mt.gray_900, text: .white) : (tint: .mt.gray_200, text: .mt.gray_600)
        case .smallStorker(let isEnable), .mainStorKer(let isEnable):
            return isEnable ? (tint: .mt.gray_200, text: .mt.gray_900) :  (tint: .mt.gray_200, text: .mt.gray_400)
        case .cricleDefult, .cricleMini:
            return (tint: .mt.gray_200, text: .mt.gray_600)
        case .mainGradient:
            return (tint: .white, text: .white)
        }
    }
    
    public var textFont: Font {
        switch self {
        case .smallDefult, .smallStorker: return .mt.body3.mtBlod()
        case .mainDefult, .mainStorKer, .mainGradient: return .mt.body1.mtBlod()
        case .cricleDefult, .cricleMini: return .mt.body3.mtBlod()
        }
    }
    
    public var size: CGSize {
        switch self {
        case .cricleDefult: return .init(width: 56, height: 56)
        case .cricleMini: return .init(width: 32, height: 32)
        default: return .zero //不用
        }
    }
    
    public var isEnable: Bool {
        switch self {
        case  let .smallDefult(isEnable), let .smallStorker(isEnable), let .mainDefult(isEnable), let .mainStorKer(isEnable): return isEnable
        case .cricleDefult, .cricleMini: return true
        case .mainGradient :  return true
        }
    }
    
    @ViewBuilder
    public func backgroundShape() -> some View {
        switch self {
        case .smallDefult, .mainDefult:
            Capsule(style: .continuous)
                .foregroundColor(colors.tint)
        case .smallStorker, .mainStorKer:
            Capsule(style: .continuous)
                .stroke(colors.tint)
        case let .cricleDefult(color): Circle().fill(color)
        case let .cricleMini(color): Circle().fill(color)
        case .mainGradient:
            RadialGradient(colors: [.mt.accent_purple_weak, .mt.accent_purple], center: .topTrailing, startRadius: -5, endRadius: 100)
                .clipShape(Capsule(style: .continuous))
        }
    }
}


