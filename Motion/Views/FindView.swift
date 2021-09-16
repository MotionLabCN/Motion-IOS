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
    @State var offset : CGFloat = 0.0
    var body: some View {
        GeometryReader { pox in
            let rect = pox.frame(in: .global)
            VStack(spacing:0){
                FindViewTopTabBar(offset: $offset)
                ScrollableTabbar(tabs: findViewTabs, rect: rect, offset: $offset) {
                    HStack(spacing:0){
                        Color.random.frame(width: ScreenWidth() , height: ScreenHeight())
                        Color.random.frame(width: ScreenWidth() , height: ScreenHeight())
                        Color.random.frame(width: ScreenWidth() , height: ScreenHeight())
                    }
                }
            }
        
        }
    }
}

struct FindView_Previews: PreviewProvider {
    static var previews: some View {
        FindView()
    }
}
