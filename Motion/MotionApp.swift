//
//  MotionApp.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/6.
//

@_exported import SwiftUI
@_exported import Combine


@main
struct MotionApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var tabbarState = AppState.TabbarState.shared
    @StateObject var router = AppState.TopRouterTable()
    @StateObject var userManager = UserManager.shared
    
    @StateObject var findViewPageindex = AppState.FindViewState()
    var body: some Scene {
        WindowGroup {
            ContentView()
//            MTActiveTestView()
                .environmentObject(tabbarState)
                .environmentObject(router)
                .environmentObject(userManager)
                .environmentObject(findViewPageindex)

        }
        
    }
    
    init() {
//        let u = userManager
        print("")
        UserManager.test()
    }
}



