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

/// MARK: 语言
extension FindModel {
    // MARK: 语言 更新当前选中item
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
    
    // 获取上次
    mutating func langUpdateSelectItem () {
        // 拿到数据开始设置上次选中模型 设置选中状态
        if selectValue.isEmpty == false {
            if let index = data.firstIndex(where: {$0.dictValue == selectValue}) {
                let langModel = data[index]
                data[index].isSelect = true
                subTitle = langModel.dictKey
            }
        }
    }
    
    // 清空语言之前选中item
    mutating func clearLangSelectItem() {
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


// 价格
extension FindModel {
    
    // MARK: 价格 更新当前选中item
    mutating func priceUpdate(item: LangModel) {
        if let index = priceList.firstIndex(where: {$0.isSelect == true}) {
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
    mutating func priceUpdateSelectItem () {
        // 拿到数据开始设置上次选中模型 设置选中状态
        if selectValue.isEmpty == false {
            if let index = priceList.firstIndex(where: {$0.dictValue == selectValue}) {
                let priceModel = priceList[index]
                priceList[index].isSelect = true
                subTitle = priceModel.dictKey
            }
        }
    }
    
    // 清空价格之前选中item
    mutating func clearPriceSelectItem() {
        subTitle = "全部"
        selectValue = ""
        guard selectValue.count == 0 else {
            return
        }
        
        if let index = priceList.firstIndex(where: {$0.isSelect == true}) {
            priceList[index].isSelect = false
        }
    }
}


extension FindModel {
    // MARK: 技术 更新当前选中item
    mutating func technologyUpdate(item: TechnologyModel) {
        if let index = technologyList.firstIndex(where: {$0.isSelect == true}) {
            technologyList[index].isSelect = false
        }
        
        if let index = technologyList.firstIndex(where: {$0.id == item.id}) {
            let codeModel = TechnologyModel(labelId: item.labelId, labelName: item.labelName, labelHeat: item.labelHeat, isSelect: !item.isSelect)
            technologyList[index] = codeModel // 修改数据源
            selectValue = codeModel.isSelect ? codeModel.labelId : ""
            subTitle = codeModel.isSelect ? codeModel.labelName : "全部"
        }
    }
    
    // 获取上次
    mutating func technologyUpdateSelectItem () {
        // 拿到数据开始设置上次选中模型 设置选中状态
        if selectValue.isEmpty == false {
            if let index = technologyList.firstIndex(where: {$0.labelId == selectValue}) {
                let priceModel = technologyList[index]
                technologyList[index].isSelect = true
                subTitle = priceModel.labelName
            }
        }
    }
    
    // 清空价格之前选中item
    mutating func clearTechnologySelectItem() {
        subTitle = "全部"
        selectValue = ""
        guard selectValue.count == 0 else {
            return
        }
        
        if let index = technologyList.firstIndex(where: {$0.isSelect == true}) {
            technologyList[index].isSelect = false
        }
    }
}
