//
//  PostDetailView.swift
//  Motion
//
//  Created by Liseami on 2021/9/22.
//

import SwiftUI
import MotionComponents
import Kingfisher

struct PostDetailView: View {
    
    @Environment(\.presentationMode) var persentationMode
 
    let inputPost: PostItemModel
  
    @StateObject var vm = PostDetailVM()
    
    var body: some View {
        
        ZStack{
            imageTabview
            
            posttext
            
            topToolBar
            
            bottomInfoBar
        }
        .transition(.move(edge: .bottom).animation(.linear))
        
        .onAppear {
            vm.getDetail(inputPost)
        }
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
            ForEach(0..<vm.model.pics.count){index in
                //PostImage
                GeometryReader { proxy in
                    ZStack{
                        VStack{
                            KFImage(URL(string: vm.model.pics[index]))
                                .resizable()
                                .placeholder({Color.mt.gray_400})
                                .scaledToFill()
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
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(maxWidth : .infinity,maxHeight : .infinity)
    }
    
  
    
    var posttext : some View {
        VStack{
            Spacer()
            Text(vm.model.content)
                .font(.mt.body2,textColor: .white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
        }
        .padding(.bottom, SafeBottomArea() + 32)
        .padding()
    }
    
    
    
    var bottomInfoBar : some View{
        VStack{
            Spacer()
            HStack{
                MTAvatar(frame: 36, urlString: nil) {
                    
                }
                VStack(alignment: .leading,spacing:4){
                    Text(vm.model.userVO.username)
                        .font(.mt.body2.mtBlod(),textColor: .white)
                    Text("\(vm.model.userVO.nickname)")
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
                    Text(vm.model.createDate)
                        .font(.mt.caption1.mtBlod(),textColor: .white)
//                    +
//                    Text("2021")
//                        .font(.mt.caption1,textColor: .mt.gray_100)
//                    Text("11:09")
//                        .font(.mt.caption2,textColor: .mt.gray_100)
                }
                Spacer()
                Image.mt.load(.More_horiz)
                    .foregroundColor(.white)
                Button(action: {
                  persentationMode.wrappedValue.dismiss()
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
                    Text("\(Int.random(in: 10...30))")
                        .font(.mt.caption1, textColor: .mt.gray_100)
                }
            })
            
            Button(action: {
            }, label: {
                HStack {
                    Image.mt.load(.Cached)
                        .mtSize(18, foregroundColor: .white)
                    Text("\(Int.random(in: 10...30))")
                        .font(.mt.caption1, textColor: .mt.gray_100)
                }
            })
            Button(action: {
                
            }, label: {
                HStack {
                    Image.mt.load(.Penny)
                        .mtSize(18, foregroundColor: .white)
                    
                    Text("\(Int.random(in: 10...30))")
                        .font(.mt.caption1, textColor: .mt.gray_100)
                }
            })
        }
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(inputPost: .init())
    }
}


