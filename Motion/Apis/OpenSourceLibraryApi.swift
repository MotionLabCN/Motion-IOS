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
    case langList
    
    var path: String {
        switch self {
        case .hotlist:
            return "api/gateway/motion-community/github/repository/hot"
        case .newstar:
            return "/api/gateway/motion-community/github/repository/newstar"
        case .langList: // 开源分类
            return "/api/gateway/motion-community/github/repository/category"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case let .hotlist(p): return p.kj.JSONObject()
        case let .newstar(p): return p.kj.JSONObject()
        case .langList: return nil
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
        var categoryId = 2
    }
    struct newstarlistParameters:Convertible{
        var pageNum = 1
        var pageSize = 20
        var categoryId = 2
    }
}
