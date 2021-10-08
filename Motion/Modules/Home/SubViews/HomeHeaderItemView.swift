
//  HomeHeaderItemView.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/16.
//

import SwiftUI
import MotionComponents



struct HomeHeaderItemView: View {
    @State var isAnimation = false
    var body: some View {
        VStack(spacing: 3.0) {
            HStack(spacing: 4.0) {
                HStack(spacing: 0.0) {
                    Group {
                        MTAvatar(frame : 44) {}
                        .mtBoderCircle()
                        MTAvatar(frame : 44) {}
                        .mtBoderCircle()
                        .padding(.leading, -20)
                    }
                    .padding(.all, 2)
                }
                Text("+99")
                    .font(.mt.body2.mtBlod(), textColor: .white)
                    .padding(.trailing, 16)
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "860CF2"), Color(hex: "887AFF")]), startPoint: .bottom, endPoint: .topTrailing)
                            .clipShape(Capsule(style: .continuous)))
            .overlay(
                Image.mt.load(.Logo)
                    .resizable()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.white)
                    .frame(width: 18, height: 18)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color(hex: "860CF2"), Color(hex: "887AFF")]), startPoint: .bottom, endPoint: .topTrailing)
                            .clipShape(Capsule(style: .continuous))
                            .mtBoderCircle(lineWidth: 2)
                    )
                    .offset(x: -2, y: -1.0)
                , alignment: .bottomTrailing)
            .padding(.all, 2)
            .background(
                ZStack {
                    Color.mt.accent_purple.opacity(0.3)
                        .clipShape(Capsule(style: .continuous))
                    
                    Color.mt.accent_purple.opacity(0.3)
                        .clipShape(Capsule(style: .continuous))
                        .scaleEffect(isAnimation ? 1.2: 1)
                        .opacity(isAnimation ? 0 : 1)
                        .animation(.easeInOut(duration: 1.6).repeatForever(autoreverses: false))
                    
                }
            )
            .padding(.all, 2)
            .background(
                ZStack {
                    Color.mt.accent_purple.opacity(0.1)
                        .clipShape(Capsule(style: .continuous))
                    
                    Color.mt.accent_purple.opacity(0.1)
                        .clipShape(Capsule(style: .continuous))
                        .scaleEffect(isAnimation ? 1.3: 1)
                        .opacity(isAnimation ? 0 : 1)
                        .animation(.easeInOut(duration: 2.4).repeatForever(autoreverses: false))
                    
                }
                
            )
            
            Text("天天数链研发小队")
                .font(.mt.caption1, textColor: .mt.gray_800)
        }
        .onAppear {
            isAnimation = true
        }
        
    }
}


struct HomeHeaderItemView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderItemView()
            .previewLayout(.sizeThatFits)
    }
}
