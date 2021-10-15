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
    /// 代码订单数组
    @Published var codeItems: [OrderModel] = []
    

    // MARK: 代码订单接口
    @Published var isCodeLoading = false
    func requestWithCodeList() {
        isCodeLoading = true
        
        let target = OrderApi.codeOrder(p: .init(page: 0, size: 10, name: "", sort: ""))
        Networking.requestArray(target, modeType: OrderModel.self, atKeyPath: "data.content") {[weak self] r, list in
            // 成功...
            if let list = list {
                self?.codeItems = list
            }
            self?.isCodeLoading = false
            let arr = MockTool.readArray(OrderModel.self, fileName: "myorder_code", atKeyPath: "data.content") ?? []
//            let arr = MockTool.readArray(OrderModel.self, fileName: "myorder_ code") ?? []
            self?.codeItems = arr
        }
    }
    
    init() {
        requestWithCodeList()
    }
}
 


// MARK: 代码订单模型
struct OrderModel: Identifiable, Convertible {

    var id: String = UUID().uuidString
    var fkProductId = ""//": "2c9780827c30630d017c306c65600000",
    var fkProductName = ""// : "网站后台权限管理系统",
    var totalAmount = ""//: 0.01,
    var outTradeNo = ""//: "20211014000003012407890460938240",
    var fkProductImage = ""//: "/files/original/d1a29a85-eb0a-43e5-8c93-ea7c8cfc562d.png",
    var orderState = ""//: "ToBePaid",
    
    var tradingPlatform = "" //: "Alipay", "WeChat"
    
    var cstCreate = ""//": "2021-10-14 15:53:29"
    
    // 支付方式
    var payStyle: String {
        get {
            if tradingPlatform == "Alipay" {
                return "支付宝"
            }else {
                return "微信"
            }
        }
    }
    
    // 订单状态
    var orderStateString: String {
        if orderState == "ToBePaid" {
            return "待支付"
        }else if orderState == "PaymentSuccessful" {
            return "支付成功"
        }else if orderState == "PaymentFailed" {
            return "支付失败"
        }else {
            return ""
        }
    }
}
