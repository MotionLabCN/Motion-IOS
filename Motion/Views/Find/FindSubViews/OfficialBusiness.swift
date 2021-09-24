//
//  OfficialBusiness.swift
//  Motion
//
//  Created by Liseami on 2021/9/23.
//

import SwiftUI
import MotionComponents

struct OfficialBusiness: View {
    var body: some View {
        
        VStack{
            VStack(alignment: .center, spacing: 48){
                
Image(systemName: "cable.connector.horizontal")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.mt.accent_purple)
                
                    Text("区块链网盘")
                        .font(.mt.title1.mtBlod(),textColor: .black)
                Text("借助区块链技术，实现隐私、安全、速度的三大保障。由此革新互联网世界中的存储服务。")
                    .font(.mt.body2.mtBlod(),textColor: .mt.gray_500)
                
                Spacer().frame(width: 0, height: 45)
                    Text("上传重要文件")
                    .font(.mt.title3.mtBlod(),textColor: .mt.accent_purple)


            
                
              
            }
            .padding(.init(horizontal: 48, vertical: 16))
            .background(Color.white)
            .clipShape(RoundedRectangle.init(cornerSize: CGSize(width: 18, height: 24), style: .continuous))
            .shadow(type: MTShadow.shadowLow)

            VStack(alignment: .leading, spacing: 4){
                HStack{
                    Text("技术方案交易")
                        .font(.mt.title1.mtBlod(),textColor: .black)
                    Spacer()
                    Image.mt.load(.Chevron_right_On)
                        .foregroundColor(.mt.gray_400)
                }
                .padding(.bottom,120)
              
                
            }
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle.init(cornerSize: CGSize(width: 18, height: 24), style: .continuous))
            .shadow(type: MTShadow.shadowLow)
            
            VStack(alignment: .leading, spacing: 4){
                HStack{
                    Text("代面试服务")
                        .font(.mt.title1.mtBlod(),textColor: .black)    .frame(maxWidth : .infinity,alignment: .leading)
                    Spacer()
                    Image.mt.load(.Chevron_right_On)
                        .foregroundColor(.mt.gray_400)
                }
                .padding(.bottom,120)
            
            }
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle.init(cornerSize: CGSize(width: 18, height: 24), style: .continuous))
            .shadow(type: MTShadow.shadowLow)
        }
        
        .padding()
        
       
        
    }
}

struct OfficialBusiness_Previews: PreviewProvider {
    static var previews: some View {
        OfficialBusiness()
    }
}
