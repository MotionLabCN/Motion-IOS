//
//  FindModel.swift
//  Motion
//
//  Created by Beck on 2021/10/21.
//

import MotionComponents

// MARK: 语言技术价格一级分类数据模型
struct FindModel: Identifiable {
    var id: String
    
    var title: String
    
    var subTitle: String = "全部"

    // 语言
    var data: [LangModel] = []
    
    // 技术
    var technologyList: [TechnologyModel] = []
    
    // 价格
    var priceList: [LangModel] = []
    
    var showText: String {
        subTitle.isEmpty ? "全部" : subTitle
    }
    
    init(id: String = UUID().uuidString, title:String, data: [LangModel], technology: [TechnologyModel],price: [LangModel]) {
        self.id = id
        self.title = title
        self.data = data
        self.technologyList = technology
        self.priceList = price
    }
}

