//
//  GithubApi.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/28.
//

import Foundation
import Moya

enum GithubApi: CustomTargetType {
    var baseURL: URL { URL(string: "https://fm.douban.com/")! }

    var method: Moya.Method {
        return .get
    }

    var path: String {
        ""
    }
    
    var parameters: [String: Any]? { nil }
    

    var headers: [String: String]? {
        return nil
    }
}
