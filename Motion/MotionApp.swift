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
    @StateObject var tabbarState = TabbarState.shared
    @StateObject var userManager = UserManager.shared
    
    @StateObject var findViewPageindex = FindViewState()

    var body: some Scene {
        WindowGroup {
            ContentView()
//            MTActiveTestView()
                .environmentObject(tabbarState)
                .environmentObject(userManager)
                .environmentObject(findViewPageindex)

        }
        
    }
    
    init() {
        print("")
        MockTool.using()
//        UserManager.shared.logout()
    }
}




