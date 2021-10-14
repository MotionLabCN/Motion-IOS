//
//  MTLogoView.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/27.
//

import SwiftUI
import MotionComponents

struct MTLogoView: View {
    let size: CGFloat
    let color: Color
    
    init(size: CGFloat = 44, color: Color = .mt.accent_purple) {
        self.size = size
        self.color = color
    }
    
    var body: some View {
        Image.mt.load(.Logo)
            .resizable()
            .foregroundColor(color)
            .mtFrame(square: size)
    }
}

extension View {
    func mtNavBarLogo() -> some View {
        toolbar {
            ToolbarItem(placement: .principal) {
                MTLogoView()
            }
        }
    }
}


struct MTLogoView_Previews: PreviewProvider {
    static var previews: some View {
        MTLogoView()
            .previewLayout(.fixed(width: ScreenWidth(), height: 44))
    }
}
