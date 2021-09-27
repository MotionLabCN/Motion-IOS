//
//  HapticManager.swift
//  MotionDesgin
//
//  Created by 梁泽 on 2021/9/14.
//

import SwiftUI


//MARK: - 管理类
public class HapticManager {
    public static let shared = HapticManager()
    
    public func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    public func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

//MARK: - 示例
struct HapticsBootcamp: View {
    var body: some View {
        VStack(spacing: 20.0) {
            Button("error") {
                HapticManager.shared.notification(type: .error)
            }
            Button("success") {
                HapticManager.shared.notification(type: .success)
            }
            Button("warning") {
                HapticManager.shared.notification(type: .warning)
            }
            
            Divider()
            
            Button("warning") {
                HapticManager.shared.impact(style: .heavy)
            }
            Button("light") {
                HapticManager.shared.impact(style: .light)
            }
            Button("medium") {
                HapticManager.shared.impact(style: .medium)
            }
            Button("rigid") {
                HapticManager.shared.impact(style: .rigid)
            }
            Button("soft") {
                HapticManager.shared.impact(style: .soft)
            }
        }
    }
}

struct HapticsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HapticsBootcamp()
    }
}
