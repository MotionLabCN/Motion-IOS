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
        
    @EnvironmentObject var tabbarObj: AppState.TabbarState
    @EnvironmentObject var router: AppState.TopRouterTable
    @EnvironmentObject var fullscreen: AppState.TopFullScreenPage
    
    var body: some View {
        NavigationView {
            ZStack {
                routerView
                
                main
               
                tabbar
                
                actionCricleBtn
            }
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $fullscreen.showProfile) {
                ProfileView()
            }
        }
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
                } label: {
                    Image.mt.load(.Add)
                        .foregroundColor(.white)
                }.custom(.cricleDefult(.mt.accent_700))
                    .offset(y : -TabbarHeight - 16 )
            }
        }
        .padding(.horizontal,16)
    }
    
    var main: some View {
        NavigationView {
            Group {
                switch tabbarObj.selectedKind {
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
        if tabbarObj.isShowTabbar {
            VStack {
                Spacer(minLength: 0)
                
                MTTabbar(selectedKind: $tabbarObj.selectedKind)
                    .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .opacity))

            }
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
                            .foregroundColor(selectedKind == kind ? .mt.accent_700 : .mt.gray_800)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .contentShape(Rectangle())
                    })
                    .mtAnimation(isOverlay: false, scale: 0.7)
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
