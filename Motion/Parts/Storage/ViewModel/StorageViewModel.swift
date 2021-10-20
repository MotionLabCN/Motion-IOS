//
//  StorageViewModel.swift
//  Motion
//
//  Created by Beck on 2021/10/19.
//

import MotionComponents
import Foundation

class StorageViewModel: ObservableObject {
    
    @Published var isShowmtDetail: Bool = false
    
    @Published var isLoading: Bool = false
    // MARK: 项目列表弹框
    @Published var storageModel: StorageModel? = nil
    
    /// 我的存储
    @Published var storageList: [StorageModel] = []
    
    // 信号量: 使用信号量来阻塞住发请求的线程
    private let semaphore = DispatchSemaphore(value: 0)
    
    init() {
        requestWithAll()
    }
    
    // MARK: 请求接口 详情 我的存储
    func requestWithAll() {
        isLoading = true
        
        let group = DispatchGroup()

        DispatchQueue.global().async(group: group, execute: {[weak self] in
            self?.requestWithStorageInfo()
            self?.semaphore.wait()
         })
                
        DispatchQueue.global().async(group: group, execute: {[weak self] in
            self?.requestWithStorageList()
            self?.semaphore.wait()
         })
         group.notify(queue: DispatchQueue.main) {[weak self] in
             // UI refresh
             self?.isLoading = false
         }
    }
    
    // MARK: 请求我的存储信息
    func requestWithStorageInfo() {
        Networking.requestObject(StorageApi.storageInfo, modeType: StorageModel.self, atKeyPath: nil) { [weak self] r, model in
            guard let self = self else { return }
            self.isLoading = false
            if let model = model {
                self.storageModel = model 
            } else {
                // 请求失败
            }
            self.semaphore.signal()
        }
    }
    
    // MARK:获取我的存储列表
    func requestWithStorageList() {
        Networking.requestArray(StorageApi.storageList, modeType: StorageModel.self) { [weak self] r , list in
            guard let self = self else { return }
            if let list = list {
                self.storageList.removeAll()
                self.storageList.append(contentsOf: list)
            } else {
                // 请求失败
                
            }
            self.semaphore.signal()
        }
        
    }
}

//MARK: - Model
extension StorageViewModel {
    
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
    
}



