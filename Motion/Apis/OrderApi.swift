//
//  OrderApi.swift
//  Motion
//
//  Created by Beck on 2021/10/15.
//

import MotionComponents
/* URL
    代码订单: https://ttchain.tntlinking.com/api/order/order/code/consume/page?page=0&size=10&name=&sort=
 
 */
enum OrderApi: MTTargetType {
    
        case codeOrder(p:CodeParameters) // 代码订单
        case storeOrder(p:CodeParameters) // 存取订单
        
        var baseURL: URL { URL(string: "http://192.168.0.224:8802")! }

        var path: String {
            switch self {
            case .codeOrder: return "/order/code/consume/page"
            case .storeOrder: return "/"
            }
        }
        
        var method: HTTPRequestMethod {
            switch self {
            case .codeOrder: return .get
            case .storeOrder: return .get
            }
        }
        
        var parameters: [String : Any]? {
            switch self {
            case let .codeOrder(p): return p.kj.JSONObject()
            case let .storeOrder(p): return p.kj.JSONObject()
            }
        }
}



//MARK: - 入参
extension OrderApi {
    //MARK:语言参数
    struct CodeParameters: Convertible {
        var page = 0
        var size = 10
        var name = ""
        var sort = ""
    }
    
    //MARK:产品列表接参数
    struct StoListParameters: Convertible {
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
