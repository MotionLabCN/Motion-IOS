//
//  CustomResponse.swift
//  fenJianXiao_iOS
//
//  Created by liangze on 2019/12/18.
//  Copyright © 2019 liangze. All rights reserved.
//

import Foundation
import KakaJSON
import SwiftyJSON
import Moya

public typealias MoyaResult = Result<Moya.Response, MoyaError>

enum StatusCode: Int {
    case unknow = -10
    /// 解析错误
//    case parsingError = -9
//    /// 请求错误
//    case requestError = -8
//    /// 无响应
//    case noResponse = -1
//
//    case success = 200
//    case exception = 400
//    /// 用户未登录 登陆超期
//    case unlogin = 1003
//    /// 用户无权限
//    case noPermissions = 403
//    /// 资源不存在
//    case notFound = 404
    
    case other
}


//MARK: - Result 扩展
//Result<Moya.Response, MoyaError>
public extension Result where Success == Moya.Response {
    var rawReponse: Moya.Response? { //原始的 Response
        return try? get()
    }
    
    var json: JSON? { // 原始Response 转data
        guard let data = rawReponse?.data else {
            return nil
        }
        return try? JSON(data: data)
    }
    
    //MARK: - 自定义的
    var code: Int {
        return json?["code"].intValue ?? -1000
    }
    
    var message: String {
        return json?["message"].stringValue ?? ""
    }
    
    // 有个字段叫 data
    var rawData: Any? {
        return json?["data"].rawValue
    }
    
    var dataJson: JSON? {
        return json?["data"]
    }
    
    //MARK: - 其他
    var isSuccess: Bool {
        return code == 0
    }
    
    var errorDesc: String {
        json?["error_description"].stringValue ?? ""
    }
}

public extension Result where Failure == MoyaError {
    var error: MoyaError? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}

//MARK: - 数据解析
public extension Result where Success == Moya.Response {
    func mapObject<T: Convertible>(_ type: T.Type, atKeyPath keyPath: String? = nil) -> T? {
        if let keyPath = keyPath {
            guard let originDic = (json?.dictionaryObject as NSDictionary?)?.value(forKeyPath: keyPath) else {
                return nil
            }
            
            return JSON(originDic).dictionaryObject?.kj.model(T.self)
        }
        
        return json?.dictionaryObject?.kj.model(T.self)
    }
    
    func mapArray<T: Convertible>(_ type: T.Type, atKeyPath keyPath: String? = nil) -> [T]? {
        if let keyPath = keyPath {
            guard let originDic = (json?.dictionaryObject as NSDictionary?)?.value(forKeyPath: keyPath) else {
                return nil
            }
            
            return JSON(originDic).arrayObject?.kj.modelArray(T.self)
        }
        
        return json?.arrayObject?.kj.modelArray(T.self)
    }
}
