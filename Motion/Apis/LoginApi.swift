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
    case github
    
    var baseURL: URL { URL(string: "http://192.168.0.224:8800")! }

    
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
        case .sendCode: return "verification/code/motion"
        case .loginInWithCode: return "oauth/token"
        case .github: return "/member/info"
        }
    }
    
    var method: HTTPRequestMethod {
        switch self {
        case .loginInWithCode: return .post
        default: return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case let .sendCode(p): return p.kj.JSONObject()
        case let .loginInWithCode(p): return p.kj.JSONObject()
        case .github: return nil
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
    }
    
}
