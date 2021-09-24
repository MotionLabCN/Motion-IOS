//
//  OfficialBusiness.swift
//  Motion
//
//  Created by Liseami on 2021/9/23.
//

import SwiftUI
import MotionComponents

let businessTabbarStr = ["计算/存储","技术/方案","技能/人员"]
struct OfficialBusiness: View {
    @State var tabindex : String = "计算/存储"
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: true, content: {
            
            VStack(alignment: .center, spacing: 24){
                
                chainDisk
                
                tMarket
                
                interview
        
            }
            .padding(.vertical,24)
            .padding(.bottom,100)
        })
         
    }
    
    var interview : some View {
        
        VStack(alignment: .center, spacing: 32){
           
                HStack {
                    Text("技术面试服务开创者")
                        .font(.mt.title3.mtBlod(),textColor: .black)
                    Text("/ 大牛帮面")
                        .font(.mt.caption2,textColor: .black)
                    Spacer()
                    VStack{
                        Image.mt.load(.Chevron_right_On)
                            .foregroundColor(.mt.gray_400)
                    }
                }
             

            HStack {
                VStack(alignment: .leading){
                    Text("223,249")
                        .font(.mt.title3.mtBlod(),textColor: .mt.gray_900)
                    Text("累计帮面超过")
                        .font(.mt.body3,textColor: .mt.gray_600)
                }
                Spacer()
                Text("找人帮面")
                    .font(.mt.body1.mtBlod(),textColor: .white)
                    .padding(.init(horizontal: 16, vertical: 8))
                    .background(Color.mt.gray_900)
                    .clipShape(Capsule(style: .continuous))
            }
            
            

            ForEach(0 ..< 50) { item in
                interviewListCell()
            }
                
        }
        .mtCardStyle(insets: EdgeInsets(horizontal: 16, vertical: 16))
        .padding(.horizontal,24)
    }

    var tMarket : some View {
        VStack(alignment: .center, spacing: 16){
           
            
                HStack {
                    Text("技术方案市场")
                        .font(.mt.title3.mtBlod(),textColor: .black)
                    Text("/ 企业级方案 人工审核")
                        .font(.mt.caption2,textColor: .black)
                    Spacer()
                        Image.mt.load(.Chevron_right_On)
                            .foregroundColor(.mt.gray_400)
                }
            
            HStack(spacing:0){
                Spacer()
                VStack {
                    Rectangle()
                          .frame(width: 60, height: 60)
                          .foregroundColor(.random)
                      .clipShape(Capsule(style: .continuous))
                    Text("计算机视觉")
                        .font(.mt.caption1,textColor: .black)
                }
                Spacer()
                VStack {
                    Rectangle()
                          .frame(width: 60, height: 60)
                          .foregroundColor(.random)
                      .clipShape(Capsule(style: .continuous))
                    Text("人工智能")
                        .font(.mt.caption1,textColor: .black)
                }
                Spacer()
                VStack {
                    Rectangle()
                          .frame(width: 60, height: 60)
                          .foregroundColor(.random)
                      .clipShape(Capsule(style: .continuous))
                    Text("数据湖")
                        .font(.mt.caption1,textColor: .black)
                }
                Spacer()
                VStack {
                    Rectangle()
                          .frame(width: 60, height: 60)
                          .foregroundColor(.random)
                      .clipShape(Capsule(style: .continuous))
                    Text("推荐算法")
                        .font(.mt.caption1,textColor: .black)
                }
                Spacer()
            }
        }
        .mtCardStyle(insets: EdgeInsets(horizontal: 16, vertical: 16))
        .padding(.horizontal,24)
    }
    
//    var chainState : some View {
//        VStack(alignment: .center, spacing: 32){
//
//            VStack(alignment: .center, spacing: 12){
//                HStack{
//                    Text("网络节点")
//                        .font(.mt.body2.mtBlod(),textColor: .mt.gray_800)
//                    Spacer()
//                    Text("40,5002.00")
//                        .font(.mt.body2.mtBlod(),textColor: .mt.gray_800)
//                }
//                HStack{
//                    Text("当前容量")
//                        .font(.mt.body2.mtBlod(),textColor: .mt.gray_800)
//                    Spacer()
//                    Text("95,260.00TB")
//                        .font(.mt.body2.mtBlod(),textColor: .mt.gray_800)
//                }
//            }
//
//            HStack{
//                Text("加入节点盈利")
//                    .font(.mt.body1.mtBlod(),textColor: .mt.accent_purple)
//                Spacer()
//            }
////                HStack{
////                    Spacer()
////                    Button {
////
////                    } label: {
////                        Text("加入节点")
////                            .font(.mt.title3.mtBlod(),textColor: .white)
////                    }
////                    .mtButtonStyle(.smallDefult(isEnable: true))
////
////                }
//        }
//        .mtCardStyle(insets: EdgeInsets(horizontal: 16, vertical: 24))
//        .padding(.horizontal,24)
//    }
    
    var chainDisk : some View {
        VStack(alignment: .center, spacing: 16){
           
            VStack(alignment: .leading, spacing: 12){
                HStack {
                    Text("区块链存储")
                        .font(.mt.title3.mtBlod(),textColor: .black)
                    
                    Text("/ 加密安全 极简可靠")
                        .font(.mt.caption2,textColor: .black)
                    Spacer()
                    VStack{
                        Image.mt.load(.Chevron_right_On)
                            .foregroundColor(.mt.gray_400)
                    }
                }
                Text("借助区块链技术，实现隐私、安全、速度的三大保障。由此革新互联网世界中的存储服务。")
                    .font(.mt.body2,textColor: .mt.gray_500)
            }
            HStack {
                Text("上传文件")
                    .font(.mt.body1.mtBlod(),textColor: .white)
                    .padding(.init(horizontal: 16, vertical: 8))
                    .background(Color.mt.accent_purple)
                    .clipShape(Capsule(style: .continuous))
                Text("提供节点")
                    .font(.mt.body1.mtBlod(),textColor: .mt.accent_purple)
                    .padding(.init(horizontal: 16, vertical: 8))
                    
                Spacer()
            }
        }
        .mtCardStyle(insets: EdgeInsets(horizontal: 16, vertical: 16))
        .padding(.horizontal,24)
    }
}

struct OfficialBusiness_Previews: PreviewProvider {
    static var previews: some View {
        OfficialBusiness()
    }
}



struct interviewListCell: View {
    var body: some View {
        HStack(alignment:.top){
            Rectangle()
                .foregroundColor(Color.random)
                .frame(width: 52, height: 52)
                .clipShape(Capsule(style: .continuous))
            HStack{
                VStack(alignment: .leading, spacing:4){
                    HStack(spacing:4){
                        Text("刘江博")
                            .font(.mt.body1.mtBlod(),textColor: .black)
                        Text("V")
                            .font(.mt.body2.mtBlod(),textColor:.mt.accent_purple)
                        Spacer()
                    }
                    Text("起点学院资深JAVA架构师")
                        .font(.mt.body2,textColor:.mt.gray_600)
                }
                Text("预约")
                    .font(.mt.body2,textColor:.mt.accent_purple)
            }
        }
    }
}
