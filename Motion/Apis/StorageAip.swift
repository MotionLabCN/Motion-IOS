//
//  StorageAip.swift
//  Motion
//
//  Created by Beck on 2021/10/19.
//

import MotionComponents


enum StorageApi: MTTargetType {
   case storage
   
    var baseURL: URL { URL(string: "https://ttchain.tntlinking.com/api")! }
   // 以后这里可以直接写host port
//   var port: Int? { 8802 }
    
   var path: String {
       switch self {
       case .storage: return "/api/superPoints/v1/statistics/getStorageStatictics"
       }
   }
   
   var method: HTTPRequestMethod {
       switch self {
       case .storage: return .get
       }
   }
   
   var parameters: [String : Any]? {
       switch self {
//       case let .language(p): return p.kj.JSONObject()
       case .storage: return nil
       }
   }
}
