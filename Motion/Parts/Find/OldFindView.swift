//
//  FindView.swift
//  FindView
//
//  Created by Liseami on 2021/9/16.
//

import SwiftUI
import MotionComponents



struct OldFindView: View {
    
    
    @EnvironmentObject var findView: FindViewState
    @State private var offset : CGFloat = 0.0
    @GestureState var move : CGFloat = 0
    
    let pageNumbers = 4
 
    func getOffset() -> CGFloat {
        let HStackWidth  = CGFloat(self.pageNumbers) * ScreenWidth()
        let base = (HStackWidth  - ScreenWidth()) / 2
        let result = base + move - CGFloat(findView.pageIndex ) * ScreenWidth()
        return result
    }
    
    @State private var isgotonext = false
    var body: some View {
        
        let gesture = DragGesture(minimumDistance: 15, coordinateSpace: .global)
            .updating($move, body: { value,out, transition in
                let width = value.translation.width
                if width < 0 && findView.pageIndex  != (pageNumbers - 1) {
                    out = width
                }
                if width > 0 && findView.pageIndex  != 0 {
                    out = width
                }
            })
            .onEnded { value in
                let width = value.translation.width
                if width > ScreenWidth() * 0.3 {
                    guard findView.pageIndex  > 0 else {return}
                    findView.pageIndex  -= 1
                }
                if width < -ScreenWidth() * 0.3 {
                    guard findView.pageIndex  < (pageNumbers - 1) else {return}
                    findView.pageIndex  += 1
                }
            }
        
        
            VStack(spacing:0){
        
                //TOP Tabbar

                topTabbar
                
               //findViews
                
                findViews
                    .offset(x:getOffset())
                    .highPriorityGesture(gesture)
                
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
    
    @ViewBuilder
    var findViews : some View {
        HStack(spacing:0){
            OpenSourceLibrary()
            RecommendView()
            Ladder()
            RecommendView()
            //写法需要优化一下，但是这样减少了很多卡顿。否则一次性加载4个页面。
            CodepowerView()
            Ladder()
            OpenSourceLibrary()
            RecommendView()
//            RecommendView()
//            OfficialBusiness()
        }
        .mtAnimation(.linear(duration: 0.2))
        .frame(width: CGFloat(pageNumbers) * ScreenWidth())
      
     
    }
    
    @ViewBuilder
    var topTabbar : some View {
        
        HStack(spacing:0){
            ForEach(0 ..< pageNumbers) { index in
                    Text(findViewTabs[index])
                    .font(.mt.body1.mtBlod(),textColor: findView.pageIndex  == index ? .black : .mt.gray_700)
                        .frame(width: ScreenWidth() / CGFloat(findViewTabs.count) )
                        .frame(width: ScreenWidth() / CGFloat(pageNumbers), height: 44,alignment: .center)
                        .onTapGesture {
                            withAnimation {
                                findView.pageIndex  = index
                            }
                    }
            }
        }
        .frame(width: ScreenWidth())
        .overlay(
            ZStack {
                Divider()
                Capsule(style: .continuous)
                    .frame(width: ScreenWidth() / CGFloat(pageNumbers) - 24, height: 3)
                    .offset(x: -getOffset() / CGFloat(pageNumbers) )
                    .foregroundColor(Color.mt.accent_800)
                .animation(.spring())
            }
            , alignment: .bottom)
    }
 
    
}


struct FindView_Previews: PreviewProvider {
    static var previews: some View {
        OldFindView()
    }
}
