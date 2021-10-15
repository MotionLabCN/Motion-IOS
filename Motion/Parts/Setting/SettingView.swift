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
    
    var body: some View {
        NavigationView{
            List{
                //个人资料
                locUserInfo
                
                setting
        
                aboutUs
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Text("设置"))
            .navigationBarItems( trailing:completeBtn)
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
                LableRow( text: "AppStore评分", icon: Image.mt.load(.Link))})
            Link(destination: URL(string: "https://apps.apple.com/cn/app/id1528460698")!, label: {
                LableRow( text: "微信公众号", icon: Image.mt.load(.Link))})
        }
    }
    var setting : some View {
        Section {
        LableRow( text: "发现页管理", icon: Image.mt.load(.Search))
        LableRow( text: "小队", icon: Image.mt.load(.Group))
        LableRow( text: "通知", icon: Image.mt.load(.Notifications_outline))
        LableRow( text: "安全", icon: Image.mt.load(.Savings_bag))
        LableRow( text: "关于", icon: Image.mt.load(.Apps))
        LableRow( text: "SDK声明", icon: Image.mt.load(.Chat))
        LableRow( text: "鸣谢", icon: Image.mt.load(.Penny))
        }
    }
    
    var locUserInfo : some View {
        Section {
            Button(action: {
            }){
                HStack{
                    //用户头像
                    MTLocUserAvatar(frame: 64)
                    //用户名称
                    VStack(alignment: .leading, spacing: 4)  {
                        
                        Text("Motion用户")
                            .font(.mt.body1.mtBlod(),textColor :.mt.gray_900)
                            .multilineTextAlignment(.leading)
                        //用户昵称
                        Text("@" + "motion")
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

struct LableRow: View {

    var text : String
    var icon : Image
    
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
        
    }
}
