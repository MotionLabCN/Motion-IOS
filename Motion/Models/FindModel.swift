//
//  FindModel.swift
//  Motion
//
//  Created by Beck on 2021/10/21.
//  码力语言技术价格 3大分类模型

import MotionComponents
import Combine
import SwiftUI

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
    // 选中接口需要的字段
    var selectValue: String = ""
    
    init(id: String = UUID().uuidString, title:String, data: [LangModel], technology: [TechnologyModel],price: [LangModel]) {
        self.id = id
        self.title = title
        self.data = data
        self.technologyList = technology
        self.priceList = price
    }
}


extension FindModel {
    
//    func updateCompletion() -> LangModel {
//        return LangModel(dictKeyGroup: dictKeyGroup, dictKey: dictKey, dictValue: dictValue, isSelect: isSelect)
//    }
    
    
    
    // MARK: 更新当前选中item
    mutating func langUpdate(item: LangModel) {
        
        if let index = data.firstIndex(where: {$0.isSelect == true}) {
            data[index].isSelect = false
        }
        
        if let index = data.firstIndex(where: {$0.id == item.id}) {
            let codeModel = LangModel(dictKeyGroup: item.dictKeyGroup, dictKey: item.dictKey, dictValue: item.dictValue, isSelect: !item.isSelect)
            data[index] = codeModel // 修改数据源
            selectValue = codeModel.isSelect ? codeModel.dictValue : ""
            subTitle = codeModel.isSelect ? codeModel.dictKey : "全部"
        }
    }
    
    mutating func priceUpdate(item: LangModel) {
        
        if let index = data.firstIndex(where: {$0.isSelect == true}) {
            priceList[index].isSelect = false
        }
        
        if let index = priceList.firstIndex(where: {$0.id == item.id}) {
            let codeModel = LangModel(dictKeyGroup: item.dictKeyGroup, dictKey: item.dictKey, dictValue: item.dictValue, isSelect: !item.isSelect)
            priceList[index] = codeModel // 修改数据源
            selectValue = codeModel.isSelect ? codeModel.dictValue : ""
            subTitle = codeModel.isSelect ? codeModel.dictKey : "全部"
        }
    }
    
    // 获取上次
    mutating func langUpdateSelectItem () {
        // 拿到数据开始设置上次选中模型 设置选中状态
        if selectValue.isEmpty == false {
            if let index = data.firstIndex(where: {$0.dictValue == selectValue}) {
                let langModel = data[index]
                data[index].isSelect = true
                subTitle = langModel.dictValue
            }
        }
    }
    
    // 清空之前选中item
    mutating func clearSelectItem() {
        subTitle = "全部"
        selectValue = ""
        guard selectValue.count == 0 else {
            return
        }
        
        if let index = data.firstIndex(where: {$0.isSelect == true}) {
            data[index].isSelect = false
        }
    }
}
