//
//  MTBarBackgorundView.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/10/8.
//

import SwiftUI

public struct MTBarBackgorundView: View {
    public init() { }
    
    public var body: some View {
        ZStack {
            Color.white.opacity(0.8)
                .ignoresSafeArea(edges: [.top, .bottom])
            
            BlurView(style: .light)
                .ignoresSafeArea(edges: [.top, .bottom])
        }
    }
}

struct MTBarBackgorundView_Previews: PreviewProvider {
    static var previews: some View {
        MTBarBackgorundView()
    }
}
