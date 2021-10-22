//
//  PostItemModel.swift
//  Motion
//
//  Created by 梁泽 on 2021/10/22.
//

import Foundation
import KakaJSON

struct PostItemModel: Convertible, Identifiable {
    var id = ""// 12
    var content = ""// null
    var userId = ""// "cb80a136-a7d0-4fc2-9a40-4b4a10c7976b"
    var groupId = ""// null
    var createDate = ""// "2021-10-21 10:32:15"
    var tcc = ""// 0
    var status = ""// 1
    var recommend = ""// null
    var pics = [String]()// []
    var userVO = UserInfo()// ""
}
