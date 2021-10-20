//
//  PostApi.swift
//  Motion
//
//  Created by 梁泽 on 2021/10/20.
//

import MotionComponents
import SwiftUI

enum PostApi: MTTargetType {
    
    case release(p: ReleaseParameters)
    
    var path: String {
        switch self {
        case .release: return "api/gateway/motion-community/dynamic/release"
        }
    }
    
    var parameterEncoding: ParameterEncoding { JSONEncoding.default }
    
    
}

extension PostApi {
    struct ReleaseParameters: Convertible {
        var content = ""
        var pics = [PicItem]()
        
        struct PicItem: Convertible {
            var seq = 1
            var picId = ""
        }
    }
}
