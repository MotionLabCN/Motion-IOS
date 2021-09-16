//
//  NetworkConfig.swift
//  fenJianXiao_iOS
//
//  Created by ash on 2019/11/25.
//  Copyright © 2019 liangze. All rights reserved.
//

import Foundation
import Moya


public protocol CustomTargetType: TargetType {
    var parameters: [String: Any]? { get }
    var parameterEncoding: ParameterEncoding { get }
}

public extension CustomTargetType {
    var baseURL: URL { URL(string: "https://fm.douban.com/")! }

    var method: Moya.Method {
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
    
    var parameterEncoding: ParameterEncoding { URLEncoding.default }

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
