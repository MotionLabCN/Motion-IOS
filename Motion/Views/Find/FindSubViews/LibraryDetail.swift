//
//  LibraryDetail.swift
//  Motion
//
//  Created by Liseami on 2021/9/23.
//

import SwiftUI
import MotionComponents

struct LibraryDetail: View {
    var body: some View {
        VStack(spacing:16){
            HStack{
                Rectangle()
                    .frame(width: ScreenWidth() / 4, height: ScreenWidth() / 4)
                    .clipShape(Capsule(style: .continuous))
                VStack(alignment: .leading, spacing: 6){
                    Text("OpenStack Swift")
                        .font(.mt.body1.mtBlod(),textColor: .mt.gray_900)
                    Text("分布式对象存储系统")
                        .font(.mt.caption1.mtBlod(),textColor: .mt.gray_600)
                    HStack{
                        Circle().frame(width: 12, height: 12)
                        Circle().frame(width: 12, height: 12)
                        Circle().frame(width: 12, height: 12)
                        Circle().frame(width: 12, height: 12)
                        Circle().frame(width: 12, height: 12)
                        Text("29492个评分")
                            .font(.mt.body2,textColor: .mt.gray_600)
                    }
                    .foregroundColor(.mt.gray_600)
                    
                }
                Spacer()
            }
            HStack{
                Image.mt.load(.Map_place)
                Text("OpenStack Swift 是一个分布式对象存储系统，旨在从单台机器扩展到数千台服务器。Swift 针对多租户和高并发进行了优化。Swift 是备份、Web 和移动内容以及任何其他可以无限增长的非结构化数据的理想选择。")
                    .font(.mt.body2.mtBlod(),textColor: .mt.gray_900)
                    .lineLimit(2)
            }
            HStack{
                HStack{
                    Image.mt.load(.Banknote)
                    Text("2300")
                        .font(.mt.body2.mtBlod(),textColor: .mt.accent_700)
                        .lineLimit(1)
                }
                HStack{
                    Image.mt.load(.Github)
                    Text("https://github.com/openstack/swift")
                        .font(.mt.body2.mtBlod(),textColor: .mt.accent_700)
                        .lineLimit(1)
                }
            }
            
            HStack{
                Button {
                } label: {
                    Image.mt.load(.Link)
                }
                .mtCustom(.mainDefult(isEnable: false))
                
                Button {
                } label: {
                    Image.mt.load(.Github)
                }
                .mtCustom(.mainDefult(isEnable: false))

                
                Button {
                } label: {
                    HStack(spacing:0){
                        Text("用过/准备用")
                        Image.mt.load(.Arrow_right)
                    }
                }
                .mtCustom(.mainDefult())
                .frame(width: ScreenWidth() / 2)
            }
            
            Spacer()
            
            
        }.padding()
        
    }
}

struct LibraryDetail_Previews: PreviewProvider {
    static var previews: some View {
        LibraryDetail()
    }
}
