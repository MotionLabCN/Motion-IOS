//
//  StorageAip.swift
//  Motion
//
//  Created by Beck on 2021/10/19.
//

import MotionComponents


enum StorageApi: MTTargetType {
   case storageInfo
   case storageList // 我的存储列表接口
    
//    var baseURL: URL { URL(string: "https://ttchain.tntlinking.com")! }
   // 以后这里可以直接写host port

    
   var path: String {
       switch self {
       case .storageInfo: return "/api/superPoints/v1/statistics/getStorageStatistics"
       case .storageList: return "/api/superPoints/v1/statistics/getStorageStatistics"
       }
   }
   
   var method: HTTPRequestMethod {
       switch self {
       case .storageInfo: return .get
       case .storageList: return .get
       }
   }
   
   var parameters: [String : Any]? {
       switch self {
//       case let .language(p): return p.kj.JSONObject()
       case .storageInfo: return nil
       case .storageList: return nil
       }
   }
}
