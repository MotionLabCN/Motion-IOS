//
//  CodepowerApi.swift
//  Motion
//
//  Created by Beck on 2021/10/12.
//

import MotionComponents

// 码力模块菜单 语言
/*
 码力页面 URL
    本地:                      http://127.0.0.1:8802/sys/dict/group/lang?group=lang
    语言:https://ttchain.tntlinking.com/api/codemart/sys/dict/group/lang?group=lang
    技术:https://ttchain.tntlinking.com/api/codemart/label_user_customize/all
 商品列表:https://ttchain.tntlinking.com/api/codemart/product/page?labelIds=2c9780827bf34b0e017c15c07235017e&lang=&price=&page=0&size=10&sort=
 
    价格:暂无接口写死 直接用数据模型
 */
enum CodepowerApi: MTTargetType {
    case language(p:LangParameters)
    case technology
    case productList(p:ProductListParameters)
    
    var baseURL: URL { URL(string: "http://192.168.0.224:8802")! }

    var path: String {
        switch self {
        case .language: return "/sys/dict/group/lang"
        case .technology: return "/label_user_customize/all"
        case .productList: return "/product/page"
        }
    }
    
    var method: HTTPRequestMethod {
        switch self {
        case .language: return .get
        case .technology: return .get
        case .productList: return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case let .language(p): return p.kj.JSONObject()
        case .technology: return nil
        case let .productList(p): return p.kj.JSONObject()
        }
    }
}


//MARK: - 入参
extension CodepowerApi {
    //MARK:语言参数
    struct LangParameters: Convertible {
        var group = ""
    }
    
    //MARK:产品列表接参数
    struct ProductListParameters: Convertible {
        //标签ID 1;2;3
        var labelIds = ""
        // 代码语言
        var lang = ""
        // 价格区间标识 0;1;2
        var price = ""
        // 页数
        var page: Int = 0
        // 每页显示的数目
        var size = 10
        // 以下列格式排序标准：property[,asc | desc]。 默认排序顺序为升序。 支持多种排序条件：如：id,asc
        var sort = ""
    }
}
