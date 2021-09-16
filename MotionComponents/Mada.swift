//
//  Mada.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/9.
//
import SwiftUI
//MARK:马达震动反馈//////////////////////////////////////////
//马达震动.成功信号
func madaSuccess() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
}

//马达震动.警告信号
func madaWarning() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.warning)
}

//马达震动.错误信号
func madaError() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.error)
}
//马达震动反馈//////////////////////////////////////////

func madasoft() {
    let generator = UIImpactFeedbackGenerator(style: .soft)
    generator.impactOccurred()
}
//马达震动反馈//////////////////////////////////////////


//MARK:毛玻璃效果//////////////////////////////////////////
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = effect
    }
}


//MARK: 毛玻璃背景

struct EffectBackground_systemChromeMaterialLight: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        if colorScheme == .dark {
            return  VisualEffectView(effect: UIBlurEffect(style : .systemChromeMaterialDark))
        } else {
            return  VisualEffectView(effect: UIBlurEffect(style : .systemChromeMaterialLight))
        }
    }
}



//MARK: 毛玻璃背景Light
struct EffectBackground_Light: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        
        if colorScheme == .dark {
            return  VisualEffectView(effect: UIBlurEffect(style : .dark))
        } else  {
            return  VisualEffectView(effect: UIBlurEffect(style : .light))
        }
    }
    
}


