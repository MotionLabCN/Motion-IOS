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
    @StateObject var tabbarObj = AppState.TabbarState()
    @StateObject var router = AppState.TopRouterTable()
    
    @StateObject var userManager = UserManager.shared
    @StateObject var sheetManager = MTSheetManager.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
//            NextView()
                .environmentObject(tabbarObj)
                .environmentObject(router)
                .environmentObject(userManager)
                .environmentObject(sheetManager)

        }
        
    }
    
    init() {
//        let u = userManager
        print("")
//        UserManager.test()
    }
}



