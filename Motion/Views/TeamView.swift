//
//  TeamView.swift
//  TeamView
//
//  Created by Liseami on 2021/9/15.
//

import SwiftUI
import MotionComponents


struct TeamView: View {
    
    @State var show : Bool = false
    var body: some View {
        GeometryReader { pox in
            //卡片宽度
            let cardWidth = (pox.width - 32 - 8 ) / 2
            //排序方式
            let columns =
            Array(repeating:  GridItem(.fixed(cardWidth)), count: 2)
            
            ScrollView(.vertical , showsIndicators:true) {
                LazyVStack{
                    Spacer().frame( height: 16)
                    //我的小组
                    Section(header:
                                HStack {
                        Text("我的小组")
                            .font(.mt.title3.mtBlod())
                            .padding(.leading,16)
                        Spacer()
                    }.padding(.vertical,8)
                    ) {
                        LazyVGrid(
                            columns:columns,
                            alignment: .center,
                            spacing: 8,
                            pinnedViews: .sectionFooters)
                        {
                            ForEach(0 ..< 3) { item in
                                TeamCard(width: cardWidth)
                            }
                        }}
                    
                    
                    //活跃小组
                    Section(header:
                                HStack(alignment:.center) {
                        Text("活跃小组")
                            .font(.mt.title3.mtBlod())
                        Spacer()
                        Text("隐藏")
                            .font(.mt.body2)
                            .foregroundColor(Color.mt.accent_700)
                    }
                                .padding(.vertical,8)
                                .padding(.horizontal,16)
                    ) {
                        LazyVGrid(
                            columns:columns,
                            alignment: .center,
                            spacing: 8,
                            pinnedViews: .sectionFooters)
                        {
                            ForEach(0 ..< 300) { item in
                                TeamCard(width: cardWidth)
                            }
                        }
                        
                    }
                }
            }
        }
        .navigationBarTitle(Text("小组"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading:               Circle()
                                .foregroundColor(Color.random)
                                .frame(width: 36, height: 36)
                            ,
                            trailing:
                                Button(
                                    action: {self.show = true},
                                    label: {Image
                                            .mt.load(.Setting)
                                            .foregroundColor(.mt.gray_900)
                                    }
                                )
                            
        )
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
                    .lineLimit(1)
                    .font(.mt.body2.mtBlod())
                Text("相册新增相片13张")
                    .lineLimit(1)
                    .font(.mt.caption2)
            }
        }
        .padding(.all,12)
        .frame(width: width)
        .background(Color.mt.gray_100)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
