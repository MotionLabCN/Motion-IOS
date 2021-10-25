//
//  LoginStartView.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/23.
//

import SwiftUI
import MotionComponents
import AVKit



struct LoginStartView: View {
    @State private var isShowTermsOfService = false
    @State private var isShowUserProtocol = false
    @State private var isShowPrivacy = false

    
    @EnvironmentObject var userManager: UserManager
    var player = AVPlayer()
    
    @State private var isPlay: Bool = true
    @State private var playTime: CMTime = .zero
    @State private var mp4Start = true
    
    
    @StateObject private var vm = LoginVM()
    @State private var isPushInputPhoneView = false
    @State private var isShowLoginSheet = false

    
    var body: some View {
        ZStack {
            mp4
            
            logo
            Text("极大简化算力、码力、人力的运作方式，让技术自由发生。")
                .font(.mt.title1.mtBlod(), textColor: .white)
                .padding(.horizontal, 16)
            
            bottomTool
            
            if mp4Start == false {
                placeholder
            }
            
            
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .navigationBarHidden(true)
        .mtSheet(isPresented: $isShowLoginSheet, content: loginMethodSheetContent)
        .mtTopProgress(vm.logicStart.isShowLoading, usingBackgorund: true)//网络加载
        .mtRegisterRouter(isActive: $isPushInputPhoneView) {
            LoginInputPhoneView()
                .environmentObject(vm)
        }
       
       
    }
    

    
    var logo: some View {
        VStack {
            MTLogoView(color: .white)
            
            Spacer()
        }
    }
    
    
    var bottomTool: some View  {
        VStack(spacing: 16) {
            Spacer()
            
            startBtn
            
            HStack(spacing: 0) {
                Button {
                    print("click 选中")
                } label: {
                    Image.mt.load(.Penny)
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .contentShape(Rectangle())
                }
                //                .mtAnimation(isOverlay: false)
                
                // 减去 容器padding - 图片大小 - stack间隙
                let text = "同意《中国移动认证服务条款》，以及Motion的用户协议、隐私条款和其他声明。"
                let customType1 = ActiveType.custom(pattern: "《中国移动认证服务条款》")
                let customType2 = ActiveType.custom(pattern: "用户协议")
                let customType3 = ActiveType.custom(pattern: "隐私条款")

                 MTRichText(text)
                    .textColor(.white, font: .mt.body3)
                    .lineSpacing(2)
                    .customTypes([customType1, customType2, customType3])
                    .configureLinkAttribute { type, attri, _ in
                        var mattri = attri
                        switch type {
                        case customType1:
                            mattri[.font] = UIFont.mt.body3.mtBlod()
                            mattri[.foregroundColor] = UIColor.white
                        case customType2, customType3:
                            mattri[.font] = UIFont.mt.body3
                            mattri[.foregroundColor] = UIColor.white
                        default:  break
                        }
                        return mattri
                    }
                    .onCustomTaps(actions: [
                        customType1 : { _ in
                            isShowTermsOfService.toggle()
                        },
                        customType2 : { _ in
                            isShowUserProtocol.toggle()
                        },
                        customType3 : { _ in
                            isShowPrivacy.toggle()
                        },
                    ])
                
                
                
            }
            //            .frame(width: ScreenWidth() - 32 -)
            .padding(.leading, -16)
            
            
            Spacer.mt.mid()
        }
        .frame(width: ScreenWidth() - 76)
        .mtRegisterRouter(isActive: $isShowTermsOfService) {
            MTWebView(urlString: "https://revome.cn/#/protocol")
        }
        .mtRegisterRouter(isActive: $isShowUserProtocol) {
            MTWebView(urlString: "https://revome.cn/#/protocol")
        }
        .mtRegisterRouter(isActive: $isShowPrivacy) {
            MTWebView(urlString: "https://revome.cn/#/privacyPolicy")
        }
       
    }
    
    var startBtn: some View {
        Button("开始") {
            isShowLoginSheet = true
        }
        .mtButtonStyle(.mainGradient)
        
    }
    
    @ViewBuilder
    var mp4: some View {
        if let url = Bundle.main.url(forResource: "startVedio", withExtension: "mp4") {
            MTVideoPlayer(url: url, play: $isPlay, time: $playTime)
                .autoReplay(true)
                .onStateChanged { state in
                    switch state {
                    case .loading: break
                    case .playing:
                        withAnimation {
                            mp4Start = true
                        }
                    case .paused: break
                    case .error: break
                    }
                }
                .ignoresSafeArea(edges: .all)
                .onAppear {
                    isPlay = true
                }
                .onDisappear {
                    isPlay = false
                }
        }
    }
    
    @ViewBuilder
    var placeholder: some View {
        Color.random.opacity(0.6)
            .ignoresSafeArea( edges: .all)
    }
    
    /// sheet弹出框框
    func loginMethodSheetContent() -> some View {
        VStack(spacing: 16.0) {
            VStack(spacing: 4.0) {
                Text("152 **** 3458")
                    .font(.mt.title2.mtBlod(), textColor: .black)
                Text("中国移动提供认证服务")
                    .font(.mt.body3.mtBlod(), textColor: .mt.gray_600)
            }
            
            
            Button("本机号码一键登录", action: {
                LoginVM().debugLoginIn()
            })
                .mtButtonStyle(.mainGradient)
            
            
            Button(action: {
                vm.loginInWithGithub {
                    isShowLoginSheet = false
                    isPushInputPhoneView = true
                }
            }, label: {
                HStack {
                    Image.mt.load(.Github)
                    Text("使用GitHub登录")
                }
            })
                .mtButtonStyle(.mainStorKer())
            
            Button(action: {
                vm.loginInWithApple {
                    isShowLoginSheet = false
                    isPushInputPhoneView = true
                }
            }, label: {
                HStack {
                    Image.mt.load(.Github)
                    Text("使用Apple登录")
                }
            })
                .mtButtonStyle(.mainStorKer())
            
            //
            HStack {
                let line = Capsule()
                    .foregroundColor(.mt.gray_200)
                    .frame(height: 1)
                line
                Text("或")
                line
            }
            
            Button("其他手机号码登录")  {
                vm.channel = .手机验证码
                
                isShowLoginSheet = false
                isPushInputPhoneView = true
            }
            .mtButtonStyle(.mainStorKer())
        }
        .padding(.horizontal, 38)
        .padding(.vertical, 32)
    }
    
    func login() {
        
        
    }
}



























struct LoginStartView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            let result = LoginStartView()
            
            //        result.bottomTool
            //            .previewLayout(.fixed(width: ScreenWidth(), height: 200))
            //            .background(Color.gray)
            
            result
        }
        
        
        
    }
}
