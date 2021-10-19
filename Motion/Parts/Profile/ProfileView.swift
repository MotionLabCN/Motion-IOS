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
    @EnvironmentObject var userManager: UserManager
    
    @State private var showSettingView : Bool = false
    @State private var showOrderView : Bool = false
    
    var body: some View {
        
        NavigationView{
            List{
                Section{
                    toolBtns
                }header: {
                    userInfo
                }footer: {
                        logo
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitleDisplayMode(.inline)
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
        .frame(maxWidth:.infinity,alignment: .center)
        .padding(.top,ScreenHeight() * 0.08)
        .padding(.bottom,ScreenHeight() * 0.04)
    }
    
    @ViewBuilder
    var toolBtns : some View {
        
        Group{
            MtLableRow( text: "查看个人主页", icon: Image.mt.load(.Link))
            {locUserVm.isShowProfile.toggle()
              persentationMode.wrappedValue.dismiss()}
            
            MtLableRow( text: "我的订单", icon: Image.mt.load(.Link))
            {
                showOrderView.toggle()
            }
        
            MtLableRow( text: "代码仓库", icon: Image.mt.load(.Link))
            {
                showOrderView.toggle()
            }
            
            MtLableRow( text: "储存空间", icon: Image.mt.load(.Link))
            {
                showOrderView.toggle()
            }
            
            MtLableRow( text: "认证技术顾问", icon: Image.mt.load(.Link))
            {
                showOrderView.toggle()
            }
            
            MtLableRow( text: "元宇宙硬币", icon: Image.mt.load(.Link))
            {
                showOrderView.toggle()
            }

            MtLableRow( text: "设置", icon: Image.mt.load(.Link))
            {
                showSettingView.toggle()
            }
        }
            
           

    }
    
    @ViewBuilder
    var userInfo : some View {
        
        VStack(alignment:.center, spacing:8){
            
            MTLocUserAvatar( frame: 82)
                .disabled(true)
            
            VStack(alignment:.center, spacing:0){
                Text(userManager.user.username)
                    .font(.mt.body1.mtBlod(),textColor: .black)
                Text(userManager.user.nickname)
                    .font(.mt.body3,textColor: .mt.gray_600)
            }
            
            HStack{
                HStack{
                    Text(userManager.user.linkNum.string)
                        .font(.mt.body1.mtBlod(),textColor: .black)
                    Text("连接")
                        .font(.mt.body3,textColor: .mt.gray_900)
                }
                HStack{
                    Text(userManager.user.bylinkNum.string)
                        .font(.mt.body2.mtBlod(),textColor: .black)
                    Text("被连接")
                        .font(.mt.body3,textColor: .mt.gray_900)
                }
            }
        }
        .frame(maxWidth:.infinity,alignment: .center)
        .padding(.top,ScreenHeight() * 0.08)
        .padding(.bottom,ScreenHeight() * 0.04)
    }
    
    
}

struct LeftMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
