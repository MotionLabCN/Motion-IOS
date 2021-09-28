//
//  FindView.swift
//  FindView
//
//  Created by Liseami on 2021/9/16.
//

import SwiftUI
import MotionComponents

public var findViewTabs = ["推荐","宝库","天梯","公司","服务"]

struct FindView: View {
    
    @EnvironmentObject var findView: AppState.FindViewState
    
    @State var offset : CGFloat = 0.0
    @GestureState var move : CGFloat = 0
    
    let pageNumbers = 5
 
    func getOffset() -> CGFloat {
        let HStackWidth  = CGFloat(self.pageNumbers) * ScreenWidth()
        let base = (HStackWidth  - ScreenWidth()) / 2
        let result = base + move - CGFloat(findView.pageIndex ) * ScreenWidth()
        return result
    }
    
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
                        .offset(x: -getOffset() / 5)
                        .foregroundColor(Color.mt.accent_800)
                    .animation(.spring())
                }
                , alignment: .bottom)
        
            
            HStack(spacing:0){
                RecommendView()
                OpenSourceLibrary()
                Ladder()
                RecommendView()
                OfficialBusiness()
            }
            .animation(.linear(duration: 0.2))
            .frame(width: CGFloat(pageNumbers) * ScreenWidth())
            .offset(x:getOffset())
            .highPriorityGesture(gesture)
    
            
            
        }
        .navigationBarHidden(true)
        .padding(.top,44)
        .navigationBarTitleDisplayMode(.inline)
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
        
    }
    
 
    
}


struct FindView_Previews: PreviewProvider {
    static var previews: some View {
        FindView()
    }
}

