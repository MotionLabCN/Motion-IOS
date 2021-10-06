//
//  LoginCreateTeamView.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/27.
//

import SwiftUI
import MotionComponents



struct LoginCreateTeamView: View {
    @EnvironmentObject var userManager: UserManager

    @EnvironmentObject var vm: LoginVM

    var body: some View {
        VStack(alignment: .center, spacing: 70) {
            Text("仅需一步，在元宇宙开辟一个空间")
                .font(.mt.title2.mtBlod(), textColor: .mt.gray_800)
//                .fixedSize()
                .lineLimit(2)
                .multilineTextAlignment(.center)
            
            VStack(spacing: 16.0) {
                ForEach(vm.teamList) { team in
                    Button {
                        vm.choose(team)
                    } label: {
                        Text(team.text)
                            .mtButtonLabelStyle(.mainStorKer())
                            .overlay(
                                Capsule(style: .continuous)
                                    .stroke(team.isSelected ? Color.mt.accent_purple : .mt.gray_200, lineWidth: 1)
                            )
                        
                    }
                    .mtTapAnimation(style: .overlayOrScale())

                }
                
            }
              
            Spacer()
            
            rightBtn
        }
        .padding(.horizontal, 36)
        .mtNavBarLogo()

     
        .navigationBarBackButtonHidden(true)
    }
    

    var rightBtn: some View {
        Button {
//            userManager.changeId("123")
        } label: {
            Image.mt.load(.Chevron_right_On)
                .foregroundColor(.white)
        }
        .mtButtonStyle(.cricleDefult(.black))
//        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.bottom, 16)
        .opacity(vm.userName.isEmpty ? 0.6 : 1)
        .disabled(vm.userName.isEmpty)
        
    }
}

struct LoginCreateTeamView_Previews: PreviewProvider {
    static var previews: some View {
        let vm =  LoginVM()
        vm.choose(vm.teamList.first!)
        return LoginCreateTeamView()
            .environmentObject(vm)

    }
}
