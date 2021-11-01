//
//  TechnologyModel.swift
//  Motion
//
//  Created by Beck on 2021/10/21.
//  技术二级分类模型

import MotionComponents

// MARK: 技术模型
struct TechnologyModel: Identifiable, Convertible {
    let id: String = UUID().uuidString
    var labelId: String = ""
    var labelName: String = ""
    var labelHeat: String = ""
    // 用户是否选中
    var isSelect: Bool = false
    
    func updateCompletion() -> TechnologyModel {
        return TechnologyModel(labelId: labelId, labelName: labelName, labelHeat: labelHeat, isSelect: !isSelect)
    }
}
