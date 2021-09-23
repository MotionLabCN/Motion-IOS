//
//  OpenSourceLibrary.swift
//  Motion
//
//  Created by Liseami on 2021/9/23.
//

import SwiftUI
import MotionComponents

struct OpenSourceLibrary: View {
    @State var showMoney : Bool = false
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing:16){
                
                if showMoney {
                    MoneyNotiView()
                }
                
                classic
                
                newStar
                
            }.padding(.top,16)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                withAnimation {
                    self.showMoney = true
                }
            }
        }
        .onDisappear {
            self.showMoney = false
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
                Text("Swift")
                    .font(.mt.title3.mtBlod(),textColor: .red)
                Image.mt.load(.Filter_list)
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

struct MoneyNotiView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 16){
            Text("💸")
                .padding()
                .background(Color.mt.gray_100)
                .clipShape(Capsule(style: .continuous))
            VStack(alignment: .leading,spacing:8){
                Text("尝试盈利！")
                    .font(.mt.body1.mtBlod(),textColor: .black)
                Text("你在Motion中的盈利的三种方式，现已开放测试。")
                    .font(.mt.body2,textColor: .mt.gray_600)
                    .lineSpacing(8)
            }
            Spacer()
            VStack{
                Image.mt.load(.Chevron_right_On)
                    .foregroundColor(.mt.gray_400)
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(type: MTShadow.shadowMid)
        .padding()
        .transition(.move(edge: .top).animation(.spring()))
    }
}
