//
//  OrderVM.swift
//  Motion
//
//  Created by Beck on 2021/10/15.
//

import Combine
import UIKit
import MotionComponents

class OrderVM: ObservableObject {
    
    @Published var items: [OrderModel] = []
    
    
    
    // MARK: 代码订单接口
    @Published var isCodeLoading = false
    func requestWithCodeList() {
        isCodeLoading = true
        
        let target = OrderApi.codeOrder(p: .init(page: 0, size: 10, name: "", sort: ""))
        Networking.requestArray(target, modeType: OrderModel.self, atKeyPath: "data.content") {[weak self] r, list in
            // 成功...
           
        }

    }
}


struct OrderModel: Identifiable, Convertible {
    
    var id: String = UUID().uuidString
    
}
