//
//  LoginBaseInfoView.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/27.
//

import SwiftUI
import MotionComponents

struct LoginBaseInfoView: View {
    @EnvironmentObject var vm: LoginVM
    var textFieldConfig = MTTextFieldStyle.Config()

    var body: some View {
        VStack(alignment: .center, spacing: 26.0) {
            Text("基础资料")
                .font(.mt.title2.mtBlod(), textColor: .mt.gray_800)
            
            TextField("用户名", text: $vm.userName)
                .mtTextFieldStyle($vm.userName, config: textFieldConfig)
                .introspectTextField { textField in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [weak textField] in
                        textField?.becomeFirstResponder()
                    }
                }
              
            Spacer()
            
            rightBtn
        }
        .padding(.horizontal, 36)
        .navigationBarItems(leading: EmptyView(), trailing:
            Button(action: {
                // 调接口
                UserManager.shared.changeId("123")
            }, label: {
                Text("跳过")
                    .font(.mt.body2.mtBlod(), textColor: .mt.gray_600)
            })
        )
        .mtNavBarLogo()

     
        .navigationBarBackButtonHidden(true)
    }
    

    var rightBtn: some View {
        NavigationLink {
           
        } label: {
            Image.mt.load(.Chevron_right_On)
                .foregroundColor(.white)
        }
        .mtButtonStyle(.cricleDefult(.black))
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.bottom, 16)
        .opacity(vm.userName.isEmpty ? 0.6 : 1)
        .disabled(vm.userName.isEmpty)
        
    }
}

struct LoginBaseInfoView_Previews: PreviewProvider {
    static var previews: some View {
        LoginBaseInfoView()
    }
}
