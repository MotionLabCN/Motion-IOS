//
//  LoginInputPhoneView.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/26.
//

import SwiftUI
import MotionComponents
import Introspect

struct LoginInputPhoneView: View {
    @StateObject var vm = LoginVM()
    var textFieldConfig = MTTextFieldStyle.Config()
    
    var body: some View {
        VStack(alignment: .center, spacing: 26.0) {
            Text("输入手机号码")
                .font(.mt.title2.mtBlod(), textColor: .black)
            
            TextField("手机号码", text: $vm.phone)
                .mtTextFieldStyle($vm.phone, config: textFieldConfig)
                .keyboardType(.numberPad)
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
    }
    
    var rightBtn: some View {
        NavigationLink {
            LoginValidateCodeView()
                .environmentObject(vm)
        } label: {
            Image.mt.load(.Chevron_right_On)
                .foregroundColor(.white)
        }
        .mtButtonStyle(.cricleDefult(.black))
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.bottom, 16)
        .opacity(vm.phone.count < LoginVM.Constant.phoneMaxNum ? 0.6 : 1)
        .disabled(vm.phone.count < LoginVM.Constant.phoneMaxNum)
      
    }
    
}

struct LoginInputPhoneView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginInputPhoneView()
                .environmentObject(LoginVM())
        }
    }
}
