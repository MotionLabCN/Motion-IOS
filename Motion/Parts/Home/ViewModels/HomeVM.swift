//
//  HomeVM.swift
//  Motion
//
//  Created by 梁泽 on 2021/10/6.
//

import Combine
import MotionComponents

class HomeVM: ObservableObject {
    let page = PageRequest()
    init() {
        print("HomeVM init")
        requestPostList()
    }
    

    
    func requestPostList() {
        Networking.request(PostApi.get(type: .首页, p: page)) { result in
            print("sss")
        }
    }
}
