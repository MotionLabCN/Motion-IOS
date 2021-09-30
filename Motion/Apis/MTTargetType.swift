//
//  MTTargetType.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/29.
//

import MotionComponents



protocol MTTargetType: CustomTargetType {
    
}

extension MTTargetType {
    var baseURL: URL { URL(string: ProjectConfig.baseUrl)! }

    var headers: [String: String]? {
        var headers = [
            "apiVersion": "1.0",
            "os": "1",// 1.ios, 2.android
        ]
        headers["channel"] = UserManager.shared.channel
        headers["token"] = UserManager.shared.token
        return headers
    }
    
    var parameterEncoding: ParameterEncoding { JSONEncoding.default }
    
}
