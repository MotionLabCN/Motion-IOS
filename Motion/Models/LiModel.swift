//
//  LiModel.swift
//  Motion
//
//  Created by 梁泽 on 2021/10/14.
//

import MotionComponents

struct LiModel: Convertible, Identifiable {
    var name = ""
    var subtitle = ""
    var id = UUID().uuidString
    
    var dictKeyGroup = "" //:"LANG",
    var dictKey = "" //:"Java",
    var dictValue = "" //:"Java"
}
