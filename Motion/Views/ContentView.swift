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
    
    var body: some View {
        NavigationView {
            ZStack {
                routerView
                
                main
               
                tabbar
            }
            .navigationBarHidden(true)
        }
    }
   
}

//MARK: - body
extension ContentView {
    var routerView: some View {
        Group {
            NavigationLink(
                destination: HomeSecondView(),
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
    
    
    var main: some View {
        NavigationView {
            Group {
                switch tabbarObj.selectedKind {
                case .home:
                    HomeView()
                case .search:
                    Text("2")
                case .team:
                    Text("3")

                case .message:
                    Text("4")
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    @ViewBuilder
    var tabbar: some View {
        if tabbarObj.isShowTabbar {
            VStack {
                Spacer(minLength: 0)
                
                MTTabbar(selectedKind: $tabbarObj.selectedKind)
                    .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .opacity))
                    .background(Color.white.ignoresSafeArea(edges: .bottom))
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
            Divider().opacity(0.3)
            HStack(spacing: 1.0, content: {
                ForEach(Kind.allCases) { kind in
                    Button(action: {
                        withAnimation {
                            selectedKind = kind
                        }
                    }, label: {
                        kind.image
                            .foregroundColor(selectedKind == kind ? .mt.accent_700 : .mt.gray_800)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    })
                    .mtAnimation(isOverlay: false)
                }
                
            })
        }
        .frame(height: TabbarHeight)
    }
    
}














































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppState.TabbarState())
            .previewDevice("iPhone 12")
    }
}
