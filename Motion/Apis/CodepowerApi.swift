//
//  CodepowerApi.swift
//  Motion
//
//  Created by Beck on 2021/10/12.
//

import MotionComponents

/*  菜单 语言
    本地: http://127.0.0.1:8802/sys/dict/group/lang?group=lang
    URL:https://ttchain.tntlinking.com/api/codemart/sys/dict/group/lang?group=lang
 */
enum CodepowerApi: MTTargetType {
    case codepowerNemu(p:CodepoweParameters)
    
    var path: String {
        switch self {
        case .codepowerNemu: return "api/codemart/sys/dict/group/lang"
        }
    }
    
    var method: HTTPRequestMethod {
        switch self {
        case .codepowerNemu: return .get

        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case let .codepowerNemu(p): return p.kj.JSONObject()
        
        }
    }
}


//MARK: - 入参
extension CodepowerApi {
    struct CodepoweParameters: Convertible {
        var group = ""
    }
}
