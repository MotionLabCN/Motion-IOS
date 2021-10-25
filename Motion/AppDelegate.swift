//
//  AppDelegate.swift
//  Motion (iOS)
//
//  Created by 梁泽 on 2021/9/6.
//

import Foundation
import MotionComponents
import Moya

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Networking.defaultProvider =  CGI<MultiTarget>(plugins: [NetworkHeaderPlugin(), MTResponsePlugin(), CustomNetworkLoggerPlugin()])

        
        AppearConfig.config()
        UMRUN()
        return true
    }
    

}


func UMRUN(){
        UMAnalyticsSwift().run()
        UMAnalyticsSwift.beginLogPageView(pageName: "首页")
        UMCommonSwift().run()
}
