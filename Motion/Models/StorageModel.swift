//
//  StorageModel.swift
//  Motion
//
//  Created by Beck on 2021/10/21.
//

import MotionComponents

// MARK: 存储模型
struct StorageModel: Identifiable, Convertible {
    
    var id: String = UUID().uuidString
    /// 存储节点
    var storageNode: Double = 0.00
    /// 有效文件数
    var validFilesNumber: Double = 0.00
    /// 平均副本数
    var averageReplicasMessage: Double = 0.00
    /// 已用存储量
    var usedStorageMessage: Double = 0.00
    ///可用存储量
    var availableStorageMessage: Double = 0.00
    /// 总存储量
    var totalStorageMessage: Double = 0.00
}
