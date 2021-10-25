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
    
    var body: some View {
        
        List
        {
            Button {
                isShowUserNameEditor.toggle()
            } label: {
                HStack{
                    Text("用户名")
                    Spacer()
                    Text(userManager.user.username)
                }
                
            }

           
            HStack{
                Text("头像")
                Spacer()
                MTLocUserAvatar().disabled(true)
            }
      
        }
        .listStyle(.insetGrouped)
        .navigationBarTitle("修改用户资料")
//        .navigationBarTitleDisplayMode(.inline)
        .mtRegisterRouter(isActive: $isShowUserNameEditor) {
            ModifilerUserNameView()
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
