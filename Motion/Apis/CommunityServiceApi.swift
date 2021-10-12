//
//  CommunityServiceApi.swift
//  Motion
//
//  Created by 梁泽 on 2021/10/12.
//

import MotionComponents


enum  CommunityServiceApi {
    case userinfo
    
    var baseURL: URL { URL(string: "http://192.168.0.224:8088")! }

    
    var path: String {
        switch self {
        case .userinfo: return "motion-community/userext/info"
       
        }
    }
    
    var method: HTTPRequestMethod {
        switch self {
        case .userinfo: return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .userinfo: return nil
        }
    }
}
