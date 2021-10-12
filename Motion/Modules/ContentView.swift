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
    @EnvironmentObject var findViewState: FindViewState
    
    @GestureState var move : CGSize = .zero
    @State private var isShowLeadingMenu : Bool = false
    
    func getOffset() -> CGFloat {
        let SW = ScreenWidth()
        if !isShowLeadingMenu {
            return -0.4 * SW + move.width
        }else{
            return 0.4 * SW + move.width
        }
    }
    
    var body: some View {
        

        if userManager.hasLogin {
            //主页
                mainViews
        }else{
            //登陆
            NavigationView {
                LoginStartView()
            }
            .transition(.move(edge: .leading).combined(with: .opacity))
        }
    }
    
}



//MARK: - body
extension ContentView {
    
    var mainViews : some View {
        GeometryReader { pox in
            let progress = pox.frame(in: .global).minX / ScreenWidth() * 0.8
            NavigationView {
                ZStack {                    
                    main
                    
                    tabbar
                    
                    if tabbarState.selectedKind != .search && tabbarState.selectedKind != .storage{
                        actionCricleBtn
                    }
                    
                    Color.black.opacity(progress * 0.3)
                        .disabled(isShowLeadingMenu)
                        .ignoresSafeArea()
                        .onTapGesture {isShowLeadingMenu.toggle()}
                }
                .navigationBarHidden(true)
            }
        }.frame(width: ScreenWidth())
        
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
            ZStack {
                HomeView()
                    .opacity(tabbarState.selectedKind == .home ? 1: 0)
                
                if tabbarState.selectedKind == .search {
                    FindView()
//                    FindTestView()
                }
                
                if tabbarState.selectedKind == .storage {
                    StorageView()
                }
                
                if tabbarState.selectedKind == .team {
                    TeamView()
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
        case home, search, storage, team
        
        var image: Image {
            switch self {
            case .home: return .mt.load(.Home)
            case .search: return .mt.load(.Search)
            case .storage: return .mt.load(.Pie_chart)
            case .team: return .mt.load(.Group)
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


