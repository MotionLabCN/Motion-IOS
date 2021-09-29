//
//  StorageView.swift
//  Motion
//
//  Created by Liseami on 2021/9/29.
//

import SwiftUI
import MotionComponents

struct StorageView: View {
    var body: some View {
        VStack(spacing:16){
            
        
                HStack{
                    Text("盈利")
                        .font(.mt.largeTitle.mtBlod() ,textColor: .black)
                    Text("存储空间")
                        .font(.mt.largeTitle.mtBlod() ,textColor: .mt.gray_400)
                    Text("计算")
                        .font(.mt.largeTitle.mtBlod() ,textColor: .mt.gray_400)
                }
            
           
          
            
            Spacer()
            Capsule(style: .continuous)
                .fill(Color.random)
                .frame(width: ScreenWidth() * 0.6, height: ScreenWidth() * 0.6)
            
            VStack(spacing:12){
                Text("节点盈利")
                    .font(.mt.title2.mtBlod() ,textColor: .black)
                Text("基于去中心化的分布式存储协议，享受存储服务的同时，有机会为他人提供存储空间，以获取收益。")
                    .font(.mt.body2,textColor: .mt.gray_600)
                    .padding(.horizontal,56)
                
                Button("加入存储节点"){}
                .mtButtonStyle(.mainGradient)
                .padding(.horizontal,42)
                .padding(.vertical,16)
            }
            .padding(.vertical,44)
         
            
    
        }
        .navigationBarHidden(true)
        .padding()
        .frame(width: ScreenWidth())
        
    }
}

struct StorageView_Previews: PreviewProvider {
    static var previews: some View {
        StorageView()
    }
}
