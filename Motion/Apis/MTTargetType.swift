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
    var baseURL: URL { URL(string: "http://192.168.0.224:8085")! }

    var headers: [String: String]? {
        
        var headers = [
            "apiVersion": "1.0",
            "os": "1"// 1.ios, 2.android
        ]
        headers["channel"] = "" //1.一键手机登陆 2.github 3.apple 4.wechat 5.手机验证码
        //        if !UserInfo.current.token.isEmpty {
        //            headers["Authorization-jbs"] = UserInfo.current.token
        //        }
        
        return headers
    }
    
    var parameterEncoding: ParameterEncoding { JSONEncoding.default }
    
}
