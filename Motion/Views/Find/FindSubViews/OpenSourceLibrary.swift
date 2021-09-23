//
//  OpenSourceLibrary.swift
//  Motion
//
//  Created by Liseami on 2021/9/23.
//

import SwiftUI
import MotionComponents

struct OpenSourceLibrary: View {
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing:16){
                classic
                newStar
            }.padding(.top,16)
        }
    }
    
    
    var newStar : some View {
        Section {
            ForEach(0 ..< 50) { item in
                LibraryListCell()
                    .padding(.horizontal)
                Divider()
            }
        } header: {
            Text("新星")
                .font(.mt.title2.mtBlod(),textColor: .black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
    }
    
    var classic : some View{
        Section {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing:16){
                    ForEach(0 ..< 5) { item in
                        VStack(alignment: .leading,spacing:4){
                            Rectangle().frame(width: ScreenWidth() / 3, height: ScreenWidth() / 3 * 1.4)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .foregroundColor(.random)
                            Text("SpringBoot")
                                .font(.mt.body2.bold(),textColor: .black)
                            Text("8.9")
                                .font(.mt.body2.bold(),textColor: .mt.accent_800)
                        }
                        
                    }
                }.padding(.horizontal)
            }
        } header: {
            HStack {
                Text("热门")
                    .font(.mt.title2.mtBlod(),textColor: .black)
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct OpenSourceLibrary_Previews: PreviewProvider {
    static var previews: some View {
        OpenSourceLibrary()
    }
}

struct LibraryListCell: View {
    var body: some View {
        
        HStack{
            Rectangle()
                .frame(width: ScreenWidth() / 6, height: ScreenWidth() / 6)
                .clipShape(Capsule(style: .continuous))
                .foregroundColor(.random)
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
    }
}
