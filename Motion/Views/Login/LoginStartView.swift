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
    @State var isShowTermsOfService = false
    @EnvironmentObject var userManager: UserManager
    var player = AVPlayer()
    
    @State private var isPlay: Bool = true
    @State private var playTime: CMTime = .zero
    @State private var mp4Start = true
    
    @State private var isShowLoginSheet = false
    @State private var isPhoneLoginActive = false
    
    @State private var isShowToast = false
    @State private var toastText = ""
    @State private var toastStyle = MTPushNofi.PushNofiType.danger
    
    var body: some View {
//        NavigationView {
            ZStack {
                rotuerView
                
                mp4
                
                logo
                Text("全球技术方案、计算设备、技术实践者，通过Motion互相连接。")
                    .font(.mt.title1.mtBlod(), textColor: .white)
                    .padding(.horizontal, 25)
                
                bottomTool
                
                if mp4Start == false {
                    placeholder
                }
     
            
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .navigationBarHidden(true)
            .mtSheet(isPresented: $isShowLoginSheet, content: loginMethodSheetContent)
            .mtTopProgress(true)//网络加载
            .mtToast(isPresented: $isShowToast, text: toastText, style: toastStyle)
            
//        }
    }
    
    var rotuerView: some View {
        NavigationLink(isActive: $isPhoneLoginActive) {
            LoginInputPhoneView()
        } label: {
            EmptyView()
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
                NavigationLink(
                    destination: MTWebView(urlString: "https://m.baidu.com"),
                    isActive: $isShowTermsOfService,
                    label: {
                        EmptyView()
                    })
                
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
                let tipTextW: CGFloat = ScreenWidth() - 38 * 2 - 16 - 16
                let text = "同意《中国移动认证服务条款》，以及Motion的用户协议、隐私条款和其他声明。"
                let customType1 = ActiveType.custom(pattern: "《中国移动认证服务条款》")
                MTRichText(text)
                    .textColor(.white, font: .mt.body3)
                    .lineSpacing(2)
                    .customTypes([customType1])
                    .configureLinkAttribute { type, attri, _ in
                        var mattri = attri
                        switch type {
                        case .custom:
                            mattri[.font] = UIFont.mt.body3.mtBlod()
                            mattri[.foregroundColor] = UIColor.white
                        default:  break
                        }
                        return mattri
                    }
                    .onCustomTap(for: customType1) { text in
                        print("click \(customType1) text: \(text)")
                        isShowTermsOfService.toggle()
                    }
                
                
            }
//            .frame(width: ScreenWidth() - 32 -)
            .padding(.leading, -16)
            
            
            Spacer.mt.mid()
        }
        .frame(width: ScreenWidth() - 76)
    }
    
    var startBtn: some View {
        Button("开始") {
            isShowLoginSheet = true
            isShowToast = true
            toastText = "start "
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
                isShowLoginSheet = false
                LoginVM().loginIn()
            })
            .mtButtonStyle(.mainGradient)
            
            
             
            Button(action: {
//                let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2MyIsImV4cCI6MTYzMjk3NTM5OH0.w2CoMVO-6J5FWcmA1dmb8GCfFbKhG_D1WFluUDUUqgE"
//                userManager.loginSusscessSaveToken(token, channel: .github)
//                // 调用接口信息
//                LoginVM().loginInWithGithub()
                
                ThirdAuth.shared.signIn(platform: .git(method: .asAuth), completion: { response in
                    guard case let .git(result) = response?.response else {
                        isShowToast = true
                        toastText = "Github登录失败"
                        return
                    }
                    // 掉接口
                    //eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2MyIsImV4cCI6MTYzMjk3NTM5OH0.w2CoMVO-6J5FWcmA1dmb8GCfFbKhG_D1WFluUDUUqgE
                    userManager.loginSusscessSaveToken(result.token, channel: .github)
                    // 调用接口信息
                    LoginVM().loginInWithGithub()
                    isShowLoginSheet = false

                })
            }, label: {
                HStack {
                    Image.mt.load(.Github)
                    Text("使用GitHub登录")
                }
            })
            .mtButtonStyle(.mainStorKer())
            
            Button(action: {
                toastStyle = .warning
                isShowToast = true
                toastText = "click pinggu"
                ThirdAuth.shared.signIn(platform: .apple, completion: { response in
                    print("Thread.shared.signIn(platform: .git(method: .asAuth), completion: { response : \(response)")
                })
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
                isShowLoginSheet = false
                isPhoneLoginActive = true
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
