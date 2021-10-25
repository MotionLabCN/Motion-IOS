//
//  OpenSourceLibraryVm.swift
//  Motion
//
//  Created by Beck on 2021/10/25.
//


import MotionComponents

class OpenSourceLibraryVm : ObservableObject{
    @Published var isShowCategory: Bool = false //显示语言
    @Published var isLoadingCategory: Bool = false //请求分类语言
    
    @Published var hotList : [OpenSourceLibraryModel] = []
    @Published var newStarList : [OpenSourceLibraryModel] = []
    
    @Published var categoryList: [OpenSourceCategoryModel] = []
    // 当前选中的分类语言id
    var categoryId: String = ""
    var categoryName: String = ""
    
    init(){
        request()
    }
    
    func request(){
        let hotlist = OpenSourceLibraryApi.hotlist(p: .init(pageNum: 0, pageSize: 30, categoryId: categoryId))
        let newstar = OpenSourceLibraryApi.newstar(p: .init(pageNum: 0, pageSize: 30, categoryId: categoryId))
        Networking.requestArray(hotlist, modeType: OpenSourceLibraryModel.self, atKeyPath: "data.list") { [weak self] r, list in
            guard let self = self else{
                return
            }
            if let list = list{
                self.hotList.append(contentsOf: list)
            }else{
                
            }
        }
        Networking.requestArray(newstar, modeType: OpenSourceLibraryModel.self, atKeyPath: "data.list") { [weak self] r, list in
            guard let self = self else{
                return
            }
            if let list = list{
                self.newStarList.append(contentsOf: list)
            }else{
                
            }
        }
    }
    
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
//                    self.categoryId = self.categoryList[index].categoryId
                }
            }
            self.isLoadingCategory = false
        }
    }
    
    // MARK: 修改数据
    func updateLangItems(item: OpenSourceCategoryModel) {
        
        if let index = categoryList.firstIndex(where: {$0.isSelect == true}) {
            categoryList[index].isSelect = false
        }
        
        if let index = categoryList.firstIndex(where: {$0.id == item.id}) {
            self.categoryList[index].isSelect = true
            categoryId = self.categoryList[index].id
            categoryName = self.categoryList[index].name
        }
        isShowCategory.toggle()
        request()
    }
}
