//
//  GithubApi.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/28.
//

import Foundation
import Moya
import KakaJSON
enum GithubApi: CustomTargetType {
    struct GetAccessTokenParameters: Convertible {
        var client_id: String = ""
        var client_secret: String = ""
        var code: String = ""
    }
    case access_token(p: GetAccessTokenParameters)
    
    var baseURL: URL { URL(string: "https://github.com")! }

    var method: Moya.Method {
        switch self {
        case .access_token: return .post
        }
    }

    var path: String {
        switch self {
        case .access_token: return "login/oauth/access_token"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case let .access_token(p): return p.kj.JSONObject()
        }
    }
    

    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
}
