//
//  MessageView.swift
//  Motion
//
//  Created by Liseami on 2021/9/17.
//

import SwiftUI
import MotionComponents

struct MessageView: View {
    var body: some View {
        let cell = ScreenWidth() / 375
        ScrollView(.vertical, showsIndicators: true) {
            LazyVStack(spacing: 12 * cell){
                Spacer().frame( height: 8)
                ForEach(0 ..< 119) { item in
                    MeesageListCell()
                }
            }
        }
  
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}


struct MeesageListCell : View{
    var body: some View {
        let cell = ScreenWidth() / 375
        VStack(spacing: 12 * cell){
            HStack(alignment:.top){
                Circle().foregroundColor(Color.random)
                    .frame(width: cell * 52, height: cell * 52)
                VStack(alignment: .leading, spacing:4){
                    HStack(spacing:4){
                        Text("刘江博")
                            .font(.mt.body1.mtBlod(),textColor: .black)
                        Text("@jiangBOoo")
                            .font(.mt.body2,textColor:.mt.gray_600)
                        Spacer()
                        Text("2020/07/04")
                            .font(.mt.body2,textColor:.mt.gray_600)
                    }
                    Text("向你发送了一张图片")
                        .font(.mt.body2,textColor:.mt.gray_600)
                }
                .padding(.top,4.5 * cell)
              
            }
            .padding(.horizontal)
            MT<Divider>.defult()
        }
    }
}
