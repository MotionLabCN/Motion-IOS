//
//  CustomTabbarContainerView.swift
//  MotionDesgin
//
//  Created by 梁泽 on 2021/10/6.
//

import SwiftUI


public extension View {
    func mtTabbarItem(tab: MTTabKind, selection: Binding<MTTabKind>) -> some View {
        modifier(MTTabBarViewModifier(tab: tab, selection: selection))
    }
}


//MARK: - tabbar类型
public enum MTTabKind: CaseIterable {
    case home, search, storage
    
    var image: Image {
        switch self {
        case .home: return .mt.load(.Home)
        case .search: return .mt.load(.Search)
        case .storage: return .mt.load(.Pie_chart)
//        case .team: return .mt.load(.Group)
        }
    }
}


//MARK: - 自定义TabView
public struct MTTabView<Content: View>: View {
    
    @Binding var selection: MTTabKind
    var isShowTabbar: Bool
    let content: Content
    @State private var tabs: [MTTabKind] = []
    
    public init(selection: Binding<MTTabKind>, isShowTabbar: Bool = true, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.isShowTabbar = isShowTabbar
        self.content = content()
    }
    
    public var body: some View {
        if #available(iOS 15.0, *) {
            ZStack{
                content
            }
                .safeAreaInset(edge: .bottom) {
                    if isShowTabbar {
                        MTTabBar(tabs: tabs, selection: $selection)
                            .transition(.asymmetric(insertion: .move(edge: .bottom).combined(with: .opacity), removal: .opacity))
                    }
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
                .onPreferenceChange(MTTabBarItemsPreferenceKey.self) { value in
                    tabs = value
                }
        } else {
            VStack(spacing: 0) {
                Spacer(minLength: 0)
                ZStack {
                    content
                }
                Spacer(minLength: 0)
                // tabbar
                if isShowTabbar {
                    MTTabBar(tabs: tabs, selection: $selection)
                        .transition(.asymmetric(insertion: .move(edge: .bottom).combined(with: .opacity), removal: .opacity))
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .onPreferenceChange(MTTabBarItemsPreferenceKey.self) { value in
                tabs = value
            }
        }
    }
}



//MARK: - PreferenceKey 外部传tabs
private struct MTTabBarItemsPreferenceKey: PreferenceKey {
    static var defaultValue: [MTTabKind] = []
    
    static func reduce(value: inout [MTTabKind], nextValue: () -> [MTTabKind]) {
        value += nextValue()
    }
}


private struct MTTabBarViewModifier: ViewModifier {
    let tab : MTTabKind
    @Binding var selection: MTTabKind
    
    func body(content: Content) -> some View {
        content
            .opacity(selection == tab ? 1 : 0)
            .preference(key: MTTabBarItemsPreferenceKey.self, value: [tab])
    }
    
}






//MARK: - PreviewProvider
struct MTTabView_pre: PreviewProvider {
    struct TestView: View {
        @State  private var selection = MTTabKind.home
        var body: some View {
            MTTabView(selection: $selection, content: {
                Color.random
                    .mtTabbarItem(tab: .home, selection: $selection)
                
                Color.random
                    .mtTabbarItem(tab: .search, selection: $selection)
                
                Color.random
                    .mtTabbarItem(tab: .storage, selection: $selection)
                
//                Color.random
//                    .mtTabbarItem(tab: .team, selection: $selection)
                
            })
        }
    }

    static var previews: some View {
        Group {
            VStack {
                Spacer()
                
                MTTabBar(tabs: MTTabKind.allCases, selection: .constant(.home))
            }
            .previewLayout(.fixed(width: ScreenWidth(), height: 100))
            
            TestView()

        }
        
    }
}


