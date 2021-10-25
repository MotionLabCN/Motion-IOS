//
//  ModifilerUserNameView.swift
//  Motion
//
//  Created by 梁泽 on 2021/10/25.
//

import SwiftUI
import MotionComponents

struct ModifilerUserNameView: View {
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
        .mtNavBarLogo()
        .mtToast(isPresented: $isShowToast, text: toastText)
        .onChange(of: vm.requestStateForUpdateUserName) { newValue in
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
//            vm.updateUserBaseInfo()
//            LoginCreateTeamView()
//                .environmentObject(vm)
        }, label: {
            Image.mt.load(.Chevron_right_On)
                .foregroundColor(.white)
//                .mtPlaceholderProgress(vm.requestStateForBaseInfo.isRequesting, progressColor: .white)
        })
        .mtButtonStyle(.cricleDefult(.black))
        .frame(maxWidth: .infinity, alignment: vm.isCanModifierUserName ? .trailing : .center)
        .mtAnimation(.spring())
        .padding(.bottom, 16)
        .opacity(vm.isCanModifierUserName ? 1 : 0.6)
        .disabled(!vm.isCanModifierUserName)

    }
}

struct ModifilerUserNameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ModifilerUserNameView()
        }
    }
}
