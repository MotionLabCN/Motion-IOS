//
//  MTSheet.swift
//  MotionDesgin
//
//  Created by 梁泽 on 2021/9/23.
//

import SwiftUI


struct MTSheetView<MTContent: View>: View  {
    @Binding var isPresented: Bool
    @ViewBuilder let content: MTContent
    

    var body: some View {
        Rectangle()
            .fill(Color.clear)
            .modifier(
                MTSheetViewModifier(isPresented: $isPresented, mtContent: {
                    content
                })
            )
    }
    
}






