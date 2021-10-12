//
//  StorageView.swift
//  Motion
//
//  Created by Liseami on 2021/9/29.
//

import SwiftUI
import MotionComponents

struct StorageView: View {
    @State var pageIndex : Int = 0
    let tabTitle = ["超科技前沿的存储方式","加入节点以获取收益","体验和参与分布式计算"]
    let tabtext = ["存储","参与节点","计算"]
    var body: some View {
        ZStack{
         
            TabView(selection: $pageIndex){
                DiskPage().tag(0)
                JoinPeerView().tag(1)
                Text("page3").tag(2)
            }.tabViewStyle(.page(indexDisplayMode: .never))
            
            header
            
        }
        .padding(.top,24)
        .navigationBarHidden(true)
    }
    var header : some View {
        VStack{
            HStack(alignment: .top, spacing: 12){
                    ForEach(0..<tabtext.count ) { index in
                        VStack(spacing:8){
                            Text(tabtext[index])
                                .font(.mt.body1.mtBlod() ,textColor: index == pageIndex ? .black : .mt.gray_400)
                            Text(tabTitle[index])
                                .font(.mt.body3,textColor: index == pageIndex ? .mt.gray_800 : .mt.gray_400)
                                .multilineTextAlignment(.center)
                                .frame(width: ScreenWidth() * 0.18)
                        }
                        .frame(width: ScreenWidth() * 0.24)
                        .onTapGesture {pageIndex = index}
                    }
                }
                .frame(height: ScreenWidth() * 0.2)
                .mtCardStyle()
            Spacer()
        }
      
    }
}

struct StorageView_Previews: PreviewProvider {
    static var previews: some View {
        StorageView()
    }
}

struct JoinPeerView: View {
    var body: some View {
        VStack{
            Spacer()   .frame(height: ScreenWidth() * 0.3)
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
    }
}

