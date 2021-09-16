//
//  PostVM.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/16.
//

import SwiftUI
import Combine

class PostVM: ObservableObject {
    @Published var list: [PostModel] = []
    
    init() {
        /// 网络请求
    }
    
    func addItem(_ model: PostModel) {
        list += [model]
    }
    
    
}
