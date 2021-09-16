//
//  MoyaProviderTypeExtension.swift
//  SwiftComponentsDemo
//
//  Created by liangze on 2020/9/4.
//  Copyright © 2020 liangze. All rights reserved.
//

import Foundation
import Moya
import KakaJSON

public extension MoyaProviderType {
    @discardableResult
    func requestObject<T: Convertible>(_ target: Target,
                                       modeType: T.Type,
                                       atKeyPath keyPath: String? = nil,
                                       callbackQueue: DispatchQueue? = .none,
                                       progress: Moya.ProgressBlock? = .none,
                                       completion: @escaping (MoyaResult, T?) -> Void ) -> Cancellable {
        return request(target, callbackQueue: callbackQueue, progress: progress) { r in
            let m = try? r.rawReponse?.mapObject(T.self, atKeyPath: keyPath)
            completion(r, m)
        }
    }
    
    @discardableResult
    func requestArray<T: Convertible>(_ target: Target,
                                      modeType: T.Type,
                                      atKeyPath keyPath: String? = nil,
                                      callbackQueue: DispatchQueue? = .none,
                                      progress: Moya.ProgressBlock? = .none,
                                      completion: @escaping (MoyaResult, [T]?) -> Void ) -> Cancellable {
        return request(target, callbackQueue: callbackQueue, progress: progress) { r in
            let ms = try? r.rawReponse?.mapArray(T.self, atKeyPath: keyPath)
            completion(r, ms)
        }
    }

}
