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
                    userInfo
                  
                    Spacer.mt.max()
                    
                    toolBtns
                    
                Spacer.mt.max()
             
                    logo
              
              
            }
            .navigationBarItems( trailing:   closeBtn)
            .navigationBarTitleDisplayMode(.inline)
            
        }
        
        
    }
    var logo : some View{
        VStack{
            Image.mt.load(.Logo)
                .foregroundColor(.mt.gray_300)
            Text("于2021年6月23日加入Motion")
                .font(.mt.caption1,textColor: .mt.gray_400)
        }
    }
    var closeBtn : some View{
        Button(action: {
            self.persentationMode.wrappedValue.dismiss()
        }, label: {
            Image.mt.load(.Close)
         .foregroundColor(.mt.gray_900)
        })
    }
    var toolBtns : some View {
        VStack(spacing:24){
            
            ProfileListRow(icon: Image.mt.load(.Person), text: "查看个人主页")
            ProfileListRow(icon: Image.mt.load(.Github), text: "链接Github")
            ProfileListRow(icon: Image.mt.load(.Apps), text: "储存空间")
            ProfileListRow(icon: Image.mt.load(.Logo), text: "元宇宙硬币")
            
            NavigationLink(destination: {
                SettingView()
            }, label: {
            ProfileListRow(icon: Image.mt.load(.Setting), text: "设置")})
                
        }
    }
    var userInfo : some View {
        VStack(spacing:8){
            
            MTLocUserAvatar( frame: 82)
            
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
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

struct ProfileListRow: View {
    var icon : Image
    var text : String
    var body: some View {
        HStack{
            icon
                .foregroundColor(.mt.gray_600)
            Text(text)
                .font(.mt.body1,textColor: .black)
            Spacer()
        }
        .padding()
        .background(Color.white)
        .clipShape(Capsule(style: .continuous))
        .overlay( Capsule(style: .continuous).strokeBorder().foregroundColor(.mt.gray_100))
        .padding(.horizontal)
    }
}
