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
                StoragePage().tag(0)
                JoinPeerView().tag(1)
                Text("天天数链/计算模块/IOS").tag(2)
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



