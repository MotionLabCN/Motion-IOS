//
//  ProfileView.swift
//  ProfileView
//
//  Created by Liseami on 2021/9/16.
//

import SwiftUI
import MotionComponents

struct ProfileView: View {
    
    @Environment(\.presentationMode) var persentationMode
    
    
    var body: some View {
        
        NavigationView{
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    HStack{
                        Button(action: {
                            self.persentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image.mt.load(.Close_circle)
                        })
                        Spacer()
                        Image.mt.load(.Setting)
                    }
                    VStack(spacing:8){
                        let cell =  ScreenWidth() / 375
                        Circle()
                            .frame(width: cell * 82, height: cell * 82)
                        VStack(spacing:0){
                            Text("赵翔宇")
                                .font(.mt.body1.mtBlod(),textColor: .black)
                            Text("@liseami")
                                .font(.mt.body3,textColor: .mt.gray_600)
                        }
                        HStack{
                            HStack{
                                Text("2394")
                                    .font(.mt.body1.mtBlod(),textColor: .black)
                                Text("连接")
                                    .font(.mt.body3,textColor: .mt.gray_900)
                            }
                            HStack{
                                Text("204")
                                    .font(.mt.body2.mtBlod(),textColor: .black)
                                Text("被连接")
                                    .font(.mt.body3,textColor: .mt.gray_900)
                            }
                        }
                    }
                    Spacer.mt.max()
                    
                    VStack(spacing:24){
                        ForEach(0 ..< 5) { item in
                            ProfileListRow(text: "我的主页")
                        }
                    }
                    
                    Spacer()
                }
            }
            .padding(.horizontal)
            .navigationBarHidden(true)
        }
        
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

struct ProfileListRow: View {
    var text : String
    var body: some View {
        HStack{
            Image.mt.load(.Person)
            Text(text)
                .font(.mt.body2,textColor: .mt.gray_900)
            Spacer()
        }.padding(.all,16)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke().foregroundColor(.mt.gray_200))
    }
}
