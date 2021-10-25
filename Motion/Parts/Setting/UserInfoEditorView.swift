//
//  UserInfoEditorView.swift
//  Motion
//
//  Created by 梁泽 on 2021/10/25.
//

import SwiftUI

struct UserInfoEditorView: View {
    @Environment(\.presentationMode) var persentationMode
    @EnvironmentObject var userManager: UserManager
    
    @State var isShowUserNameEditor = false
    @State var isShowNickNameEditor = false

    
    
    var body: some View {
        
        List
        {
            
            
            Button {
                isShowUserNameEditor.toggle()
            } label: {
                HStack{
                    Text("用户名")
                        .font(.mt.body1, textColor: .mt.gray_900)

                    Spacer()
                    
                    Text(userManager.user.username)
                        .font(.mt.body1, textColor: .mt.gray_900)

                }
                
            }

            Button {
                isShowNickNameEditor.toggle()
            } label: {
                HStack{
                    Text("昵称")
                        .font(.mt.body1, textColor: .mt.gray_900)

                    Spacer()
                    
                    Text(userManager.user.nickname)
                        .font(.mt.body1, textColor: .mt.gray_900)
                }
                
            }
           
            HStack{
                Text("头像")
                    .font(.mt.body1, textColor: .mt.gray_900)

                Spacer()
                MTLocUserAvatar().disabled(true)
            }
      
        }
        .listStyle(.insetGrouped)
        .navigationBarTitle("修改用户资料")
//        .navigationBarTitleDisplayMode(.inline)
        .mtRegisterRouter(isActive: $isShowUserNameEditor) {
            ModifilerUserNameView(style: .用户名)
        }
        .mtRegisterRouter(isActive: $isShowNickNameEditor) {
            ModifilerUserNameView(style: .昵称)
        }
       
    }
}

struct UserInfoEditorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserInfoEditorView()
                .environmentObject(UserManager.shared)
        }
       
    }
}
