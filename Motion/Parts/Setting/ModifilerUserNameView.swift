//
//  ModifilerUserNameView.swift
//  Motion
//
//  Created by 梁泽 on 2021/10/25.
//

import SwiftUI
import MotionComponents

struct ModifilerUserNameView: View {
    enum Style {
        case 用户名, 昵称
    }
    let style: Style
    
    @Environment(\.presentationMode) var persentationMode
    @EnvironmentObject var userManager: UserManager
    
    @StateObject var vm = UserInfoEditorVM()
    var textFieldConfig = MTTextFieldStyle.Config()
    
    @State var isShowToast = false
    @State var toastText = ""

    var body: some View {
        VStack(alignment: .center, spacing: 26.0) {
            Text("修改用户名")
                .font(.mt.title2.mtBlod(), textColor: .mt.gray_800)
            
            TextField("用户名", text: style == .用户名 ? $vm.userName : $vm.nickName)
                .mtTextFieldStyle(style == .用户名 ? $vm.userName : $vm.nickName, config: textFieldConfig)
                .introspectTextField { textField in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [weak textField] in
                        textField?.becomeFirstResponder()
                    }
                }
              
            Spacer()
            
            rightBtn
        }
        .padding(.horizontal, 36)
        .mtNavBarLogo()
        .mtToast(isPresented: $isShowToast, text: toastText)
        .onChange(of: vm.requestStateForUpdate) { newValue in
            switch newValue {
            case .completion:
                persentationMode.wrappedValue.dismiss()
            case let .completionTip(text, _):
                toastText = text
                isShowToast = true
            default: break
            }
        }
    }
    

    var rightBtn: some View {
        Button(action: {
            switch style {
            case .用户名: vm.updateUserName()
            case .昵称: vm.updateNickName()
            }
            
        }, label: {
            Image.mt.load(.Chevron_right_On)
                .foregroundColor(.white)
                .mtPlaceholderProgress(vm.requestStateForUpdate.isRequesting, progressColor: .white)
        })
        .mtButtonStyle(.cricleDefult(.black))
        .frame(maxWidth: .infinity, alignment: vm.isCanModifierName ? .trailing : .center)
        .mtAnimation(.spring())
        .padding(.bottom, 16)
        .opacity(vm.isCanModifierName ? 1 : 0.6)
        .disabled(!vm.isCanModifierName)

    }
}

struct ModifilerUserNameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ModifilerUserNameView(style: .昵称)
        }
    }
}
