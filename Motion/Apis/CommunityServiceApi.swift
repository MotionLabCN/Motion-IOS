//
//  CommunityServiceApi.swift
//  Motion
//
//  Created by 梁泽 on 2021/10/12.
//

import MotionComponents


enum CommunityServiceApi: MTTargetType {
    case userinfo

    var port: Int? {
        switch ProjectConfig.env {
        case .local: return 8088
        case .test: return ProjectConfig.port
        }
        
    }

    
    var path: String {
        switch self {
        case .userinfo: return "api/gateway/motion-community/userext/info"
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









