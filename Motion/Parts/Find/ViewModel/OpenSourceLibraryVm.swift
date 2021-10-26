//
//  OpenSourceLibraryVm.swift
//  Motion
//
//  Created by Beck on 2021/10/25.
//


import MotionComponents

class OpenSourceLibraryVm : ObservableObject {
    /// loading
    @Published var isLoadingCategory: Bool = false //请求分类语言
    @Published var isLoadingInfo: Bool = false //请求接口loading
    
    /// 数据
    @Published var hotList : [OpenSourceLibraryModel] = []
    @Published var newStarList : [OpenSourceLibraryModel] = []
    @Published var categoryList: [OpenSourceCategoryModel] = []
    
    /// 接口参数 当前选中的分类语言id
    var categoryId: String = ""
    var categoryName: String = ""
    
    
    init(){
        requestWtihHotNew()
    }
    
    
    /// MARK: 修改数据
    func updateLangItems(item: OpenSourceCategoryModel) {
        if let index = categoryList.firstIndex(where: {$0.isSelect == true}) {
            categoryList[index].isSelect = false
        }
        
        if let index = categoryList.firstIndex(where: {$0.id == item.id}) {
            self.categoryList[index].isSelect = true
            categoryId = self.categoryList[index].id
            categoryName = self.categoryList[index].name
        }
        
        requestWtihHotNew()
    }
}

/// 请求接口方法
extension OpenSourceLibraryVm {
    func requestWtihHotNew() {
        isLoadingInfo = true
        
        let groupQueue = DispatchGroup()
        let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
        
        // 线程执行完毕调用方法
        defer {
            groupQueue.notify(queue: DispatchQueue.main) {
                debugPrint("执行完成\(Thread.current)")
                self.isLoadingInfo = false
            }
        }
       
        // 开辟热门线程
        groupQueue.enter()
        queue.async() {
            self.requestWithHot(groupQueue: groupQueue)
        }
        // 开辟新星线程
        groupQueue.enter()
        queue.async() {
            self.requestWithNewstar(groupQueue: groupQueue)
        }
    }
    
    // MARK: 请求热门接口
    func requestWithHot(groupQueue: DispatchGroup) {
        let hotlist = OpenSourceLibraryApi.hotlist(p: .init(pageNum: 0, pageSize: 30, categoryId: categoryId))
        Networking.requestArray(hotlist, modeType: OpenSourceLibraryModel.self, atKeyPath: "data.list") { [weak self] r, list in
            guard let self = self else{
                return
            }
            if let list = list{
                self.hotList = list
            }else{
                
            }
            groupQueue.leave()
        }
    }
    
    // MARK: 请求新星接口
    func requestWithNewstar(groupQueue: DispatchGroup) {
        let newstar = OpenSourceLibraryApi.newstar(p: .init(pageNum: 0, pageSize: 30, categoryId: categoryId))
        Networking.requestArray(newstar, modeType: OpenSourceLibraryModel.self, atKeyPath: "data.list") { [weak self] r, list in
            guard let self = self else{
                return
            }
            if let list = list{
                self.newStarList = list
            }else{
                
            }
            groupQueue.leave()
        }
    }
    
    // MARK: 请求语言分类接口
    func requestWithCategoryList() {
        isLoadingCategory = true
        Networking.requestArray(OpenSourceLibraryApi.category, modeType: OpenSourceCategoryModel.self) { [weak self] r, list in
            guard let self = self else { return }
            if let list = list{
                self.categoryList = list
            }else{
                
            }
            // 判断选中
            if self.categoryId.isEmpty == false || self.categoryList.count > 0 {
                if let index = self.categoryList.firstIndex(where: {$0.id == self.categoryId}) {
                    self.categoryList[index].isSelect = true
                }
            }
            self.isLoadingCategory = false
        }
    }
}
