//
//  JZTKXSPMLModel.swift
//  JZT_SUPPLIER
//
//  Created by liangze on 2020/4/26.
//  Copyright © 2020 com.FBBC.JoinTown. All rights reserved.
//

import UIKit
import SwiftyJSON
import KakaJSON

public class PageRequest: Convertible {
    public var pageNum = 1
    public var pageSize = 10
    
    public required init() {
        
    }
    
    /// 重置到开始 下拉刷新 等
    public func reset() { pageNum = 1 }
    /// 上提加载
    public func increase() { pageNum += 1 }
    /// 上提后 没数据回滚一格
    public func rollback() { pageNum = max(1, pageNum - 1) }
    /// 是否是头一页
    public var isStart: Bool { pageNum == 1}
    
//    public func kj_modelKey(from property: Property) -> ModelPropertyKey {
//        switch property.name {
//        case "pageNum": return "pageNum"
//        case "pageSize": return "pageSize"
//        default: return property.name
//        }
//    }
}


public struct ListModel<ModelType: Convertible>: Convertible {
    public init() {
    }
    
    public private(set) var list = [ModelType]()
    
    public var totalSize = 0
    public var success = false
    public var message = ""
    public var isCanGoNext: Bool {
        list.count < totalSize
    }
    
    public init(list: [ModelType]) {
        self.list = list
    }
    
    public subscript(_ index: Int) -> ModelType { list[index] }
    
    public var count: Int { list.count }
    
    public var isEmpty: Bool { list.isEmpty }
    
    public mutating func add(_ items: [ModelType]) { list += items }
    
    public mutating func add(_ list: ListModel<ModelType>) {
        totalSize = list.totalSize
        success = list.success
        message = list.message
//        isCanGoNext = list.isCanGoNext
        add(list.list)
    }
    
    public mutating func removeAll() {
        list = []
    }

    public func kj_modelKey(from property: Property) -> ModelPropertyKey {
        switch property.name {
        case "list": return ["list", "rows"]
        case "totalSize": return ["totalSize", "total"]
        default: return property.name
        }
    }

}
