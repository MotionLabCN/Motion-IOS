//
//  FindViewTopTabBar.swift
//  FindViewTopTabBar
//
//  Created by Liseami on 2021/9/16.
//

import SwiftUI
import MotionComponents

struct FindViewTopTabBar: View {
    
    @Binding var offset : CGFloat
    @State var width : CGFloat = 0
    
    var body: some View {
        
        GeometryReader { proxy -> AnyView in
            let itemWidth = proxy.frame(in: .global).width / CGFloat(findViewTabs.count)
            DispatchQueue.main.async {
                self.width = itemWidth
            }
            return AnyView(
                ZStack(alignment: .bottomLeading) {
                    BlurView()
                    Capsule()
                        .frame(width: itemWidth - 16, height: 4)
                        .foregroundColor(.mt.accent_600)
                        .offset(x: getOffset() + 8 , y: 0)
                    HStack(spacing:0){
                        ForEach(findViewTabs.indices,id:\.self) {index in
                            Text("\(findViewTabs[index])")
                                .font(.mt.body1.mtBlod())
                                .foregroundColor( getIndexFromOffset() == index ? .black :  .mt.gray_700)
                                .frame(width: itemWidth , alignment: .center)
                        }
                    }
                    .frame(maxWidth : .infinity ,maxHeight: 44, alignment: .leading)
                }
            )
        }
        .frame( height: 44)
    }
    
    func getOffset() -> CGFloat {
        let progress = offset / ScreenWidth()
        return progress * width
    }
    func getIndexFromOffset() -> Int {
        let indexFloat = offset / ScreenWidth()
        return Int(indexFloat.rounded(.toNearestOrAwayFromZero))
    }
}

struct FindViewTopTabBar_Previews: PreviewProvider {
    static var previews: some View {
        FindViewTopTabBar(offset: .constant(0))
    }
}