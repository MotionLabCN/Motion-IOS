//
//  Ladder.swift
//  Motion
//
//  Created by Liseami on 2021/9/23.
//

import SwiftUI
import MotionComponents

struct Ladder: View {
    var body: some View {
        
        
        ScrollView(.vertical, showsIndicators: true){
            VStack(spacing:16){
                banner
                StarGroup
                    .padding(.bottom,16)
                Ladderlist
            }
            .padding(.top,16)
        }
    }
    
    var banner : some View {
        
        VStack(spacing:16){
            Image("Banner")
                .resizable()
                .scaledToFit()
            Text("2021远程协作之星「新致奖」")
                .font(.mt.title2.mtBlod(),textColor: .black)
                .frame(maxWidth :.infinity,alignment: .leading)
        }
        .padding(.horizontal)
        .padding(.bottom,16)
    
    }
    
    @ViewBuilder
    var StarGroup : some View{
        let cardWidth = (ScreenWidth() - 32 - 8 ) / 2
        let columns =
        Array(repeating:  GridItem(.fixed(cardWidth)), count: 2)
        LazyVGrid(
            columns:columns,
            alignment: .center,
            spacing: 16,
            pinnedViews: .sectionFooters){
                ForEach(0 ..< 4) { item in
                    TeamCard(width: cardWidth)
                }
            }
      
    }
    
    var Ladderlist : some View {
        Section {
            ForEach(0 ..< 50) { item in
                LadderListCell()
                    .padding(.horizontal,16)
                    .padding(.top,8)
                Divider()
            }
        } header: {
            HStack {
                Text("小组天梯")
                    .font(.mt.title2.mtBlod(),textColor: .black)
                Spacer()
                Image.mt.load(.Filter_list)
                    .foregroundColor(.mt.accent_800)
            }
            .padding(.horizontal)
        }
    }
    
}

struct Ladder_Previews: PreviewProvider {
    static var previews: some View {
        Ladder()
    }
}

struct LadderListCell: View {
    var body: some View {
        HStack(alignment:.top,spacing:16){
            
            Capsule(style: .continuous).frame(width: ScreenWidth() / 4, height: 66)
                .foregroundColor(.random)
            
            VStack(alignment: .leading,spacing:16){
                
                VStack(alignment: .leading,spacing:4){
                    
          
                Text("天天数链研发中心")
                    .font(.mt.body1.mtBlod(),textColor: .mt.accent_800)
                Text("Motion社区的研发团队，广泛吸收全国各地的共识工作者，通过远程办公的方式打造一款企业级App。")
                    .font(.mt.body2,textColor: .mt.gray_600)
                    .lineLimit(3)
                    .frame(maxWidth:.infinity,alignment: .leading)
                }
                HStack(spacing:-12){
                    MTAvatar(frame: 44) {}
                    MTAvatar(frame: 44) {}
                    MTAvatar(frame: 44) {}
                }
                HStack{
                    Image.mt.load(.Logo)
                        .frame(width: 16, height: 16)
                        .foregroundColor(.mt.gray_600)
                    Text("329,434,564.00")
                        .font(.mt.body3,textColor: .mt.gray_600)
                    Spacer()
                    Image.mt.load(.Arrow_dropdown)
                        .frame(width: 16, height: 16)
                        .foregroundColor(.mt.gray_600)
                }
            }
        }
    }
}
