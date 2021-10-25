//
//  ResponsePlugin.swift
//  Network.swift
//
//  Created by ash on 2019/10/16.
//

import Moya
import SwiftyJSON

public class MTResponsePlugin: PluginType {
    public init() {}

    /// Called to modify a result before completion.
//    func process(_ result: Result<Moya.Response, MoyaError>, target: TargetType) -> Result<Moya.Response, MoyaError> {
//
//        switch result {
//        case .success(let value):
//            do {
//                let anyData = try value.mapJSON()
//
//                guard let jsonDictionary = anyData as? NSDictionary else {
//                    let errorStr = "无效的json格式"
//                    return .failure(MoyaError.requestMapping(errorStr))
//                }
//                guard let code = jsonDictionary.value(forKeyPath: "status") as? Int else {
//                    let error = "服务器code解析错误\n\(cc_responseDescribe(value) ?? "")"
//                    return .failure(MoyaError.requestMapping(error))
//                }
//                guard code == 200 else {
//                    let message = (jsonDictionary.value(forKeyPath: "message") as? String) ?? "code不等于\(200)"
//                    return .failure(MoyaError.requestMapping(message))
//                }
//                return .success(value)
//            } catch {
//                let error = MoyaError.jsonMapping(value)
//                return .failure(error)
//            }
//        case .failure(let error):
//            return .failure(error)
//        }
//    }
    
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        /// 临时解决方案
        if target.baseURL.absoluteString.contains("https://ttchain.tntlinking.com") {
             return
        }
        
        switch result.rawReponse?.statusCode {
        case 401:
            UserManager.shared.logout()
        default: break
        }

    }
    
}
