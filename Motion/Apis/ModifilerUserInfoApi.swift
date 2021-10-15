//
//  ModifilerUserInfoApi.swift
//  Motion
//
//  Created by 梁泽 on 2021/10/14.
//

import MotionComponents

enum ModifilerUserInfoApi: MTTargetType {
    case sendCode(p: Parameters)
    case updatePhone(p: UpdatePhoneParameters)
    case updateInfo(p: UpdateInfoParameters)
    
    var port: Int? { 8801 }
    
    var path: String {
        switch self {
        case .sendCode: return "user/verification/code"
        case .updatePhone: return "user/update/mobile"
        case .updateInfo: return "user/update/info"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .sendCode: return .get
        default: return .post
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case let .sendCode(p): return p.kj.JSONObject()
        case let .updatePhone(p): return p.kj.JSONObject()
        case let .updateInfo(p): return p.kj.JSONObject()
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .sendCode: return URLEncoding()
        default: return JSONEncoding()
        }
    }
    
    
    
}


extension ModifilerUserInfoApi {
    struct Parameters: Convertible {
        var mobile = ""
    }
    
    struct UpdatePhoneParameters: Convertible {
        var userId = UserManager.shared.user.id
        var mobile = ""
        var code = ""
    }
    
    struct UpdateInfoParameters: Convertible {
        var userId = UserManager.shared.user.id
        var nickname = ""
    }
    
}
