//
//  HomeVM.swift
//  Motion
//
//  Created by 梁泽 on 2021/10/6.
//

import Combine
import MotionComponents

class HomeVM: ObservableObject {
    static let shared = HomeVM()
    
    let page = PageRequest()
    @Published var list = [PostItemModel]()
    init() {
        print("HomeVM init")
        page.pageSize = 50
        requestPostList()
    }
    

    @Published var requestPostListStatus = RequestStatus.prepare
    func requestPostList() {
        requestPostListStatus = .requesting
        
        Networking.requestArray(PostApi.get(type: .首页, p: page), modeType: PostItemModel.self, atKeyPath: "data.list") { [weak self] _, l in
            guard let self = self else { return }
            
            self.requestPostListStatus = .completion
            
            self.list = l ?? []
        
        }
       
    }
    
    func refresh() {
        page.reset()
        requestPostList()
    }
}
