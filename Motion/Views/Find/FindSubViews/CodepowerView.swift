//
//  CodepowerView.swift
//  Motion
//
//  Created by Liseami on 2021/9/29.
//

import SwiftUI
import MotionComponents

struct CodepowerView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing:12){
                
                Spacer().frame(width: 0, height: 44)
                
                title
                
                Spacer().frame(width: 0, height: 36)
                
                scrollAnimation
              
                Spacer().frame(width: 0, height: 36)
                
                Button("上架技术方案"){}
                .mtButtonStyle(.mainGradient)
                .padding(.horizontal,80)
                
                Spacer().frame(width: 0, height: 12)
                
                
                shopTitle
                
                //卡片宽度
                let cardWidth = (ScreenWidth() - 32 - 8 ) / 2
                //排序方式
                let columns =
                Array(repeating:  GridItem(.fixed(cardWidth)), count: 2)
                LazyVGrid(
                    columns:columns,
                    alignment: .center,
                    spacing: 8,
                    pinnedViews: .sectionFooters){
                        
                        
                        ForEach(0 ..< 50) { item in
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .frame(width:cardWidth, height: 240)
                                .foregroundColor(.random)
                        }
                        
                    }
             
              
               
                    
                    
                
             
                
            }
        }
      
        .frame(width: ScreenWidth())
    
    }
    
    var title : some View {
        VStack(spacing:6){
            Text("技术方案在这里流通与落地")
                .font(.mt.largeTitle.mtBlod() ,textColor: .black)
                .multilineTextAlignment(.center)
                .padding(.horizontal,70)
            
            Text("基于去中心化的分布式存储协议，享受存储服务的同时。")
                .font(.mt.body2,textColor: .mt.gray_500)
                .lineSpacing(6)
                .padding(.horizontal,56)
        }
    }
    
    var scrollAnimation : some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack{
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .frame(width: 100, height: 140)
                    
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .frame(width: 100, height: 140)
                    
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .frame(width: 100, height: 140)
                    
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .frame(width: 100, height: 140)
                    
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .frame(width: 100, height: 140)
            }
        }
    }
    
    var shopTitle : some View {
        VStack(spacing:24){
            HStack{
                Text("码力超市")
                    .font(.mt.title1.mtBlod() ,textColor: .black)
                Spacer()
                Button("排序方式"){}
                .mtButtonStyle(.smallDefult(isEnable: false))
                   
            }
            HStack(spacing:48){
                VStack{
                    Text("32")
                        .font(.mt.title1.mtBlod() ,textColor: .black)
                    Text("在售")
                        .font(.mt.body2 ,textColor: .black)
                }
                
                VStack{
                    Text("294")
                        .font(.mt.title1.mtBlod() ,textColor: .black)
                    Text("顾问")
                        .font(.mt.body2 ,textColor: .black)
                }
                VStack{
                    Text("90")
                        .font(.mt.title1.mtBlod() ,textColor: .black)
                    Text("案例")
                        .font(.mt.body2 ,textColor: .black)
                }
            }
          
           
        }
        .mtCardStyle()
        .padding()
    }
}

struct CodepowerView_Previews: PreviewProvider {
    static var previews: some View {
        CodepowerView()
    }
}
