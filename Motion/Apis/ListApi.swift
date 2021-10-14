//
//  ListApi.swift
//  Motion
//
//  Created by 梁泽 on 2021/10/14.
//

import MotionComponents
import SwiftUI
enum ListApi: MTTargetType {
    case one
    case two(p: TwoParameters)
        
    var path: String {
        switch self {
        case .one: return "one"
        case .two: return "two"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .one: return .get
        case .two: return .post
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .one: return nil
        case let .two(p): return p.kj.JSONObject()
        }
    }
    
}



//MARK: - 入参
extension ListApi {
    struct TwoParameters: Convertible {
        var phone: String? = nil
        var code: String? = nil
        var name: String? = nil
    }
}





