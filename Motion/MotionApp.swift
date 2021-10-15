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
    @State var showLaunch : Bool = true
    var body: some Scene {
        WindowGroup {
//            LiV()
            ZStack{
                ContentView()
                    .environmentObject(tabbarState)
                    .environmentObject(userManager)
                    .environmentObject(findViewPageindex)
                
                if showLaunch{
                    LaunchView()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation(.spring()){
                        showLaunch.toggle()
                    }
                }
            }
      

        }
        
    }
    
    init() {
        print("")
        MockTool.using()
//        UserManager.shared.logout()
    }
}




