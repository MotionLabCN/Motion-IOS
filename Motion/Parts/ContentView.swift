//
//  ContentView.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/6.
//

import SwiftUI
import MotionComponents

struct ContentView: View {
    @EnvironmentObject var tabbarState: TabbarState
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        if userManager.hasLogin {
            //主页
            ZStack {
                VStack(spacing: 0) {
                    main
//                    if tabbarState.isShowTabbar {
//                        MTTabbar(selectedKind: $tabbarState.selectedKind)
//                            .transition(.move(edge: .bottom))
//                    }
                }
                
                VStack {
                    Spacer()
                    
                    if tabbarState.isShowTabbar {
                        MTTabbar(selectedKind: $tabbarState.selectedKind)
                            .transition(.move(edge: .bottom))
                    }
                }
                
                if tabbarState.selectedKind != .search && tabbarState.selectedKind != .storage{
                    MTAddPostView()
                }
            }
        }else{
            //登陆
            NavigationView {
                LoginStartView()
            }
            .transition(.move(edge: .leading).combined(with: .opacity))
        }
    }
    
    var main: some View {
        
        TabView(selection: $tabbarState.selectedKind) {
            NavigationView {
                HomeView()
            }
            .tag(MTTabbar.Kind.home)
            
            NavigationView {
                FindView()
//               FindView()
            }
            .tag(MTTabbar.Kind.search)
            
            NavigationView {
                NewStorageView()
            }
            .tag(MTTabbar.Kind.storage)
            
//            NavigationView {
//
//                TeamView()
//            }
//            .tag(MTTabbar.Kind.team)
        }
        
    }
}


//MARK: - Tabbar
struct MTTabbar: View {
    enum Kind: String, CaseIterable, Identifiable {
        var id: String { rawValue }
        case home, search, storage
        
        var image: Image {
            switch self {
            case .home: return .mt.load(.Home)
            case .search: return .mt.load(.Search)
            case .storage: return .mt.load(.Pie_chart)
//            case .team: return .mt.load(.Group)
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
            MTBarBackgorundView()
        )
        
    }
    
}














































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TabbarState())
            .environmentObject(UserManager())
            .previewDevice("iPhone 12")
    }
}


