//
//  Button+mt.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/9.
//

import SwiftUI


//MARK: - Button扩展
public extension View {
    func custom(_ style: MTButtonStyle.Style) -> some View {
        self
            .buttonStyle(MTButtonStyle(style: style))
            .disabled(!style.isEnable)
    }

    func mtAnimation(isOverlay: Bool = true, scale: CGFloat = 0.97) -> some View {
        self.buttonStyle(MTButtonAnimationStyle(isOverlay: isOverlay, scale: scale))
    }
    
  
}


//MARK: - 自定义ButtonSytle
extension ButtonStyle {
    @ViewBuilder
    func makeOverlay(isPressed: Bool) -> some View {
        if isPressed {
            Color.white
                .clipShape(Capsule())
                .blur(radius: 0.3)
                .opacity(0.4)
        } else {
            EmptyView()
        }
       
    }
}



//MARK: - 自定义Style Modifier
public struct MTButtonStyleModifier: ViewModifier {
    let style: MTButtonStyle.Style
    let customBackground: Bool
    
    public init(style: MTButtonStyle.Style, customBackground: Bool = false) {
        self.style = style
        self.customBackground = customBackground
    }
    
    public func body(content: Content) -> some View {
        if customBackground {
            beforeBackGroundView(content: content)
        } else {
            beforeBackGroundView(content: content)
                .background(style.backgroundShape())
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
        case  .mainDefult, .mainStorKer:
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

//MARK: - 自定义Style
public struct MTButtonAnimationStyle: ButtonStyle  {
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

extension MTButtonStyle {
    public enum Style {
        case smallDefult(isEnable: Bool = true), smallStorker(isEnable: Bool = true)
        case mainDefult(isEnable: Bool = true), mainStorKer(isEnable: Bool = true)
        case cricleDefult(_ color: Color), cricleMini(_ color: Color = Color.mt.accent_500)
    }
}

public struct MTButtonStyle: ButtonStyle  {
    public let style: Style
    
    public init(style: MTButtonStyle.Style) {
        self.style = style
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed
        let scale: CGFloat = 0.97
        
        configuration.label
            .modifier(MTButtonStyleModifier(style: style))
            
            
            .overlay(makeOverlay(isPressed: isPressed))
            .scaleEffect(isPressed ? scale : 1)            
    }

}

extension MTButtonStyle.Style: Identifiable {
    public var id: Int {
        switch self {
        case let .smallDefult(isEnable): return 10 + (isEnable ? 0 : 1)
        case let .smallStorker(isEnable): return 20 + (isEnable ? 0 : 1)
        case let .mainDefult(isEnable): return 30 + (isEnable ? 0 : 1)
        case let .mainStorKer(isEnable): return 40 + (isEnable ? 0 : 1)
        case .cricleDefult(let color):  return 50 + color.hashValue
        case .cricleMini(let color): return 60 + color.hashValue
        }
    }
    
    public var title: String {
        switch self {
        case  let .smallDefult(isEnable), let .mainDefult(isEnable): return isEnable ? "Defult" : "Unable"
        case let .smallStorker(isEnable), let .mainStorKer(isEnable): return isEnable ? "Storker" : "StorkerUnable"
        case .cricleDefult: return "Defult"
        case .cricleMini: return "Unable"
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
        }
    }

    public var textFont: Font {
        switch self {
        case .smallDefult, .smallStorker: return .mt.body3.mtBlod()
        case .mainDefult, .mainStorKer: return .mt.body1.mtBlod()
        case .cricleDefult, .cricleMini: return .mt.body3.mtBlod()
        }
    }
    
    public var size: CGSize {
        switch self {
        case .smallDefult, .smallStorker: return .init(width: 91, height: 37)
        case .mainDefult, .mainStorKer:  return .init(width: .infinity, height: 57.0)
        case .cricleDefult: return .init(width: 56, height: 56)
        case .cricleMini: return .init(width: 32, height: 32)
        }
    }
    
    public var isEnable: Bool {
        switch self {
        case  let .smallDefult(isEnable), let .smallStorker(isEnable), let .mainDefult(isEnable), let .mainStorKer(isEnable): return isEnable
        case .cricleDefult, .cricleMini: return true
        }
    }

    @ViewBuilder
    public func backgroundShape() -> some View {
        switch self {
        case .smallDefult, .mainDefult:
            Capsule()
                .foregroundColor(colors.tint)
        case .smallStorker, .mainStorKer:
            Capsule()
                .stroke(colors.tint)
        case let .cricleDefult(color): Circle().fill(color)
        case let .cricleMini(color): Circle().fill(color)
        }
    }
}


