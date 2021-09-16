//
//  TeamProfileVIew.swift
//  TeamProfileVIew
//
//  Created by Liseami on 2021/9/16.
//

import SwiftUI
import MotionComponents

struct TeamProfileView: View {
    var body: some View {
        
        let cell =  ScreenWidth() / 375
        let w = cell * 120
        let h = cell * 54
        
        VStack(alignment:.leading,spacing:24){
            //头像，队员，市值，粉丝
            HStack(spacing:0){
                Rectangle()
                    .frame(width: w, height: h)
                    .foregroundColor(.mt.gray_300)
                    .clipShape(Capsule())
                HStack(alignment: .center, spacing: 18 * cell) {
                    Spacer()
                    VStack{
                        Text("403")
                            .font(.mt.body2.mtBlod())
                        Text("队员")
                            .font(.mt.body3)
                    }
                    VStack{
                        Text("2.3亿")
                            .font(.mt.body2.mtBlod())
                        Text("市值")
                            .font(.mt.body3)
                    }
                    VStack{
                        Text("39K")
                            .font(.mt.body2.mtBlod())
                        Text("粉丝")
                            .font(.mt.body3)
                    }
                    Spacer()
                }
                .padding(.top,8)
                .padding(.horizontal,20)
            }
            //名称，市值，简介，连接
            VStack(alignment:.leading,spacing:cell * 6){
                Text("天天数链武汉研发中心")
                    .font(.mt.body1.mtBlod())
                Text("293,232.00 TTC")
                    .font(.mt.body1.mtBlod())
                    .foregroundColor(.mt.accent_purple)
                VStack(alignment:.leading,spacing:4){
                    Text("来自 Apple Music & Feedback 的原生警报。包含 Done、Heart & Message 和其他预设。支持 SwiftUI。")
                        .font(.mt.body3)
                    HStack{
                        Image.mt.load(.Link).frame(width: 16, height: 16)
                        Text("www.motion.com")
                            .font(.mt.body3)
                        Spacer()
                    }.foregroundColor(.mt.gray_400)
                }
            }
            HStack(spacing:8){
                Spacer()
                Button {} label: {Text("关注")}
                Button {} label: {Text("申请加入")}
                Button {} label: {Text("充能")}
                .buttonStyle(MTButtonStyle(style:.smallDefult(isEnable: true)))
                Spacer()
            }
            .buttonStyle( MTButtonStyle(style: .smallStorker(isEnable: true)))
            
            Spacer()
        }
        .padding(.all,cell * 16)
     
        
      
    }
}

struct TeamProfileView_Previews: PreviewProvider {
    static var previews: some View {
        TeamProfileView()
    }
}
