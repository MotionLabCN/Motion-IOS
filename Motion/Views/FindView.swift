//
//  FindView.swift
//  FindView
//
//  Created by Liseami on 2021/9/16.
//

import SwiftUI
import MotionComponents

public var findViewTabs = ["推荐","名人","天梯","前沿","趋势"]

struct FindView: View {
  
    @EnvironmentObject var fullscreen: AppState.TopFullScreenPage
    @State var offset : CGFloat = 0.0
    
    
    var body: some View {
        VStack(spacing:0){
            
            //TOP Tabbar
            FindViewTopTabBar(offset: $offset)
            
            // UIKit 实现的横向分页滚动View
            ScrollableTabView(tabs: findViewTabs, rect: CGRect(x: 0, y: 0, width: ScreenWidth(), height: ScreenHeight()), offset: $offset) {
                HStack(spacing:0){
                    
                    //FindView分页
                    ForEach(0 ..< 5) { item in
                        switch item {
                        case 0 :
                            //推荐
                            RecommendView()
                        case 1 :
                            //名人
                            Color.random.frame(width: ScreenWidth() , height: ScreenHeight())
                        case 2 :
                            //天梯
                            Color.random.frame(width: ScreenWidth() , height: ScreenHeight())
                        case 3 :
                            //前沿
                            Color.random.frame(width: ScreenWidth() , height: ScreenHeight())
                        case 4 :
                            //趋势
                            Color.random.frame(width: ScreenWidth() , height: ScreenHeight())
                        default:
                            EmptyView()
                                .frame(width: ScreenWidth() , height: ScreenHeight())
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .padding(.top,44)
        .navigationBarTitleDisplayMode(.inline)
        .mtNavbar(content: {
            Capsule().frame(width: 255, height: 32)
                .foregroundColor(.mt.gray_200)
                .overlay(HStack{
                    Image.mt.load(.Search)
                        .frame(width: 18, height: 18)
                    Text("搜索Motion")
                } .foregroundColor(.mt.gray_500)
                )
        }, leading: {
            Button {
                fullscreen.showFullScreen(type: .profile)
            } label: {
                Circle()
                    .foregroundColor(Color.random)
                    .frame(width: 36, height: 36)
            }
       
        }, trailing: {
            Button(
                action: {},
                label: {
                    Image
                        .mt.load(.Setting)
                        .foregroundColor(.mt.gray_900)
                }
            )
        })
    }
}


struct FindView_Previews: PreviewProvider {
    static var previews: some View {
        FindView()
    }
}
