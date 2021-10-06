//
//  MTScrollViewOffsetViewModifier.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/10/6.
//

import Foundation
import SwiftUI

struct ScrollViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct MTScrollViewOffsetViewModifier: ViewModifier {
    var action: ((CGFloat) -> Void)?
    
    @State private var startOffsetY: CGFloat = 0
    @State private var offsetY: CGFloat = 0
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader{ reader -> AnyView in
                    DispatchQueue.main.async {
                        if startOffsetY == 0 {
                            startOffsetY = reader.frame(in: .global).minY
                        }
                        offsetY = reader.frame(in: .global).minY - startOffsetY
                    }
                    
                    
                    return AnyView(
                        Text("")
                            .preference(key: ScrollViewOffsetKey.self, value: offsetY)
                    )
                }
            )
            .onPreferenceChange(ScrollViewOffsetKey.self) { value in
                action?(value)
            }
    }
    

}

