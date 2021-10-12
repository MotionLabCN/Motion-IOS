//
//  CodepowerApi.swift
//  Motion
//
//  Created by Beck on 2021/10/12.
//

import MotionComponents

// 码力模块菜单 语言
/*URL
    本地: http://127.0.0.1:8802/sys/dict/group/lang?group=lang
    语言:https://ttchain.tntlinking.com/api/codemart/sys/dict/group/lang?group=lang
    价格:https://ttchain.tntlinking.com/api/codemart/label_user_customize/all
 */
enum CodepowerApi: MTTargetType {
    case language(p:CodepoweParameters)
    case technology
    
    var path: String {
        switch self {
        case .language: return "/sys/dict/group/lang"
        case .technology: return "https://ttchain.tntlinking.com/api/codemart/label_user_customize/all"
        }
    }
    
    var method: HTTPRequestMethod {
        switch self {
        case .language: return .get
        case .technology: return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case let .language(p): return p.kj.JSONObject()
        case .technology: return nil
        }
    }
}


//MARK: - 入参
extension CodepowerApi {
    struct CodepoweParameters: Convertible {
        var group = ""
    }
}
