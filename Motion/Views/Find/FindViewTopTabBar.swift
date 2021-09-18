//
//  FindViewTopTabBar.swift
//  FindViewTopTabBar
//
//  Created by Liseami on 2021/9/16.
//

import SwiftUI
import MotionComponents

struct FindViewTopTabBar: View {
    
    @Binding var tag: String
    
    @Namespace var namespace
    let items: [String]
    var itemWidth: CGFloat { ScreenWidth() / CGFloat(items.count) }
    
    let capsuleSize = CGSize(width: 56, height: 3)
    
    
    var body: some View {
        HStack(spacing:0){ //hstack begin
            ForEach(items, id: \.self) {item in
                ZStack(alignment: .bottom) {
                    Text("\(item)")
                        .foregroundColor( tag == item ? .black :  .mt.gray_700)
                        .mtAddBadge(number: 9, isShow: true)
                        .font(.mt.body1.mtBlod())
                        .frame(width: itemWidth)
                        .frame(height: 44)
                        .onTapGesture {
                            withAnimation {
                                tag = item
                            }
                        }
                    
                    if tag == item {
                        Capsule()
                            .matchedGeometryEffect(id: "Capsule", in: namespace)
                            .foregroundColor(.mt.accent_700)
                            .frame(width: capsuleSize.width ,height: capsuleSize.height, alignment: .center)
                    }
                }
            }
        } // hstack end
        .frame(maxHeight: 44)
        .background(BlurView())
        .animation(.default)
        
    }
    
    @ViewBuilder
    var old_body: some View {
        
        
        let itemWidth = ScreenWidth() / CGFloat(items.count)
        let capsuleSize = CGSize(width: 56, height: 3)
        
        HStack(spacing:0){
            ForEach(items, id: \.self) {item in
                ZStack{
                    BlurView()
                    Text("\(item)")
                        .foregroundColor( tag == item ? .black :  .mt.gray_700)
                        .mtAddBadge(number: 9, isShow: true)
                        .font(.mt.body1.mtBlod())
                        .onTapGesture {
                            withAnimation {tag = item}
                        }
                    
                    if tag == item {
                        VStack{
                            Spacer()
                            Capsule()
                                .matchedGeometryEffect(id: "Capsule", in: namespace)
                                .foregroundColor(.mt.accent_700)
                                .frame(width: capsuleSize.width ,height: capsuleSize.height, alignment: .center)
                        }
                    }
                    VStack{
                        Spacer()
                        Divider().mt.base
                    }
                }
                .frame(width: itemWidth , alignment: .center)
            }
        }
        .frame(maxWidth : .infinity ,maxHeight: 44, alignment: .leading)
        .animation(.default)
    }
}


//
////MARK: 调整按钮位置至屏幕角落
//public struct MTWhereMoveToViewModifier : ViewModifier {
//    enum edge {
//        case centerLeading
//        case centerTrailing
//        case topCenter
//        case bottomCenter
//        case topLeading
//        case topTrailing
//        case bottomLeading
//        case bottomTrailing
//    }
//    var WhereMoveTo : edge
//    
//    public func body(content: Content) -> some View {
//        switch WhereMoveTo {
//        case .centerLeading :
//            HStack(alignment: .center) {content;Spacer()}
//        case .centerTrailing:
//            HStack(alignment: .center) {Spacer();content}
//        case .topCenter:
//            VStack{content;Spacer()}
//        case .bottomCenter:
//            VStack{Spacer();content}
//        case .topLeading:
//            VStack{HStack{content;Spacer()};Spacer()}
//        case .topTrailing:
//            VStack{HStack{Spacer();content};Spacer()}
//        case .bottomLeading:
//            VStack{Spacer();HStack{content;Spacer()}}
//        case .bottomTrailing:
//            VStack{Spacer();HStack{Spacer();content}}
//        }
//    }
//}
//
//extension View{
//    func MoveTo( _ edge : MTWhereMoveToViewModifier.edge ) -> some View{
//        modifier(MTWhereMoveToViewModifier(WhereMoveTo: edge))
//    }
//}
//
