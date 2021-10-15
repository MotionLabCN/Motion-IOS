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
                        .font(.custom("OPPOSans B", size: 24))
                        .foregroundColor(.mt.accent_purple)
                        .animation(.spring())
                        .transition(.move(edge: .top))
                }
            }
             
                MTLottieView(lottieFliesName: "Launch", loopMode: .loop)
                    .animation(.spring())
                    .transition(.move(edge: .leading))
                    .frame(width:  ScreenWidth() * 0.3)
                    .offset(x:Step == 2 ? ScreenWidth() : Step == 1 ? 0 : -ScreenWidth() )
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
