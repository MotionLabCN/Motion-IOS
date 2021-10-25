//
//  Setting.swift
//  Setting
//
//  Created by Liseami on 2021/9/15.
//

import SwiftUI
import MotionComponents

struct SettingView: View {
    
    @Environment(\.presentationMode) var persentationMode
    @EnvironmentObject var userManager: UserManager
    
    @State private var showUserNameEditor : Bool = false
    @State private var showAbout : Bool = false
    @State private var showSDK : Bool = false
    @State private var showUserInfoEditor : Bool = false
    @State private var username : String = ""
    
    var body: some View {
        NavigationView{
            List{
                //个人资料
                locUserInfo
                
                setting
        
                aboutUs
                
                loginOut
            }
            .background(navigationLinks)
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Text("设置"))
            .navigationBarItems( trailing:completeBtn)
           

        }
        
    }
    
  
    var navigationLinks : some View{
        ZStack{
            NavigationLink(isActive: $showAbout) {
                MTDescriptionView(title: "Motion", subTitle: "1.0.01")
            } label: {
                EmptyView()
            }
            NavigationLink(isActive: $showAbout) {
                MTDescriptionView(title: "Motion", subTitle: "1.0.01")
            } label: {
                EmptyView()
            }
            NavigationLink(isActive: $showUserInfoEditor) {
                UserInfoEditorView()
            } label: {
                EmptyView()
            }
        }
    }
    var completeBtn : some View {
        Button(action: {
        self.persentationMode.wrappedValue.dismiss()
    }, label: {
        Text("完成").font(.mt.body2.mtBlod()).foregroundColor(.mt.gray_600)
    })
    }
    
    var aboutUs : some View{
        //关于Sporip
        Section {
            Link(destination: URL(string: "https://apps.apple.com/al/app/%E7%94%B5%E6%B5%81Sporip/id1552862011")!, label: {
                MtLableRow( text: "AppStore评分", icon: Image.mt.load(.Link)){}.disabled(true)
            })
            
            Link(destination: URL(string: "https://apps.apple.com/cn/app/id1528460698")!, label: {
                MtLableRow( text: "微信公众号", icon: Image.mt.load(.Link)){}.disabled(true)})
        }
    }
    
    var loginOut: some View {
        Section {
            Button {
                persentationMode.wrappedValue.dismiss()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    userManager.logout()
                }
            } label: {
                MtLableRow( text: "退出登录", icon: Image.mt.load(.Link)){
                    
                }
            }

        }
    }
    
    var setting : some View {
        Section {
//        LableRow( text: "发现页管理", icon: Image.mt.load(.Search))
//        LableRow( text: "小队", icon: Image.mt.load(.Group))
//        LableRow( text: "通知", icon: Image.mt.load(.Notifications_outline))
//        LableRow( text: "安全", icon: Image.mt.load(.Savings_bag))
        
          
            MtLableRow( text: "关于", icon: Image.mt.load(.Apps)){
                showAbout.toggle()
            }
            MtLableRow( text: "SDK声明", icon: Image.mt.load(.Chat)){
                showSDK.toggle()
            }
            
//        LableRow( text: "鸣谢", icon: Image.mt.load(.Penny))
        }
    }
    
    var locUserInfo : some View {
        Section {
            Button(action: {
                showUserInfoEditor.toggle()
            }){
                HStack{
                    //用户头像
                    MTLocUserAvatar(frame: 64)
                    //用户名称
                    VStack(alignment: .leading, spacing: 4)  {
                        Text(userManager.user.username)
                            .font(.mt.body1.mtBlod(),textColor :.mt.gray_900)
                            .multilineTextAlignment(.leading)
                        //用户昵称
                        Text("@" + userManager.user.nickname)
                            .font(.mt.body3,textColor: .mt.gray_600)
                        Spacer()
                        
                    }
                    .padding(.top,6)
                    .lineLimit(1)
                    Spacer()
                    
                    Image.mt.load(.Create).foregroundColor(.mt.gray_500)
                        .padding()
                }
                .padding(.vertical,8)
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    
    }
}

struct MtLableRow: View {

    var text : String
    var icon : Image
    var action : ()->()
    var body: some View {
    
        HStack (spacing:16){
                icon
                    .foregroundColor(.mt.accent_800)
                    .disabled(true)
                Text(text)
                    .font(.mt.body2)
                    .foregroundColor(.mt.gray_800)
                Spacer()
            
            Image.mt.load(.Chevron_right_Off)
                .foregroundColor(.mt.gray_300)
                .disabled(true)
            
            }
            .padding(.vertical,8)
            .onTapGesture {
                action()
            }
        
    }
}
