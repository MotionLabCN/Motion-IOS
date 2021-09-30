//
//  ProjectConfig.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/29.
//

import Foundation



struct ProjectConfig {
    static let env: Environment = .local
    
    enum Environment {
    case local, test
    }
    
    static var baseUrl: String {
        switch env {
        case .local: return "http://192.168.0.224:8085"
        case .test: return "http://192.168.0.224:8085"
        }
    }
    

}
