//
//  OpenSourceLibraryVm.swift
//  Motion
//
//  Created by Beck on 2021/10/25.
//


import MotionComponents

class OpenSourceLibraryVm : ObservableObject{
    @Published var isShowLang: Bool = false //显示语言
    @Published var hotList : [OpenSourceLibraryModel] = []
    @Published var newStarList : [OpenSourceLibraryModel] = []
    
    @Published var langList = []
    
    init(){
        request()
    }
    func request(){
        let hotlist = OpenSourceLibraryApi.hotlist(p: .init(pageNum: 0, pageSize: 30, categoryId: 2))
        let newstar = OpenSourceLibraryApi.newstar(p: .init(pageNum: 0, pageSize: 30, categoryId: 2))
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
    
    func githubList() {
        Networking.requestArray(OpenSourceLibraryApi.langList, modeType: OpenSourceCategoryModel.self) { [weak self] r, list in
            guard let self = self else { return }
            self.langList
        }
    }
}
