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
    @State private var selectedPost : PostItemModel? = nil
    
    @State private var isShowToast = false
    @State private var toastText = ""

    @EnvironmentObject var tabbarState: TabbarState
    
    

    init() {
//        print("HomeView init")
    }

    
    var body: some View {
        
        if vm.list.isEmpty && vm.requestPostListStatus.isRequesting { // 请求中
            VStack {
                Spacer()
                
                ProgressView()
                    .mt(style: .mid)
                
                Spacer()
            }
        } else {
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
    //                  , trailing: {
    //            NavigationLink {
    //                NoticeListView()
    //            } label: {
    //                Image.mt.load(.Mail)
    //             .foregroundColor(.mt.gray_800)
    //            }
    //        }
            )
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

            .mtFullScreenCover(item: $selectedPost, content: { item in
                BlurView(style: .systemChromeMaterialDark).ignoresSafeArea()
                PostDetailView(inputPost: item)
            })
        
        
            .mtToast(isPresented: $isShowToast, text: toastText, postion: .bottom(offsetY: 86))
            
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
                    selectedPost = item
                }){
                    PostCell(model: item, didAlert:  {
                        toastText = "举报成功，稍后人工客服会和您联系"
                        isShowToast = true
                    })
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
                vm.refresh()

                
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


