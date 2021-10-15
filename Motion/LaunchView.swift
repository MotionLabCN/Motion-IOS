//
//  Lun.swift
//  TimeMachine (iOS)
//
//  Created by Liseami on 2021/10/14.
//

import SwiftUI
import MotionComponents

struct LaunchView: View {
    @State var Step : Int = 0
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(spacing:-12){
                if Step  > 1  {
                    Text("让技术发生")
                        .kerning(12)
                        .font(.custom("OPPOSans B", size: 24))
                        .foregroundColor(.mt.accent_purple)
                        .animation(.spring())
                        .transition(.move(edge: .top))
                }
            }
                MTLottieView(lottieFliesName: "Launch", loopMode: .loop)
                    .transition(.opacity)
                    .frame(width:  ScreenWidth() * 0.7)
                    .scaleEffect(Step == 2 ? 100 : Step == 1 ? 1 : 1)
                    .offset(y: Step == 2 ? 160 : Step == 1 ? 1 : 1)
                    .animation(.spring())
                    
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                Step += 1
                DispatchQueue.main.asyncAfter(deadline: .now()+1.2) {
                    Step += 1
                }
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
