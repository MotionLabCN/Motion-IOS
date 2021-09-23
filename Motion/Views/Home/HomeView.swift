//
//  HomeView.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/15.
//

import SwiftUI
import MotionComponents


//MARK: - 首页
struct HomeView: View {
    
    @StateObject var vm = PostVM()
    
    @State private var isShowPlaceholder = true
    @EnvironmentObject var fullscreen: AppState.TopFullScreenPage


    
    var body: some View {
        
        
        ScrollView {
            LazyVStack(spacing: 0.0) {
                Spacer.mt.navbar()
                header
                Divider.mt.defult()
                if isShowPlaceholder {
                    placeholder
                        .padding(.top, 150)
                } else {
                    main
                }
            }
        }
        .mtNavbar(content: {
            Image.mt.load(.Logo)
                .resizable()
                .frame(size: .init(width: 33, height: 33))
        }, leading: {
            MTLocUserAvatar()
        }
                  , trailing: {
            Image.mt.load(.Map_place)
        })
        .mtAttatchTabbarSpacer()
       

        
    }
}

extension HomeView {
    var header: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack(spacing: 20, content: {
                ForEach(1...100, id: \.self) { count in
                    HomeHeaderItemView()
                }
            })
                .padding()
        })
    }
    
    var main: some View {
        LazyVStack {
            ForEach(1...119, id: \.self) { count in
                
                Button(action: {
                    withAnimation(.easeInOut) {
                        //                        fullscreen.showCustomFullScreen(view: FullScreenView(view: AnyView( PostDetailView())))
                        fullscreen.showCustomFullScreen {
                            PostDetailView()
                        }
                    }
                }){
                    PostCell()
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                }
                .mtTapAnimation(style: .rotation3D)
                
                
                
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    var placeholder: some View {
        VStack(spacing: 20) {
            MTDescriptionView(title: "尚未连接任何人", subTitle: "Motion是创造者们加速他们伟大创造的地方。科技、艺术、制造业工作者们在这里见面，组成协作小队。")
            Button(action: {
//                isShowPlaceholder.toggle()

            }, label: {
                Text("查找朋友")
                    .mtButtonLabelStyle(.mainDefult())
                    .frame(width: 125)
                    .background(
                        Color.mt.accent_700.clipShape(Capsule())
                    )
            })
                .mtTapAnimation(style: .overlayOrScale())
            
        }
    }
    
}





struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


