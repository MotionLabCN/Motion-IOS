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
    @State private var mp4Start = false
    
    var body: some View {
        NavigationView {
            ZStack {
                mp4
                
                logo
                Text("线上协同元宇宙，与队伍实现伟大创造的地方。")
                    .font(.mt.title1.mtBlod(), textColor: .white)
                    .padding(.horizontal, 25)
                
                bottomTool
                
                if mp4Start == false {
                    placeholder
                }

            }
            .navigationBarHidden(true)
        }
    }
    
    var logo: some View {
        VStack {
            Image.mt.load(.Logo)
                .resizable()
                .frame(width: 44, height: 44)
                .foregroundColor(.white)
            
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
                    .frame(width: tipTextW)
                
                
            }
            .padding(.leading, -16)
            
            
            Spacer.mt.mid()
        }
        .padding(.horizontal, 38)
        
        
    }
    
    var startBtn: some View {
        let start = Color.mt.accent_purple
        let end = Color(hex: "887AFF")
        return Button {
            userManager.changeId("123")
        } label: {
            Text("开始")
                .mtButtonLabelStyle(.mainDefult())
                .background(
                    RadialGradient(colors: [end, start], center: .topTrailing, startRadius: -5, endRadius: 100)
                        .clipShape(Capsule(style: .continuous))
                )
        }
        .mtTapAnimation(style: .overlayOrScale())
    }
    
    @ViewBuilder
    var mp4: some View {
        if let url = Bundle.main.url(forResource: "startVedio", withExtension: "mp4") {
            MTVideoPlayer(url: url, play: $isPlay, time: $playTime)
                .autoReplay(true)
                .onBufferChanged { progress in
                    // Network loading buffer progress changed
                }
                .onPlayToEndTime {
                    // Play to the end time.
                    print("onPlayToEndTime")
                }
                .onReplay {
                    print("onReplay")
                }
                .onStateChanged { state in
                    switch state {
                    case .loading:
                        print(" Loading...")
                    case .playing(let totalDuration):
                        withAnimation {
                            mp4Start = true
                        }
                        print(" playing... \(totalDuration)")
                    case .paused(let playProgress, let bufferProgress):
                        print(" Paused... \(playProgress)")
                    case .error(let error):
                        print(" error... \(error)")
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
}

struct LoginStartView_Previews: PreviewProvider {
    static var previews: some View {
        let result = LoginStartView()
        
        result.bottomTool
            .previewLayout(.fixed(width: ScreenWidth(), height: 200))
            .background(Color.gray)
        
        result
            .background(Color.gray)
        
        
    }
}
