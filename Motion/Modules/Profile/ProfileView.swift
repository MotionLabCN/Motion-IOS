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
    
    @EnvironmentObject var locUserVm: MTLocUserVM
    
    var body: some View {
        
            ScrollView(.vertical, showsIndicators: false) {
                
                Spacer().frame(width: 0, height: ScreenHeight() * 0.06)
                        userInfo
                
                        Spacer.mt.max()
                
                        toolBtns
                
                    Spacer.mt.max()
                    Spacer()
                        logo
            }
            
        .background(Color.white)
        .overlay( closeBtn,alignment: .topTrailing)
        
        
        
    }
    var closeBtn : some View {
        Button {
            self.persentationMode.wrappedValue.dismiss()
        } label: {
            Image.mt.load(.Close)
                .resizable()
                .frame(width: 24, height: 24)
        }.foregroundColor(Color.black)
            .padding(.all,4)
            .background(Color.mt.gray_100)
            .clipShape(Circle())
            .frame(maxWidth:.infinity,alignment: .trailing)
            .padding()
    }
    var logo : some View{
        VStack{
            Image.mt.load(.Logo)
                .foregroundColor(.mt.gray_300)
            Text("于2021年6月23日加入Motion")
                .font(.mt.caption1,textColor: .mt.gray_400)
        }
        .padding(.horizontal)
    }
    
  
    var toolBtns : some View {
        
        VStack{
            ProfileListRow(icon: Image.mt.load(.Person), text: "查看个人主页")
                .onTapGesture {
                    locUserVm.isShowProfile.toggle()

                    persentationMode.wrappedValue.dismiss()
                }
           
            
            ProfileListRow(icon: Image.mt.load(.Apps), text: "储存空间")
            ProfileListRow(icon: Image.mt.load(.Apps), text: "上传码力")
            ProfileListRow(icon: Image.mt.load(.Apps), text: "认证技术顾问")
            ProfileListRow(icon: Image.mt.load(.Logo), text: "元宇宙硬币")
            NavigationLink(destination: {
                SettingView()
            }, label: {
            ProfileListRow(icon: Image.mt.load(.Setting), text: "设置")})
    
        }
           
    
    
       
    }
    var userInfo : some View {
        VStack(alignment:.center, spacing:8){
            
            MTLocUserAvatar( frame: 82)
            
            VStack(alignment:.center, spacing:0){
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

struct LeftMenuView_Previews: PreviewProvider {
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
        .padding(.horizontal)
    }
}
