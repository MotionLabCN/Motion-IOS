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
    @StateObject var fullscreen = AppState.TopFullScreenPage()
    @StateObject var userManager = UserManager.shared
//    @Environment(\.userManager) var userManager

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(tabbarObj)
                .environmentObject(router)
                .environmentObject(fullscreen)
                .environmentObject(userManager)


        }
        
    }
    
    init() {
//        let u = userManager
        print("")
//        UserManager.test()
    }
}



