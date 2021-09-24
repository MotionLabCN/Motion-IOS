//
//  AppState.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/14.
//

import Combine
import Dispatch
import SwiftUI


struct AppState {
    /// tabbar状态管理
    class TabbarState: ObservableObject {
        static let shared = TabbarState()
        @Published var selectedKind = MTTabbar.Kind.home
        @Published var isShowTabbar = true
        @Published var isShowActionCricleBtn = true 
    
        func showTabbar(_ isShow: Bool, animationed: Bool = true) {
            if animationed {
                withAnimation {
                    self.isShowTabbar = isShow
                }
            } else {
                self.isShowTabbar = isShow
            }
        }
        
        /// 顶层的 圆形加号按钮
        func showActionCricleBtn(_ isShow: Bool) {
            withAnimation {
                self.isShowActionCricleBtn = isShow
            }
        }
        
        func hanlderSheetShow(_ isShowSheet: Bool) {
            showTabbar(!isShowSheet, animationed: true)
//            showActionCricleBtn(!isShowSheet)
        }
        
    }
    
    
    ///顶层router表
    class TopRouterTable: ObservableObject {
        @Published var linkurl = false
        @Published var messageDetail = false

    }

}
