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
        
        Networking.requestObject(StorageApi.storage, modeType: StorageModel.self) { [weak self] r, model in
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
        var storageNode = ""
        /// 有效文件数
        var validFilesNumber = ""
        /// 平均副本数
        var averageReplicasMessage = ""
        /// 已用存储量
        var usedStorageMessage = ""
        ///可用存储量
        var availableStorageMessage = ""
        /// 总存储量
        var totalStorageMessage = ""
    }
    
}



