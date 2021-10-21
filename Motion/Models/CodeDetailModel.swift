//
//  CodeDetailModel.swift
//  Motion
//
//  Created by Beck on 2021/10/21.
//  码力产品下的分类模型

import MotionComponents

struct CodeDetailModel: Identifiable, Convertible {
    var id: String = UUID().uuidString
    
    var attachmentKey: String = ""
    
    var attachmentKeyThumbnail: String = ""
}
