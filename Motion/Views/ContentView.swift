//
//  ContentView.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/6.
//

import SwiftUI
import MotionComponents

struct ContentView: View {
    init() {
        UITabBar.appearance().isHidden = true
    }
        
    @EnvironmentObject var tabbarState: AppState.TabbarState
    @EnvironmentObject var router: AppState.TopRouterTable
    @EnvironmentObject var userManager: UserManager
    
    

    var body: some View {
        NavigationView {
            if userManager.hasLogin {
                ZStack {
                    routerView

                    main

                    tabbar

                    actionCricleBtn
                        
                }
                .navigationBarHidden(true)
            } else {
                LoginStartView()
                    .transition(.move(edge: .leading))
            }
        }
//        if userManager.hasLogin {
//            NavigationView {
//                ZStack {
//                    routerView
//
//                    main
//
//                    tabbar
//
//                    actionCricleBtn
//                        .opacity(tabbarState.isShowActionCricleBtn ? 1 : 0)
//                }
//                .navigationBarHidden(true)
//            }
//        } else {
//            LoginStartView()
//                .transition(.move(edge: .leading))
////                .animation(.easeInOut(duration: 5))
//        }
       
    }
    
}



//MARK: - body
extension ContentView {
    var routerView: some View {
        Group {
            NavigationLink(
                destination: Text("待完善"),
                isActive: $router.linkurl,
                label: {
                    EmptyView()
                })
            
            NavigationLink(
                destination: Text("顶级导航后"),
                isActive: $router.messageDetail,
                label: {
                    EmptyView()
                })
        }
    }
    
    
    var actionCricleBtn: some View {
        VStack {
            Spacer()
            HStack{
                Spacer()
                Button {
                    userManager.logout()
                } label: {
                    Image.mt.load(.Add)
                        .foregroundColor(.white)
                }
                .mtButtonStyle(.cricleDefult(.mt.accent_700))
                    .offset(y : -TabbarHeight - 16 )
            }
        }
        .padding(.horizontal,16)
        .opacity(tabbarState.isShowActionCricleBtn ? 1 : 0)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    var main: some View {
        NavigationView {
            Group {
                switch tabbarState.selectedKind {
                case .home:
                    HomeView()
                        .navigationBarHidden(true)
                case .search:
                    FindView()
                case .team:
                    TeamView()
                case .message:
                    NotificationView()
                }
            }
        }
        
        
        
        
    }
    
    @ViewBuilder
    var tabbar: some View {
        if tabbarState.isShowTabbar {
            VStack {
                Spacer(minLength: 0)
                MTTabbar(selectedKind: $tabbarState.selectedKind)
                    .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .opacity))
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
}








//MARK: - Tabbar
struct MTTabbar: View {
    enum Kind: String, CaseIterable, Identifiable {
        var id: String { rawValue }
        case home, search, team, message
        
        var image: Image {
            switch self {
            case .home: return .mt.load(.Home)
            case .search: return .mt.load(.Search)
            case .team: return .mt.load(.Group)
            case .message: return .mt.load(.Mail)
            }
        }
    }
    
    @Binding var selectedKind: Kind
    
    var body: some View {
        VStack(spacing:0){
            Divider.mt.defult()
            
            HStack(spacing: 20, content: {
                ForEach(Kind.allCases) { kind in
                    Button(action: {
                        withAnimation {
                            selectedKind = kind
                        }
                    }, label: {
                        kind.image
//                            .mtAddBadge(number: 2, isShow: true)
                            .foregroundColor(selectedKind == kind ? .mt.accent_700 : .mt.gray_800)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .contentShape(Rectangle())
                    })
                        .mtTapAnimation(style: .overlayOrScale(isOverlay: true, scale: 0.7))
                }
            })
        }
        .frame(height: TabbarHeight)
        .background(
            Color.white
                .ignoresSafeArea(edges: .bottom)
        )

    }
    
}














































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppState.TabbarState())
            .environmentObject(AppState.TopRouterTable())
            .previewDevice("iPhone 12")
    }
}


