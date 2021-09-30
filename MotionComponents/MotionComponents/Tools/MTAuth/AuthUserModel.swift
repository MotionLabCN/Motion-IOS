//
//  AuthUserModel.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/28.
//

import Foundation

public typealias AuthCompletion = (AuthResponse?) -> ()

public enum Platform {
    public enum Method {
        case firebase, wkwebview, asAuth, safair
    }
    case git(method: Method)
    case apple
}

public enum PlatformResponse {
    public struct Github {
//        var displayName: String? = nil
//        var photoURL: String?  = nil
//        var email: String?  = nil
//        var refreshToken: String?  = nil
//        var accessToken: String? = nil
//        var gitHubCode = ""
        public var token = ""
    }
    
    public struct Apple {
        public let appleUserid: String
        public let appleIdentityToken: String
    }
    
    case git(_ response: Github)
    case apple(_ response: Apple)
}

public struct AuthResponse {
    public var platform: Platform
    public var response: PlatformResponse
    
}
