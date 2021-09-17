//
//  NotificationView.swift
//  NotificationView
//
//  Created by Liseami on 2021/9/15.
//

import SwiftUI
import MotionComponents

struct NotificationView: View {
    var body: some View {
    
        TabView {
//            switch item {
//            case 0 :
                //推荐
                RecommendView()
//            case 1 :
//                //名人
                Color.random
//                    .frame(width: ScreenWidth() , height: ScreenHeight())
//            case 2 :
                //天梯
                Color.random
//                    .frame(width: ScreenWidth() , height: ScreenHeight())
//            case 3 :
                //前沿
                Color.random
//                    .frame(width: ScreenWidth() , height: ScreenHeight())
//            case 4 :
                //趋势
                Color.random
//            default:
//                EmptyView()
//                    .frame(width: ScreenWidth() , height: ScreenHeight())
//            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
