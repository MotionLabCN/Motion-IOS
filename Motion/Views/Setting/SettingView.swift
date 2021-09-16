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
                Section {
                    Button(action: {
                    }){
                        HStack{
                            //用户头像
                            Circle().frame(width: 64, height: 64).foregroundColor(Color.random)
                            //用户名称
                            VStack(alignment: .leading, spacing: 4)  {
                                Text("userdatacenter.username")
                                    .multilineTextAlignment(.leading)
                                    .font(.mt.body2.mtBlod())
                                    .foregroundColor(.mt.gray_900)
                                //用户昵称
                                Text("@" + "(userdatacenter.userNickname)")
                                    .kerning(1)
                                    .lineLimit(1)
                                    .font(.mt.body3)
                                    .foregroundColor(.mt.gray_600)
                                Spacer()
                        }
                                Spacer()
                                Image.mt.load(.Error).foregroundColor(.mt.gray_500)
                    }
                    .padding(.vertical,8)
                }
                }
                
                Label {Text("发现页管理")} icon: {Image.mt.load(.Exchange ).foregroundColor(.mt.gray_600)}
                .padding(.vertical,8)
                Label {Text("队伍")} icon: {Image.mt.load(.Group).foregroundColor(.mt.gray_600)}
                .padding(.vertical,8)
                Label {Text("通知")} icon: {Image.mt.load(.Menu ).foregroundColor(.mt.gray_600)}
                .padding(.vertical,8)
                Label {Text("安全")} icon: {Image.mt.load(.Savings_bag ).foregroundColor(.mt.gray_600)}
                .padding(.vertical,8)
                Label {Text("关于")} icon: {Image.mt.load(.Close ).foregroundColor(.mt.gray_600)}
                .padding(.vertical,8)
                Label {Text("SDK声明")} icon: {Image.mt.load(.Person).foregroundColor(.mt.gray_600)}
                .padding(.vertical,8)
                Label {Text("鸣谢")} icon: {Image.mt.load(.Person).foregroundColor(.mt.gray_600)}
                .padding(.vertical,8)
                
              
                
                //关于Sporip
                Section {
                    LableRow(linkurl: "https://apps.apple.com/al/app/%E7%94%B5%E6%B5%81Sporip/id1552862011", text: "AppStore评分")
                    LableRow(linkurl: "https://apps.apple.com/cn/app/id1528460698", text: "微信公众号")
                }
                
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Text("设置"))
            .navigationBarItems( trailing:
                Button(action: {
                self.persentationMode.wrappedValue.dismiss()
            }, label: {
                Text("完成").font(.mt.body2.mtBlod()).foregroundColor(.mt.gray_600)
            })
          )
        }
     
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

struct LableRow: View {
    var linkurl : String
    var text : String

    
    var body: some View {
        Link(destination: URL(string: linkurl)!, label: {
            HStack {
                Text(text)
                    .font(.mt.body2.mtBlod())
                    .foregroundColor(.mt.gray_900)
                Spacer()
                Image.mt.load(.Link).foregroundColor(.mt.accent_700)
                    .disabled(true)
            }
            .padding(.trailing)
        })
    }
}
