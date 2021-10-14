//
//  NetworkConfig.swift
//  fenJianXiao_iOS
//
//  Created by ash on 2019/11/25.
//  Copyright © 2019 liangze. All rights reserved.
//

import Foundation
import Moya

public typealias HTTPRequestMethod = Moya.Method
public protocol CustomTargetType: TargetType {
    var parameters: [String: Any]? { get }
    var parameterEncoding: ParameterEncoding { get }
    
    var scheme: String { get }
    var host: String { get }
    var port: Int? { get }
    var firstPath: String? { get }
}

public extension CustomTargetType {
    var baseURL: URL {
        var url = "\(scheme)://\(host)"
        if let p = port {
            url = "\(url):\(p)"
        }
        if let first = firstPath {
            url = "\(url)/\(first)"
        }
        return URL(string: url)!
    }
    
    var scheme: String { "http" }
    var host: String { "" }
    var port: Int? { nil }
    var firstPath: String? { nil }

    var method: HTTPRequestMethod {
        return .get
    }

    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }

    var task: Task {
        switch method {
        case .get:
            if let parameters = parameters {
                return .requestParameters(parameters: parameters, encoding: parameterEncoding)
            }
            return .requestPlain
        case .post, .put:
            return .requestParameters(parameters: parameters ?? [:], encoding: parameterEncoding)
        default:
            return .requestPlain
        }
    }
    
    var parameters: [String: Any]? { nil }
    
    var parameterEncoding: ParameterEncoding {
        switch self.method {
        case .get: return URLEncoding.default
//        default: return JSONEncoding.default
        default: return URLEncoding.default
        }
    }
    
    var headers: [String: String]? {
//        var headers = [
//            "lz_header": "lz_header_value",
//            "uuid": (try? KeychainUUID.current.uuid()) ?? ""
//        ]
//        if !UserInfo.current.token.isEmpty {
//            headers["Authorization-jbs"] = UserInfo.current.token
//        }
        return nil
    }
}
