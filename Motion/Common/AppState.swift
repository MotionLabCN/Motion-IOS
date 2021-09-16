//
//  AppState.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/14.
//

import Combine


struct AppState {
    class TabbarState: ObservableObject {
        @Published var selectedKind = MTTabbar.Kind.home
        @Published var isShowTabbar = true
        
    }
    ///顶层router表
    class TopRouterTable: ObservableObject {
        @Published var linkurl = false
        @Published var messageDetail = false

    }
    
    ///顶层Fullscreen表
    class TopFullScreenPage: ObservableObject {
        @Published var showProfile = false
    }
}
