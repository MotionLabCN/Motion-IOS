//
//  LiVM.swift
//  Motion
//
//  Created by 梁泽 on 2021/10/14.
//

import Combine
import SwiftUI
import MotionComponents


class LiVM: ObservableObject {
    
    @Published var items = [LiModel]()
    
    @Published var phone = ""
    @Published var name = ""
    
    init() {
        requestDataForThree()
    }
    
    
    func requestDataForOne() {
        Networking.requestArray(ListApi.one, modeType: LiModel.self, atKeyPath: "data.content") { [weak self] _, list in
            self?.items = list ?? []
        }
    }
    
    func requestDataForTwo() {
        var req = ListApi.TwoParameters()
        req.phone = "xxx"
        req.name = "xxx"
        
        Networking.requestArray(ListApi.two(p: req), modeType: LiModel.self) { [weak self] r, list in
            self?.items = list ?? []
        }
    }
    
    @Published var logicList = LogicList()
    func requestDataForThree() {
        logicList.isRequesting = true
        
        /// 模拟接口
        DispatchQueue.main.asyncAfter(deadline: .now() + 12) {
            self.logicList.isRequesting = false
            
            self.items = MockTool.readArray(LiModel.self, fileName: "codepower_langs") ?? []
            
            if self.items.count >= 0 {
                self.logicList.isShowToast = true
                self.logicList.toastText = "接口返回的"
            }
        }
        
        
    }
    
}

extension LiVM  {
    //
    struct LogicList {
        var isRequesting = false
        
        var isShowToast = false
        var toastText = ""
    }
    
   
}


struct LiV: View {
    @StateObject var vm = LiVM()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.items) { item in
                    Text(item.dictKey)
                }
            }
        }
        .mtTopProgress(vm.logicList.isRequesting, usingBackgorund: true)
        .mtToast(isPresented: $vm.logicList.isShowToast, text: vm.logicList.toastText, style: .danger)
        
    }
}
