//
//  NetworkPlugin.swift
//  fenJianXiao_iOS
//
//  Created by liangze on 2019/12/17.
//  Copyright © 2019 liangze. All rights reserved.
//

import Foundation
import Moya


/// 通用网络插件
public class CustomNetworkLoggerPlugin: PluginType {
    /// 开始请求字典
    private static var startDates: [String: Date] = [:]
    
    public init() {
        
    }
    
    /// 即将发送请求
    public func willSend(_ request: RequestType, target: TargetType) {
        #if DEBUG
        // 设置当前时间
        CustomNetworkLoggerPlugin.startDates[String(describing: target)] = Date()
        #endif
    }
    
    
    /// 收到请求时
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        #if DEBUG
        guard let startDate = CustomNetworkLoggerPlugin.startDates[String(describing: target)] else { return }
        // 获取当前时间与开始时间差（秒数）
        let requestDate = Date().timeIntervalSince1970 - startDate.timeIntervalSince1970
        
        print("================================请求日志==============================")
        if let url = result.rawReponse?.request?.url?.absoluteString {
           print("URL : \(url)")
        } else {
           print("URL : \(target.baseURL)\(target.path)")
        }
        print("请求方式：\(target.method.rawValue)")
        print("请求时间 : \(String(format: "%.1f", requestDate))s")
        print("请求头：\(target.headers ?? [:])")
        if let request = result.rawReponse?.request {
            switch target.task {
            case .requestPlain, .uploadMultipart: break
            case let .requestParameters(parameters, _), let .uploadCompositeMultipart(_, parameters):
                print("请求参数 : ", parameters)
            default:
                if let requestBody = request.httpBody {
                    let decrypt = requestBody.parameterString()
                    print("请求参数 : \(decrypt)")
                }
            }
            
        }
        
        switch result {
        case let .success(response):
            if let code = try? response.map(Int.self, atKeyPath: "code") {
                let message = (try? response.map(String.self, atKeyPath: "note")) ?? ""
                print("""
                    HttpCode : \(response.response?.statusCode ?? -1)
                    status :\(code)
                    message : \(message)
                    """)
                print("响应数据：\n \(String(data: response.data, encoding: .utf8) ?? "")")
            } else {
                print("code解析失败")
                print("请求错误详情：\(String(data: response.data, encoding: .utf8) ?? "没有错误信息")")
            }
            
        case let .failure(error):
            print("请求错误：\(error)")
        }
        print("=====================================================================")
        
        // 删除完成的请求开始时间
        CustomNetworkLoggerPlugin.startDates.removeValue(forKey: String(describing: target))
        #endif
    }
}


fileprivate extension Data {
    func parameterString() -> String {
        guard let json = try? JSONSerialization.jsonObject(with: self),
            let value = json as? [String : Any] else {
            return ""
        }
        return "\(value)"
    }
    
}


//public func lzprint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
//    #if DEBUG
//    print(items, separator: separator, terminator: terminator)
//    #endif
//}
