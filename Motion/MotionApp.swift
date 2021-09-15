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
    @StateObject var uiStateObj = AppState.UIState()
    @StateObject var router = AppState.TopRouterTable()

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(uiStateObj)
                .environmentObject(router)

        }
        
    }
}
