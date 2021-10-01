//
//  Navbar+mt.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/16.
//

import SwiftUI


public struct MTNavbarViewModifier<MTContent: View, L: View, R: View>: ViewModifier {
    let mtContent: MTContent
    var leading: L
    var trailing: R
    
    public init(@ViewBuilder content: () -> MTContent, @ViewBuilder leading: () -> L, @ViewBuilder trailing: () -> R) {
        self.mtContent = content()
        self.leading = leading()
        self.trailing = trailing()
    }
    
    public func body(content: Content) -> some View {
        VStack(spacing: 0) {
            ZStack {
                Color.random
                    .ignoresSafeArea( edges: .top)
                
                //leading trailing
                HStack(spacing: 0, content: {
                    leading
                    Spacer()
                    trailing
                })
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)

                // titleView
                HStack(spacing: 0, content: {
                    mtContent
                })
            }
            .frame(maxWidth: .infinity)
            .frame(height: NavBarH)
            
            content
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)

        
        
//        ZStack {
//            content
//
//            VStack {
//                ZStack {
//                    Color.white
//                        .ignoresSafeArea( edges: .top)
//                        .frame(height: NavBarH)
//                    //leading trailing
//                    HStack(spacing: 0, content: {
//                        leading
//                        Spacer()
//                        trailing
//                    })
//                    .frame(maxWidth: .infinity)
//                    .frame(height: NavBarH)
//                    .padding(.horizontal, 16)
//
//                    // titleView
//                    HStack(spacing: 0, content: {
//                        mtContent
//                    })
//                    .frame(maxWidth: .infinity)
//                    .frame(height: NavBarH)
//                }
//
//                Spacer(minLength: 0)
//            }
//
//        }
    }
}
