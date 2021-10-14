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
    var scheme: String { ProjectConfig.scheme }
    var host: String { ProjectConfig.host }
    var port: Int? { ProjectConfig.port }
    var firstPath: String? { ProjectConfig.firstPath }
    

    var headers: [String: String]? {
        var headers = [
            "apiVersion": "1.0",
            "os": "1",// 1.ios, 2.android
        ]
        if !UserManager.shared.channel.isEmpty {
            headers["channel"] = UserManager.shared.channel
        }
        if !UserManager.shared.token.isEmpty {
            headers["Authorization"] = "Bearer" + " " + UserManager.shared.token
        }
        return headers
    }
    
  
    
}


struct NetResponse<Convertible> {
    var code = "" //:200,
    var message = "" //:null,
    var path = "" //:"/sys/dict/group/lang",
    var data: Convertible?
}
