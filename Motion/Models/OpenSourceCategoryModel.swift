//
//  OpenSourceCategoryModel.swift
//  Motion
//
//  Created by Beck on 2021/10/25.
//

import MotionComponents

struct OpenSourceCategoryModel: Convertible, Identifiable {
    var id = ""// 12
    var name = ""// swift
    var parentId = ""
    var status = ""
    // 用户是否选中
    var isSelect: Bool = false
}
