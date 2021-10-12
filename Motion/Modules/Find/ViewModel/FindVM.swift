//
//  FindVM.swift
//  Motion
//
//  Created by Beck on 2021/10/9.
//

import Combine
import UIKit
import MotionComponents
import SwiftUI

class FindVM: ObservableObject {
    
    // MARK: 码力集市价格语言
    @Published var isShowmtsheet: Bool = false // 一级分类下弹框
    @Published var isShowmtDetail: Bool = false// 二级分类下弹框
    
    var selectIndex: Int = 0
    
    var selectDetail: Int = -1
    
    // 选中当前模型
    @Published var selectFindModel: FindModel = FindModel(dictKey: "语言",isSelect: false,
                                               list: [FindModel(dictKey: "oc", isSelect: false)]
    )
    
    @Published var proList: [String] = [
        "ssss","1","2"
    ]
    
    // 码力数据源
    @Published var itemList: [FindModel] = []
    
    
    init() {
        getItems()
        
        // 调用接口
        
    }
    
    func getItems() {
        let item =  [
            FindModel(dictKey:"语言",
                      isSelect: false,
                      list: [FindModel(dictKey:"Java",isSelect: false),
                             FindModel(dictKey:"Python",isSelect: false),
                             FindModel(dictKey:"C/C++",isSelect: false),
                             FindModel(dictKey:"Java",isSelect: false),
                             FindModel(dictKey:"Python",isSelect: false),
                             FindModel(dictKey:"C/C++",isSelect: false)]),
            
            FindModel(dictKey:"技术",
                      isSelect: false,
                      list: [FindModel(dictKey:"redis",isSelect: false),
                             FindModel(dictKey:"spring",isSelect: false)]),
            
            FindModel(dictKey:"价格",
                      isSelect: false,
                      list: [FindModel(dictKey:"0-10",isSelect: false)])
        ]
        itemList.append(contentsOf: item)
        selectFindModel = item[0];
    }
    
    
    func addItem(title: String) {
        proList = ["beck","sun"]
    }
    
    // MARK: 修改数据
    func updateItem(item: FindModel) {
        // 所有设置false
        if let index = selectFindModel.list.firstIndex(where: {$0.isSelect == true}) {
            selectFindModel.list[index].isSelect = false
            itemList[selectIndex].list[index].isSelect = false
        }
        
        if let index = selectFindModel.list.firstIndex(where: {$0.id == item.id}) {
            let findModel = FindModel(dictKey:item.dictKey, isSelect: !item.isSelect)
            selectFindModel.list[index] = findModel
            itemList[selectIndex].list[index] = findModel // 修改数据源
            selectDetail = index
            itemList[selectIndex].subTitle = findModel.isSelect ? findModel.dictKey : "全部"
        }
        isShowmtDetail.toggle()
    }
    
    
    // MARK: 获取码力数据
    func requestWithMenuList() {
        let target = CodepowerApi.codepowerNemu(p: .init(group: "lang"))
        Networking.requestObject(target, modeType: UserInfo.self) { r, model in
            // 成功...
            
        }
    }
    
    
    // MARK: 获取码力列表数据
    func requestWithCodeList() {
        addItem(title: "beck")
        let target = LoginApi.github
        Networking.requestObject(target, modeType: UserInfo.self) { r, model in
            // 成功...
        }
    }
    
    
}

struct FindModel: Identifiable {
    let id: String
    let dictKey: String
//    let dictValue: String
    
    var subTitle: String = ""
    
    var list: [FindModel]
    
    // 用户是否选中
    var isSelect: Bool
    
    var showText: String {
        subTitle.isEmpty ? "全部" : subTitle
    }
    
    init(id: String = UUID().uuidString, dictKey:String, isSelect: Bool, list: [FindModel] = []) {
        self.id = id
        self.dictKey = dictKey
        self.isSelect = isSelect
        self.list = list
    }
    
//    mutating func updateItem(item: FindModel) {
//
//        if let index = list.firstIndex(where: {$0.id == item.id}) {
//            list[index] = FindModel(name:item.name,isSelect: !item.isSelect)
//        }
//    }
    
    // MARK:更新数据
    func updateCompletion() -> FindModel {
        return FindModel(id: id, dictKey: dictKey, isSelect: !isSelect)
    }
}

//struct FindDetailModel: Identifiable {
//    var id: UUID = UUID()
//    @State var name: String = ""
//
//    // 用户是否选中
//    var isSelect: Bool = false
//
//    var iconName: String {
//        isSelect ? "checkmark.circle" : "circle"
//    }
//    var iconColor: Color {
//        isSelect ? .green : .red
//    }
//
//    var showText: String {
//        name.isEmpty ? "" : name
//    }
//
//    func updateItem(item: FindModel) {
//        if let index = list.firstIndex(where: {$0.id == item.id}) {
//            list[index] = FindModel(name:item.name,isSelect: !item.isSelect)
//        }
//    }
//
//    func updateCompletion() -> FindModel {
//        return FindModel(id: id, name: name, isSelect: !isSelect)
//    }
//}
