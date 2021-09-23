//
//  PostDetailView.swift
//  Motion
//
//  Created by Liseami on 2021/9/22.
//

import SwiftUI
import MotionComponents

struct PostDetailView: View {
    @EnvironmentObject var fullscreen: AppState.TopFullScreenPage
    
  
    var body: some View {
        
        ZStack{
            imageTabview
            
            posttext
            
            topToolBar
            
            bottomInfoBar
        }
        .transition(.move(edge: .bottom).animation(.linear))
    }
  
    
    
    
    
    
    
    
    
    
    
    
    func getAngle (proxy : GeometryProxy) -> Angle{
        let progress = proxy.frame(in: .global).minX / proxy.size.width
        let rotationAngle = CGFloat(45)
        let degress = rotationAngle * progress
        let result = Angle(degrees: Double(degress))
        return result
    }
    
    
    var imageTabview : some View {
        
        TabView {
            ForEach(0..<4){index in
                postImage.tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(maxWidth : .infinity,maxHeight : .infinity)
    }
    
    
    var postImage : some View {
        
        GeometryReader { proxy in
            ZStack{
                VStack{
                    Image("touxiang")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .frame(minWidth: ScreenWidth(),maxHeight: (ScreenHeight() - SafeBottomArea() - StatusBarH() - 68),alignment: .center)
                    Spacer()
                }
            }
            .rotation3DEffect(getAngle(proxy: proxy),
                              axis: (x: 0, y: 0.5, z: 0), anchor: proxy.frame(in: .global).minX > 0 ? .leading : .trailing,
                              perspective: 2.5)
        }
    }
    
    var posttext : some View {
        VStack{
            Spacer()
            Text("5 月 5 日星期三，序列号 15（SN15）的 Starship 成功完成了 SpaceX 对来自德克萨斯州 Starbase 的 Starship 原型机的第五次高空飞行测试。")
                .font(.mt.body2,textColor: .white)
        }
        .padding(.bottom, SafeBottomArea() + 32)
        .padding()
    }
    
    
    
    var bottomInfoBar : some View{
        VStack{
            Spacer()
            HStack{
                Image("touxiang")
                    .resizable()
                    .frame(width: 36, height: 36)
                    .clipShape(Capsule(style: .continuous))
                    .foregroundColor(Color.random)
                VStack(alignment: .leading,spacing:4){
                    Text("小梁同学")
                        .font(.mt.body2.mtBlod(),textColor: .white)
                    Text("@Xiaoliangtongxue")
                        .font(.mt.caption2,textColor: .mt.gray_100)
                }
                Spacer()
                bottomToolBar
            }
        }.padding()
    }
    
    //
    var topToolBar : some View{
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text("7月20日 ")
                        .font(.mt.caption1.mtBlod(),textColor: .white)
                    +
                    Text("2021")
                        .font(.mt.caption1,textColor: .mt.gray_100)
                    Text("11:09")
                        .font(.mt.caption2,textColor: .mt.gray_100)
                }
                Spacer()
                Image.mt.load(.More_horiz)
                    .foregroundColor(.white)
                Button(action: {
                    withAnimation(.easeInOut){
                        fullscreen.showCustom.toggle()
                    }
                }){
                    Image.mt.load(.Close)
                        .foregroundColor(.white)
                }
            }
            Spacer()
        }
        .padding()
    }
    
    //
    var bottomToolBar : some View{
        HStack(alignment:.center,spacing:12){
            Button(action: {
            }, label: {
                HStack {
                    Image.mt.load(.Comment)
                        .mtSize(18, foregroundColor: .white)
                    Text("12")
                        .font(.mt.caption1, textColor: .mt.gray_100)
                }
            })
            
            Button(action: {
            }, label: {
                HStack {
                    Image.mt.load(.Cached)
                        .mtSize(18, foregroundColor: .white)
                    Text("34")
                        .font(.mt.caption1, textColor: .mt.gray_100)
                }
            })
            Button(action: {
                
            }, label: {
                HStack {
                    Image.mt.load(.Penny)
                        .mtSize(18, foregroundColor: .white)
                    
                    Text("77")
                        .font(.mt.caption1, textColor: .mt.gray_100)
                }
            })
        }
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView()
    }
}


