//
//  LoginApi.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/29.
//

import MotionComponents

enum LoginApi: MTTargetType {
    case loginIn(p: PhoneLoginParameters)
    case github
    
    var path: String {
        switch self {
        case .loginIn: return "auth/login"
        case .github: return "/member/info"
        }
    }
    
    var method: HTTPRequestMethod {
        switch self {
        case .loginIn: return .post
        case .github: return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case let .loginIn(p): return p.kj.JSONObject()
        case .github: return nil
        }
    }
    
}





















//MARK: - 入参
extension LoginApi {
    struct PhoneLoginParameters: Convertible {
        var mobile = ""
        var smsCode = ""
    }
}
