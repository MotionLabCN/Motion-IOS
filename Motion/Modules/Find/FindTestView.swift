//
//  FindView.swift
//  FindView
//
//  Created by Liseami on 2021/9/16.
//

import SwiftUI
import MotionComponents

//public var findViewTabs = ["码力","开源","热门","天梯","公司"]

struct FindTestView: View {
    
    @EnvironmentObject var findView: AppState.FindViewState
    
    @State var offset : CGFloat = 0
    var body: some View {
      
        
        VStack(spacing:0){
                
            MTPageSegmentView(titles: findViewTabs, offset: $offset)
            
            MTPageScrollView(count: findViewTabs.count, offset: $offset) {
                Group {
                    CodepowerView()
                    OpenSourceLibrary()
                    RecommendView()
                    Ladder()
                    RecommendView()
                }
                .frame(width: ScreenWidth())
                
            }
                //TOP Tabbar

//                topTabbar
//
//               //findViews
//
//                findViews
//                    .offset(x:getOffset())
//                    .highPriorityGesture(gesture)
                
        }
        .frame(width: ScreenWidth())
        .mtNavbar(content: {
            Capsule().frame(width: 255, height: 32)
                .foregroundColor(.mt.gray_200)
                .overlay(HStack{
                    Image.mt.load(.Search)
                        .frame(width: 16, height: 16)
                    Text("搜索Motion")
                        .font(.mt.body3 )
                } .foregroundColor(.mt.gray_500)
                )
        }, leading: {
            MTLocUserAvatar()
        }, trailing: {
            SettingBtn()
        })
        .navigationBarTitleDisplayMode(.inline)
     
        
    }
    
   
 
    
}


struct FindTestView_Previews: PreviewProvider {
    static var previews: some View {
        FindTestView()
    }
}
