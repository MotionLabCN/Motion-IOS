//
//  MotionComponentsExampleApp.swift
//  MotionComponentsExample
//
//  Created by 梁泽 on 2021/9/5.
//

import SwiftUI
import MotionComponents
@main
struct MotionComponentsExampleApp: App {
    var body: some Scene {
        Networking.request(LoginApi.test) { r in
            let rr = r
            print("")
        }
//        Networking.defaultProvider = CGI<MultiTarget>(configuration: URLSessionConfiguration.af.default,
//                                                      plugins:  [NetworkHeaderPlugin(), ResponsePlugin(), CustomNetworkLoggerPlugin()])
        return WindowGroup {
            ContentView()
        }
    }
}



enum LoginApi: TargetType {
    var baseURL: URL { return URL(string: "https://baidu.com")! }
    
    var path: String { return "" }
    
    var method: Moya.Method { return .get }
    
    var sampleData: Data { return "".data(using: .utf8)! }
    
    var task: Task { return .requestPlain }
    
    var headers: [String : String]? { return nil }
    
    case test
    
}
