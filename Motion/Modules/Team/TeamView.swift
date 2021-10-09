//
//  TeamView.swift
//  TeamView
//
//  Created by Liseami on 2021/9/15.
//

import SwiftUI
import MotionComponents

struct ERji: View {
    var body: some View {
        ScrollView {
            ForEach(0..<10) { _ in
                Rectangle()
                    .frame( height: 100)
                    .foregroundColor(.random)
                    
            }
        }
        .onDisappear {
            withAnimation(.easeInOut(duration: 0.15)) {
                TabbarState.shared.isShowTabbar = true
            }
        }
    }
}
struct TeamView: View {
    
    @State var show : Bool = false
    
    @State var isTest = false
    var body: some View {
        //卡片宽度
        let cardWidth = (ScreenWidth() - 32 - 8 ) / 2
        //排序方式
        let columns =
        Array(repeating:  GridItem(.fixed(cardWidth)), count: 2)
        
        ScrollView(.vertical , showsIndicators:true) {
//            Spacer().frame(height:44)
            // scrollview start
            Button("clickme") {
                print("clickMe")
                TabbarState.shared.isShowTabbar = false
                isTest.toggle()
            }
            .frame(width: 100, height: 100)
            .background(Color.red)
            .mtRegisterRouter(isActive: $isTest, destination: {
                ERji()
            })
            
            LazyVGrid(
                columns:columns,
                alignment: .center,
                spacing: 8,
                pinnedViews: .sectionFooters){
                    
                    //我的小组
                    Section(header:
                                HStack {Text("我的小组")
                            .font(.mt.title3.mtBlod())
                        Spacer()}.padding(.init(horizontal: 16, vertical: 8))
                            
                    ){
                        ForEach(0 ..< 3) { item in
                            TeamCard(width: cardWidth)}
                    }
                    //活跃小组
                    Section(header:
                                HStack {
                        Text("活跃小组")
                            .font(.mt.title3.mtBlod())
                        Spacer()
                        Text("隐藏")
                            .font(.mt.body1)
                            .foregroundColor(.mt.accent_700)
                    }.padding(.init(horizontal: 16, vertical: 8))
                            
                    ){
                        ForEach(0 ..< 100) { item in
                            TeamCard(width: cardWidth)
                        }
                    }
                }
            
            Spacer.mt.tabbar()
        }// scrollview end
        .mtNavbar(content: {
            Text("小组")
                .font(.mt.body1.mtBlod(),textColor: .black)
        }, leading: {
            MTLocUserAvatar()
        }, trailing: {
            SettingBtn()
        })
        .fullScreenCover(isPresented: $show) {
            SettingView()
        }
        
        
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            TeamView()
        }
    }
}

struct TeamCard: View {
    let width : CGFloat
    var body: some View {
        NavigationLink(destination: TeamProfileView()) {
            VStack(alignment:.leading, spacing:20){
                HStack(alignment:.top,spacing: 32){
                    Rectangle()
                        .foregroundColor(.mt.gray_300)
                        .frame(width: 88, height: 40)
                        .clipShape(Capsule())
                    Image.mt.load(.More_horiz)
                        .foregroundColor(Color.mt.gray_400)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("天天数链武汉研发中心")
                        .font(.mt.body2.mtBlod(),textColor: .black)
                        .lineLimit(1)
                    Text("相册新增相片13张")
                        .font(.mt.caption2,textColor: .mt.gray_600)
                        .lineLimit(1)
                    
                }
            }
            .padding(.all,12)
            .frame(width: width)
            .background(Color.mt.gray_100)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}
