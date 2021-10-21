//
//  CodeProductModel.swift
//  Motion
//
//  Created by Beck on 2021/10/21.
//  码力产品模型

import MotionComponents

// MARK: 产品模型
struct CodeProductModel: Identifiable, Convertible {
    var id: String { productId }
    var productId = "" //:"2c9780827c30630d017c306c65600000",
    var productName = ""//:"网站后台权限管理系统",
    var productLang = ""//:"Java",
    var productPrice = ""// ":0.01,
    var productOriginalPrice = ""//:0.01,
    var status = ""//:0,
    var cstCreate = ""
    var cstCreateTimestamp = ""
    var createUserId = ""
    var authorNickname = ""
    var authorHeadImgUrl = ""
    var countBrowses = "" // 浏览个数
    var bought = ""
    
    var storageAttachments: [CodeDetailModel] = []
    
    var productImg: String {
        storageAttachments.count > 2 ? storageAttachments[1].attachmentKey : ""
    }
}
