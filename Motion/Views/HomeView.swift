//
//  HomeView.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/15.
//

import SwiftUI
import MotionComponents

struct HomeView: View {

    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Color.random
            }
            .ignoresSafeArea( edges: .top)
            .frame(height: 44)
//                .frame(height: 44)
                

            
            Text("Placeholder")
                .frame(height: 86)

            Divider.mt.defult()

            main
            
//            List(0..<50) { index in
//                Text("index: \(index)")
//            }
        }
        .mtAttatchTabbarSpacer()
    }
    
}

extension HomeView {
    var main: some View {
        VStack {
            
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
//        .background(Color.random)
        .overlay(
            mainPlaceholder
        )
    }
    
    var mainPlaceholder: some View {
        VStack(spacing: 20) {
            MTDescriptionView(title: "尚未连接任何人", subTitle: "Motion是创造者们加速他们伟大创造的地方。科技、艺术、制造业工作者们在这里见面，组成协作小队。")
            
            Button(action: {
                
            }, label: {
                Text("查找朋友")
                    .modifier(MTButtonStyleModifier(style: .mainDefult(isEnable: true), customBackground: true))
                    .frame(width: 125)
                    .background(
                        Color.mt.accent_700.clipShape(Capsule())
                    )
            })
           
            .mtAnimation()
        }
    }
    
}





struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
