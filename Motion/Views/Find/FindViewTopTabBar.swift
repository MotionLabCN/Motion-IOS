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
    
    @Namespace var animation
    let items: [String]
    
    var body: some View {
        
        
        let itemWidth = ScreenWidth() / CGFloat(items.count)
        let capsuleSize = CGSize(width: 56, height: 3)
        
        HStack(spacing:0){
            ForEach(items, id: \.self) {item in
                ZStack{
                    BlurView()
                    Text("\(item)")
                        .foregroundColor( tag == item ? .black :  .mt.gray_700)
                        .addBadge(number: 9, show: true)
                        .font(.mt.body1.mtBlod())
                        .onTapGesture {withAnimation {tag = item}}
                

                    
                    if tag == item {
                        VStack{
                            Spacer()
                            Capsule()
                                .matchedGeometryEffect(id: "Capsule", in: animation)
                                .foregroundColor(.mt.accent_700)
                                .frame(width: capsuleSize.width ,height: capsuleSize.height, alignment: .center)
                        }
                        .animation(.easeInOut)
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



//MARK: 调整按钮位置至屏幕角落
public struct moveTo : ViewModifier {
    enum edge {
        case centerLeading
        case centerTrailing
        case topCenter
        case bottomCenter
        case topLeading
        case topTrailing
        case bottomLeading
        case bottomTrailing
    }
    var WhereMoveTo : edge
    
    public func body(content: Content) -> some View {
        switch WhereMoveTo {
        case .centerLeading :
            HStack(alignment: .center) {content;Spacer()}
        case .centerTrailing:
            HStack(alignment: .center) {Spacer();content}
        case .topCenter:
            VStack{content;Spacer()}
        case .bottomCenter:
            VStack{Spacer();content}
        case .topLeading:
            VStack{HStack{content;Spacer()};Spacer()}
        case .topTrailing:
            VStack{HStack{Spacer();content};Spacer()}
        case .bottomLeading:
            VStack{Spacer();HStack{content;Spacer()}}
        case .bottomTrailing:
            VStack{Spacer();HStack{Spacer();content}}
        }
    }
}

extension View{
    func MoveTo( _ edge : moveTo.edge ) -> some View{
        self.modifier(moveTo(WhereMoveTo: edge))
        
    }
}

extension View{
    func addBadge( number : Int , show : Bool) -> some View {
        self.overlay(
            Group{
                if show {
                    Circle()
                        .frame(width: 16,height: 16)
                        .foregroundColor(.mt.accent_700)
                        .overlay(Text("\(number)").font(.mt.caption2.mtBlod() , textColor: .white))
                        .offset(x:8,y:-8)
                        .MoveTo(.topTrailing)
                        .disabled(false)
                }else{
                     EmptyView().disabled(false)
                   }
            }
        )
    }
}
