//
//  LoginValidateCodeView.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/27.
//

import SwiftUI
import MotionComponents

struct LoginValidateCodeView: View {
    @EnvironmentObject var vm: LoginVM
    @Environment(\.presentationMode) var presentationMode
    
    var textFieldConfig = MTTextFieldStyle.Config()
    
    @State var textFieldText = ""

    var body: some View {
        VStack(alignment: .center, spacing: 26.0) {
            header
            
            TextField("验证码", text: $textFieldText)
                .mtTextFieldStyle($textFieldText, config: textFieldConfig)
                .keyboardType(.numberPad)
                .introspectTextField { textField in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [weak textField] in
                        textField?.becomeFirstResponder()
                    }
                }
                .onChange(of: textFieldText) { newValue in
                    vm.code = newValue
                    textFieldText = vm.code
                }
                
            
            Spacer()
            
            rightBtn            
        }
        .padding(.horizontal, 36)
        .mtNavBarLogo()
        .navigationBarBackButtonHidden(true)
        .mtToast(isPresented: $vm.logicAuth.toastisPresented, text: vm.logicAuth.toastText)
    }
    
    var header: some View {
        VStack(spacing: 12.0) {
            Text("请输入\(vm.phone)收到的\n短信验证码")
                .font(.mt.title2.mtBlod(), textColor: .mt.gray_800)
                .multilineTextAlignment(.center)
            
            HStack(spacing: 3.0) {
                Button("更改手机号") {
                    vm.code = ""
                    presentationMode.wrappedValue.dismiss()
                }
                
                Text("或").foregroundColor(.mt.gray_800)
                
                Button("重发短信") {
                    vm.sendCode(atPage: .validateCode)
                }
            }
            .font(.mt.body2.mtBlod())
            .foregroundColor(.mt.accent_purple)
        }
    }
    
    var rightBtn: some View {
        Button {
            vm.loginInWithCode()
        } label: {
            Image.mt.load(.Chevron_right_On)
                .foregroundColor(.white)
                .mtPlaceholderProgress(vm.logicAuth.isRequesting, progressColor: .white)
        }
        .mtRegisterRouter(isActive: $vm.logicAuth.isPushBaseInfoView, destination: {
            LoginBaseInfoView()
                .environmentObject(vm)
        })
        .mtButtonStyle(.cricleDefult(.black))
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.bottom, 16)
        .opacity(vm.code.count < LoginVM.Constant.codeMaxNum ? 0.6 : 1)
        .disabled(vm.code.count < LoginVM.Constant.codeMaxNum )
        
    }
}

struct LoginValidateCodeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginValidateCodeView()
                .environmentObject(LoginVM())
        }
    }
}
