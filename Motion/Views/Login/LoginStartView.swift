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
    @State var playerStatus: MTVideoPlayerStatus?
    @State var isShowTermsOfService = false
    @EnvironmentObject var userManager: UserManager
    var player = AVQueuePlayer()
    
    var body: some View {
        NavigationView {
            ZStack {
                mp4
                ////                placeholder
                logo
                Text("线上协同元宇宙，与队伍实现伟大创造的地方。")
                    .font(.mt.title1.mtBlod(), textColor: .white)
                    .padding(.horizontal, 25)
                
                bottomTool
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
                MTRichText(preferredMaxLayoutWidth: tipTextW, text:
                            "同意《中国移动认证服务条款》，以及Motion的用户协议、隐私条款和其他声明。"
                            .colored(with: .white)
                            .font(with: .mt.body3)
                            .applying(attributes: [.font: UIFont.mt.body3.mtBlod()], toRangesMatching: "《中国移动认证服务条款》")
                            .onTap(subString: "《中国移动认证服务条款》") { (full, sub) in
                    isShowTermsOfService.toggle()
                })
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
            MTVideoPlayer(AVPlayerItem(url: url), player: player, status: $playerStatus)
                .ignoresSafeArea(edges: .all)
                .onAppear {
                    print("mp4 appear")
                    player.play()
                }
                .onDisappear {
                    print("mp4 disappear")
                    player.pause()
                }
        }
    }
    
    @ViewBuilder
    var placeholder: some View {
        switch playerStatus {
        case .ready:
            EmptyView()
        default:
            Color.random
                .ignoresSafeArea( edges: .all)
        }
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
