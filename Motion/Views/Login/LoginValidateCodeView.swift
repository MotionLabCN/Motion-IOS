//
//  LoginValidateCodeView.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/27.
//

import SwiftUI
import MotionComponents
import Introspect

struct LoginValidateCodeView: View {
    @EnvironmentObject var vm: LoginVM
    @EnvironmentObject var userManager: UserManager
    @Environment(\.presentationMode) var presentationMode

    var textFieldConfig = MTTextFieldStyle.Config()
    
    var body: some View {
            VStack(alignment: .center, spacing: 26.0) {
                header
                
                TextField("手机号码", text: $vm.code)
                    .mtTextFieldStyle($vm.code, config: textFieldConfig)
                    .keyboardType(.numberPad)
                    .introspectTextField { textField in
                        vm.codeTextField = textField
                    }
                    .onChange(of: vm.code) { newValue in
                        print("\(newValue)")
                    }
                
                Spacer()
                
                rightBtn
                
                
            }
            .padding(.horizontal, 36)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image.mt.load(.Logo)
                        .resizable()
                        .foregroundColor(.mt.accent_purple)
                        .mtFrame(square: 44)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.58) {
                    vm.codeTextField?.becomeFirstResponder()
                }
            }
            .onDisappear {
                MTHelper.closeKeyboard()
            }
//            .introspectViewController { vc in
//                vc.navigationController?.navigationBar.setBackgroundImage(.init(), for: .default)
//            }

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
                    
                }
            }
            .font(.mt.body2.mtBlod())
            .foregroundColor(.mt.accent_purple)
        }
    }
    
    var rightBtn: some View {
        Button {
//            presentationMode.wrappedValue.dismiss()
            userManager.changeId("123")
        } label: {
            Image.mt.load(.Chevron_right_On)
                .foregroundColor(.white)
        }
        .mtButtonStyle(.cricleDefult(.black))
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.bottom, 16)
        .opacity(vm.isCodeInvalidate ? 0.6 : 1)
        .disabled(vm.isCodeInvalidate)

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
