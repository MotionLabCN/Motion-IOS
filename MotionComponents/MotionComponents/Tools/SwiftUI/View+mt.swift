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
    
    func mtFrame(square: CGFloat, alignment: Alignment = .center) -> some View {
        frame(width: square, height: square, alignment: alignment)
    }
    
    /// 给视图加动画 NavgationView里的动画
    func mtAnimation(_ animation: Animation? = .default) -> some View {
        modifier(MTAnimationViewModifier(animationed: animation))
    }
    
    /// 加圆边框
    func mtBoderCircle(_ color: Color = .white, lineWidth: CGFloat = 3) -> some View {
        modifier(MTImageBorder(color: color, lineWidth: lineWidth))
    }
    
    /// 添加bagdge
    func mtAddBadge( number : Int , isShow : Bool, size: CGSize = .init(width: 16, height: 16), offset: CGSize = .init(width: 8, height: -8)) -> some View {
        modifier(MTAddBadgeViewModifier(number: number, isShow: isShow, size: size, offset: offset))
    }
    
    ///
    func mtCardStyle(insets: EdgeInsets = .init(horizontal: 16, vertical: 16)) -> some View {
        modifier(MTCardStyleViewModifier(insets: insets))
    }
    
    /// 给注册路由表
    func mtRegisterRouter<Destination>(isActive: Binding<Bool>, @ViewBuilder destination: (() -> Destination) ) -> some View  where Destination: View {
        background(
            NavigationLink(isActive: isActive, destination: destination, label: {
                EmptyView()
            })
        )
    }
    
    /// 视图中心点 覆盖progressView
    func mtTopProgress(_ isShow: Bool, usingBackgorund: Bool = false, text: String? = nil) -> some View {
        modifier(MTViewTopProgressViewModifier(isShow: isShow, text: text, usingBackgorund: usingBackgorund))
    }
    
    /// 视图占位加载
    func mtPlaceholderProgress(_ isPlaceholder: Bool, progressColor: Color = .black) -> some View {
        modifier(MTPlaceholderProgressViewModifier(isPlaceholder: isPlaceholder, progressColor: progressColor))
    }
    
    /// toast MTPushNofi
    func mtToast(isPresented: Binding<Bool>, text: String, style: MTPushNofi.PushNofiType = .defult, dismissTime:  MTToast.DismissTime = .auto(duration: 3), postion: MTToast.Postion = .bottom(offsetY: 0), didClickClose: Block_T? = nil) -> some View {
        modifier(
            MTToastViewModifier(isPresented: isPresented, dismissTime: dismissTime, postion: postion, content: {
                MTPushNofi(text: text, style: style, didClickClose: didClickClose)
            })
        )
    }
    
    /// toast MTPushNofi using config
    func mtToast(config: MTToastConfig) -> some View  {
        modifier(
            MTToastViewModifier(isPresented: config.isPresented, dismissTime: config.dismissTime, postion: config.postion, content: {
                MTPushNofi(text: config.text, style: config.style, didClickClose: config.didClickClose)
            })
        )
    }
    
    /// 适配底部Tabbar
    func mtAttatchTabbarSpacer() -> some View {
        VStack(spacing: 0) {
            self
            Spacer.mt.tabbar()
        }
    }
    
    /// 给View加阴影
    @ViewBuilder
    func mtShadow(type: MTShadow) -> some View {
        let config = type.config
        shadow(color: config.color, radius: config.radius, x: config.x, y: config.y)
    }
    
    /// 去了背景色的full screeen cover
    func mtFullScreenCover<Content>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Content) -> some View where Content : View {
        fullScreenCover(isPresented: isPresented, onDismiss: onDismiss) {
            ZStack {
                MTBackgroundCleanerView()
                content()
            }
        }
    }
    
    /// 去了背景色的full screeen cover
    func mtFullScreenCover<Item, Content>(item: Binding<Item?>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping (Item) -> Content) -> some View where Item : Identifiable, Content : View {
        fullScreenCover(item: item, onDismiss: onDismiss) { model in
            ZStack {
                MTBackgroundCleanerView()
                content(model)
            }
        }
    }
    
    /// 在scorllView上 子元素上使用 可以获取offsetY
    func onScrollViewOffsetChanged(action: @escaping (CGFloat) -> Void) -> some View {
        modifier(MTScrollViewOffsetViewModifier(action: action))
    }
    
}


//MARK: - Button和NavgiationLink用
public extension View {
    /// 在button or NavgiationLink外加 改样式 + 动画
    func mtButtonStyle(_ style: MTButtonStyle) -> some View {
        self
            .buttonStyle(MTButtonCustomStyle(style: style, customBackground: false))
            .disabled(!style.isEnable)
    }
    
    /// button or NavgiationLink里的Label 只改样式
    func mtButtonLabelStyle(_ style: MTButtonStyle, customBackground: Bool = true) -> some View {
        modifier(MTButtonStyleModifier(style: style, customBackground: customBackground))
    }
    
    /// button or NavgiationLink点击动画
    @ViewBuilder
    func mtTapAnimation(style: MTTapAnimationStyle = .rotation3D) -> some View {
        switch style {
        case .system: self
        case .normal: buttonStyle(MTButtonNormalStyle())
        case .rotation3D: buttonStyle(MTRotation3DButtonStyle())
        case let .overlayOrScale(isOverlay, scale):
            buttonStyle(MTButtonAnimationStyle(isOverlay: isOverlay, scale: scale))
        }
    }
}


//MARK: - 导航栏
public extension View {
    func mtNavbar<Content: View>(isShowNavbar: Bool = true, @ViewBuilder content: () -> Content) -> some View {
        modifier(MTNavbarViewModifier(content: content, leading: {
            EmptyView()
        }, trailing: {
            EmptyView()
        }, isShowNavbar: isShowNavbar))
    }
    
    func mtNavbar<Content: View, L: View>(isShowNavbar: Bool = true, @ViewBuilder content: () -> Content, @ViewBuilder leading: () -> L) -> some View {
        modifier(MTNavbarViewModifier(content: content, leading: {
            leading()
        }, trailing: {
            EmptyView()
        }, isShowNavbar: isShowNavbar))
    }

    func mtNavbar<Content: View, R: View>(isShowNavbar: Bool = true, @ViewBuilder content: () -> Content, @ViewBuilder trailing: () -> Content) -> some View {
        modifier(MTNavbarViewModifier(content: content, leading: {
            EmptyView()
        }, trailing: {
            trailing()
        }, isShowNavbar: isShowNavbar))
    }

    func mtNavbar<Content: View, L: View, R: View>(isShowNavbar: Bool = true, @ViewBuilder content: () -> Content, @ViewBuilder leading: () -> L, @ViewBuilder trailing: () -> R) -> some View {
        modifier(MTNavbarViewModifier(content: content, leading: {
            leading()
        }, trailing: {
            trailing()
        }, isShowNavbar: isShowNavbar))
    }
}
