//
//  AppState.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/14.
//

import Combine
import Dispatch
import SwiftUI

//MARK: - tabbar状态管理
extension View {
    func mtTabbarKindChange(hanlder: @escaping ((MTTabbar.Kind) -> Void)) -> some View {
        onReceive(TabbarState.shared.$selectedKind) { newValue in
            hanlder(newValue)
        }
    }
    //        .onReceive($tabbarState.selectedKind, perform: { value in
    //            print("home view onReceive \(value)")
    //        })
}

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
        showActionCricleBtn(!isShowSheet)
    }
    
}


//MARK: - FindViewState ????
class FindViewState : ObservableObject {
    @Published var pageIndex : Int = 0
}

