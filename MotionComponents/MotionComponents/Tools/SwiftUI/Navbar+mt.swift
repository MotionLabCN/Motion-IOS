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
        ZStack {
            content
            
            VStack {
                ZStack {
                    BlurView()
                        .ignoresSafeArea( edges: .top)
                        .frame(height: NavBarH)
                                           
                    //leading trailing
                    HStack(spacing: 0, content: {
                        leading
                        Spacer()
                        trailing
                    })
                    .frame(maxWidth: .infinity)
                    .frame(height: NavBarH)
                    .padding(.horizontal, 16)

                    // titleView
                    HStack(spacing: 0, content: {
                        mtContent
                    })
                    .frame(maxWidth: .infinity)
                    .frame(height: NavBarH)
                }
                
                Spacer(minLength: 0)
            }
            
        }
    }
}

public extension View {
    func mtNavbar<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        modifier(MTNavbarViewModifier(content: content, leading: {
            EmptyView()
        }, trailing: {
            EmptyView()
        }))
    }
    
    func mtNavbar<Content: View, L: View>(@ViewBuilder content: () -> Content, @ViewBuilder leading: () -> L) -> some View {
        modifier(MTNavbarViewModifier(content: content, leading: {
            leading()
        }, trailing: {
            EmptyView()
        }))
    }

    func mtNavbar<Content: View, R: View>(@ViewBuilder content: () -> Content, @ViewBuilder trailing: () -> Content) -> some View {
        modifier(MTNavbarViewModifier(content: content, leading: {
            EmptyView()
        }, trailing: {
            trailing()
        }))
    }

    func mtNavbar<Content: View, L: View, R: View>(@ViewBuilder content: () -> Content, @ViewBuilder leading: () -> L, @ViewBuilder trailing: () -> R) -> some View {
        modifier(MTNavbarViewModifier(content: content, leading: {
            leading()
        }, trailing: {
            trailing()
        }))
    }
}
