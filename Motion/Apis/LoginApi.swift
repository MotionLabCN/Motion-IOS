//
//  LoginApi.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/29.
//

import MotionComponents



enum LoginApi: CustomTargetType {
    case sendCode(p: SendCodeParameters)
    case loginInWithCode(p: PhoneLoginParameters)
    case apple(p: AppleParameters)
  
    var host: String { ProjectConfig.host }


    var port: Int? { 8081 }
    
    var headers: [String: String]? {
        var headers = [
            "apiVersion": "1.0",
            "os": "1",// 1.ios, 2.android
        ]
        switch self {
        case .loginInWithCode:
            // "tntlinking:tntlinking123**".base64Encoded!
            let authValue = "Basic" + " " + "dG50bGlua2luZzp0bnRsaW5raW5nMTIzKio="
            headers["Authorization"] = authValue
        default: break
        }
        return headers
    }
    

    
    var path: String {
        switch self {
        case .sendCode: return "api/authorization/verification/code/motion"
        case .loginInWithCode: return "api/authorization/oauth/token"
        case .apple: return "api/authorization/union/login/apple/callback"
        }
    }
    
    var method: HTTPRequestMethod {
        switch self {
        case .loginInWithCode, .apple: return .post
        default: return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case let .sendCode(p): return p.kj.JSONObject()
        case let .loginInWithCode(p): return p.kj.JSONObject()
        case let .apple(p): return p.kj.JSONObject()
        }
    }
    
}





















//MARK: - 入参
extension LoginApi {
    struct SendCodeParameters: Convertible {
        var mobile = ""
    }
    
    struct PhoneLoginParameters: Convertible {
        var mobile = ""
        var smsCode = ""
        var grant_type = "sms_code"
        var scope = "all"
        var device = "ios"
        var motion = "1"
    }
    
    struct AppleParameters: Convertible {
        var appleIdentityToken = ""
        var appleUserId = ""
    }
    
}
