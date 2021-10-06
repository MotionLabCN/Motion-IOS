//
//  MTTabBar.swift
//  MotionDesgin
//
//  Created by 梁泽 on 2021/10/6.
//

import SwiftUI


//MARK: - 自定义的tabbar
struct MTTabBar: View {
    let tabs: [MTTabKind]
    @Binding var selection: MTTabKind
    
    var body: some View {
        VStack(spacing:0){
            Divider.mt.defult()
            
            HStack(spacing: 20, content: {
                ForEach(tabs, id: \.self) { kind in
                    Button(action: {
                        withAnimation {
                            selection = kind
                        }
                    }, label: {
                        kind.image
                        //                            .mtAddBadge(number: 2, isShow: true)
                            .foregroundColor(selection == kind ? .mt.accent_700 : .mt.gray_800)
                            .frame(maxWidth: .infinity)
                            .frame(height: 49)
//                            .padding(.vertical, 9)
                            .contentShape(Rectangle())
                    })
                    .mtTapAnimation(style: .overlayOrScale(isOverlay: false, scale: 0.7))
                }
            })
        }
        .background(
            Color.white
                .ignoresSafeArea(edges: .bottom)
        )

    }
}


struct MTTabBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            
            MTTabBar(tabs: MTTabKind.allCases, selection: .constant(.home))
        }
        
    }
}
