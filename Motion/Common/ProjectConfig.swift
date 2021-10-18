//
//  ProjectConfig.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/29.
//

import Foundation



struct ProjectConfig {
    static let env: Environment = .test
    
    enum Environment {
    case local, test
    }
    
    static var scheme: String { "http" }
    
    static var host: String {
        switch env {
        case .local: return "192.168.0.224"
        case .test: return "183.66.65.207" //http://183.66.65.207:8081/api/authorization/
        }
    }
    
    static var port: Int? {
        switch env {
        case .local: return 8088
        case .test: return 8081
        }
    }
    
   
    
    static var firstPath: String? { nil }
    
  
    

}

