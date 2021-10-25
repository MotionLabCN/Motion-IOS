//
//  OpenSourceLibraryApi.swift
//  Motion
//
//  Created by Beck on 2021/10/25.
//

import MotionComponents

enum OpenSourceLibraryApi : MTTargetType{
    
    case hotlist(p:hotlistParameters)
    case newstar(p:newstarlistParameters)
    case category
    
    var path: String {
        switch self {
        case .hotlist: // 热门
            return "api/gateway/motion-community/github/repository/hot"
        case .newstar: // 新星
            return "/api/gateway/motion-community/github/repository/newstar"
        case .category: // 分类
            return "/api/gateway/motion-community/github/repository/category"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case let .hotlist(p): return p.kj.JSONObject()
        case let .newstar(p): return p.kj.JSONObject()
        case .category: return nil
        }
    }
    
    var headers: [String: String]? {
        nil
    }
}

//MARK: Api.p
extension OpenSourceLibraryApi{
    struct hotlistParameters:Convertible{
        var pageNum = 1
        var pageSize = 20
        var categoryId: String = ""
    }
    struct newstarlistParameters:Convertible{
        var pageNum = 1
        var pageSize = 20
        var categoryId: String = ""
    }
}
