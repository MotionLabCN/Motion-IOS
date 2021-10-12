//
//  Networking.swift
//  Elena
//
//  Created by ash on 2019/10/15.
//  Copyright © 2019 荣恒. All rights reserved.
//

import Foundation
import Combine
import Moya
@_exported import Alamofire
@_exported import KakaJSON
@_exported import SwiftyJSON


open class CGI<Target: TargetType>: MoyaProvider<Target> {

    public init(configuration: URLSessionConfiguration = URLSessionConfiguration.af.default,
                plugins: [PluginType] = [NetworkHeaderPlugin(), ResponsePlugin(), CustomNetworkLoggerPlugin()]) {
        configuration.timeoutIntervalForRequest = 15
        
        let session = Session(configuration: configuration)
        super.init(session: session, plugins: plugins)
    }
    
    @discardableResult
    open override func request(_ target: Target,
                   callbackQueue: DispatchQueue? = .none,
                   progress: ProgressBlock? = .none,
                   completion: @escaping Completion) -> Moya.Cancellable {
        super.request(target, callbackQueue: callbackQueue, progress: progress, completion: completion)
    }
}

/*
 use: Networking.defaultProvider.request
 */
public struct Networking {
    public static var defaultProvider = CGI<MultiTarget>()
}


//MARK: - Combine普通请求
public extension Networking {
    @discardableResult 
    static func publisher(_ target: TargetType) -> AnyPublisher<Response, MoyaError> {
        return defaultProvider.requestPublisher(.init(target))
    }
}

//MARK: - 普通请求
public extension Networking {
    @discardableResult
    static func request(_ target: TargetType, completion: @escaping Completion) -> Moya.Cancellable {
        return defaultProvider.request(.init(target), completion: completion)
    }
    // 暂不公开
    //    @discardableResult
    //    static func request<T>(_ target: TargetType, dataType: T.Type, completion: @escaping (MoyaResult, NetResponse<T>) -> Void ) -> Cancellable {
    //        return Providers.defaultProvider.request(.init(target), dataType: dataType, completion: completion)
    //    }
    
    @discardableResult
    static func requestObject<T: Convertible>(_ target: TargetType, modeType: T.Type, atKeyPath keyPath: String? = "data", completion: @escaping (MoyaResult, T?) -> Void ) -> Moya.Cancellable {
        return defaultProvider.requestObject(.init(target), modeType: modeType, atKeyPath: keyPath, completion: completion)
    }
    
    @discardableResult
    static func requestArray<T: Convertible>(_ target: TargetType, modeType: T.Type, atKeyPath keyPath: String?  = "data", completion: @escaping (MoyaResult, [T]?) -> Void ) -> Moya.Cancellable {
        return defaultProvider.requestArray(.init(target), modeType: modeType, atKeyPath: keyPath, completion: completion)
    }
    
}




