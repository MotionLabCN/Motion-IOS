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
    
    @StateObject var vm = HomeVM.shared
    

    @State private var isShowmtsheet = false
    @State private var showDetail : Bool = false

    @EnvironmentObject var tabbarState: TabbarState

    init() {
        print("HomeView init")
    }

    
    var body: some View {
        
        
        ScrollView {
            LazyVStack(spacing: 0.0) {
//                header
//                Divider.mt.defult()
                if vm.list.isEmpty {
                    placeholder
                        .padding(.top, 150)
                } else {
                    main
                }
            }
            
            Spacer.mt.tabbar()
        }
        .mtNavbar(content: {
            Image.mt.load(.Logo)
                .resizable()
                .frame(size: .init(width: 33, height: 33))
        }, leading: {
            MTLocUserAvatar()
        }
                  , trailing: {
            NavigationLink {
                NoticeListView()
            } label: {
                Image.mt.load(.Mail)
             .foregroundColor(.mt.gray_800)
            }
        })
        .fullScreenCover(isPresented: .constant(false)) {
            EmptyView()
        }
        .onChange(of: tabbarState.selectedKind, perform: { newvalue in
            if newvalue == .home {
                print("home selected appear")
            }
        })
    
        .mtTabbarKindChange(hanlder: { kind in
            print("mtTabbarKindChange \(kind)")
        })
        
//        .mtRegisterRouter(isActive: $isShowmtsheet) {
//            MTWebView(urlString: "https://baidu.com")
//        }
        
        .mtSheet(isPresented: $isShowmtsheet, isCanDrag: true) {
                VStack {
                    Text("currentOffsetY)")
                    Text("currentOffsetY)")
                    Text("currentOffsetY)")
                    Text("currentOffsetY)")
                    Text("currentOffsetY)")
                    Text("currentOffsetY)")
                    Text("currentOffsetY)")

                    Button {
                        isShowmtsheet = false
                    } label: {
                        Text("关闭")
                    }
                }
        }

        .mtFullScreenCover(isPresented: $showDetail) {
            BlurView(style: .systemChromeMaterialDark).ignoresSafeArea()
            PostDetailView()
        }
        
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
            ForEach(vm.list) { item in
                Button(action: {
                    showDetail.toggle()
                }){
                    PostCell(model: item)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                }
                .mtTapAnimation(style: .rotation3D)
                
                Divider.mt.defult()
            }
            
        }
        .frame(maxWidth: .infinity)
        
    }
    
    
    var placeholder: some View {
        VStack(spacing: 20) {
            MTDescriptionView(title: "尚未连接任何人", subTitle: "Motion是创造者们加速他们伟大创造的地方。科技、艺术、制造业工作者们在这里见面，组成协作小队。")
            Button(action: {
                isShowmtsheet.toggle()
//                TabbarState.shared.isShowTabbar = false
               
//                Networking.request(OSSApi.upload(images: [UIImage(named: "touxiang")!, UIImage(named: "touxiang")!])) { result in
//                    print("")
//                }
                
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
    
//        .mtFullScreenCover(isPresented: $isShowmtsheet) {
//
//        } content: {
//            VStack {
//                Spacer()
//
//                Text("123")
//                    .frame(width: ScreenWidth(), height: 300)
//                    .background(Color.red)
//
//            }
//        }

       
        
    }
    
}





struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


