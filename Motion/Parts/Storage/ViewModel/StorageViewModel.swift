//
//  StorageViewModel.swift
//  Motion
//
//  Created by Beck on 2021/10/19.
//

import MotionComponents
import Foundation

class StorageViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    // MARK: 项目列表弹框

    @Published var storageModel: StorageModel? = nil
    
    init() {
        requestWithStorage()
    }
    
    func requestWithStorage() {
        isLoading = true
        Networking.requestObject(StorageApi.storage, modeType: StorageModel.self, atKeyPath: nil) { [weak self] r, model in
            guard let self = self else { return }
            self.isLoading = false
            if let model = model {
                self.storageModel = model
            } else {
                // 请求失败
            }
        }
    }
}

//MARK: - Model
extension StorageViewModel {
    
    // MARK: 模型
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
    
}



