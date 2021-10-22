//
//  RecommendVM.swift
//  Motion
//
//  Created by 梁泽 on 2021/10/22.
//

import Combine
import MotionComponents

class RecommendVM: ObservableObject {
//    static let shared = RecommendVM()
    
    let page = PageRequest()
    @Published var list = [PostItemModel]()
    init() {
        print("RecommendVM init")
        page.pageSize = 50
        requestPostList()
    }
    

    @Published var requestPostListStatus = RequestStatus.prepare
    func requestPostList() {
        requestPostListStatus = .requesting
        
        Networking.requestArray(PostApi.get(type: .热门, p: page), modeType: PostItemModel.self, atKeyPath: "data.list") { [weak self] _, l in
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
