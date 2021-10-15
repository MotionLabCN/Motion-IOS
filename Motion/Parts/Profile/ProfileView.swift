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
    
    @State private var showSettingView : Bool = false
    @State private var showOrderView : Bool = false
    
    var body: some View {
        
        NavigationView{
            ScrollView(.vertical, showsIndicators: false) {
                Spacer().frame(width: 0, height: ScreenHeight() * 0.06)
                        userInfo
                
                        Spacer.mt.max()
                
                        toolBtns
                
                    Spacer.mt.max()
                    Spacer()
                        logo
            }
        .background(naviLinksandSheet)
        .overlay( closeBtn,alignment: .topTrailing)
        .navigationBarHidden(true)
        }
       
           
        
        
        
    }
    @ViewBuilder
    var naviLinksandSheet : some View {
        
        Group{
            NavigationLink(isActive: $showSettingView) {
                SettingView().navigationBarHidden(true)
            } label: {
                EmptyView()
            }
            NavigationLink(isActive: $showSettingView) {
                SettingView()
            } label: {
                EmptyView()
            }
        }
        .sheet(isPresented: $showOrderView) {
            OrderView()
        }
        
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
            {locUserVm.isShowProfile.toggle()
              persentationMode.wrappedValue.dismiss()}
            
            ProfileListRow(icon: Image.mt.load(.Cart), text: "我的订单"){
                showOrderView.toggle()
            }
            
            ProfileListRow(icon: Image.mt.load(.Apps), text: "代码仓库"){
                
            }
            
            ProfileListRow(icon: Image.mt.load(.Apps), text: "储存空间"){}
            
            ProfileListRow(icon: Image.mt.load(.Apps), text: "认证技术顾问"){}
            
            ProfileListRow(icon: Image.mt.load(.Logo), text: "元宇宙硬币"){}
         
            ProfileListRow(icon: Image.mt.load(.Setting), text: "设置"){
                    showSettingView.toggle()
                }
        }
           
    
    
       
    }
    var userInfo : some View {
        VStack(alignment:.center, spacing:8){
            
            MTLocUserAvatar( frame: 82)
                .disabled(true)
            
            VStack(alignment:.center, spacing:0){
                Text("Motion用户")
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
    var action : ()->Void
    var body: some View {
        Button {
            action()
        } label: {
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
}
