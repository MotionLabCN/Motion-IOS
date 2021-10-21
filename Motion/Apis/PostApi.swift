//
//  PostApi.swift
//  Motion
//
//  Created by 梁泽 on 2021/10/20.
//

import MotionComponents
import SwiftUI

enum PostApi: MTTargetType {
    
    case release(p: ReleaseParameters)
    case get(type: PostType, p: PageRequest)
    
    var path: String {
        switch self {
        case .release: return "api/gateway/motion-community/dynamic/release"
        case let .get(type, _):
            return "api/gateway/motion-community/dynamic/aggregate/\(type.rawValue)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .release: return .put
        case .get : return .get
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .release: return JSONEncoding.default
        default: return URLEncoding.default
        }
        
    }
    
    
    var parameters: [String : Any]? {
        switch self {
        case .release: return nil
        case let .get(_, page):
            return page.kj.JSONObject()
        }
    }
}

extension PostApi {
    enum PostType: String {
    case 热门 = "hot", 首页 = "index"
    }
    
    struct ReleaseParameters: Convertible {
        var content = ""
        var pics = [PicItem]()
        
        struct PicItem: Convertible {
            var seq = 1
            var picId = ""
        }
    }
}
