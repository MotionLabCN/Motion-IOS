//
//  Navbar+mt.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/16.
//

import SwiftUI


struct MTNavbarViewModifier<MTContent: View, L: View, R: View>: ViewModifier {
    @ViewBuilder let content: MTContent
    @ViewBuilder let leading: L
    @ViewBuilder let trailing: R
    
    let isShowNavbar: Bool

    
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .safeAreaInset(edge: .top, spacing: 0) {
                   navbar
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
        } else {
            VStack(spacing: 0) {
                navbar
                
                Spacer(minLength: 0)
                content
                Spacer(minLength: 0)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
            
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
    
    var navbar: some View {
        ZStack {
            if isShowNavbar {
                Group {
                    //leading trailing
                    HStack(spacing: 0, content: {
                        leading
                        Spacer()
                        trailing
                    })
                        .padding(.horizontal, 16)
                    
                    // titleView
                    HStack(spacing: 0, content: {
                        self.content
                    })
                }
                .frame(height: 44)
            }
        }
        .frame(minHeight: 0.1)
        .frame(maxWidth: .infinity)
        .background(
            MTBarBackgorundView()
        )
    }
}
