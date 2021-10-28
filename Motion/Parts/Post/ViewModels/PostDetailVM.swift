//
//  PostDetailVM.swift
//  Motion
//
//  Created by 梁泽 on 2021/10/26.
//

import MotionComponents
import Combine

class PostDetailVM: ObservableObject {
    
    @Published var model: PostItemModel = .init()
    
    @Published var requestPostDetail = RequestStatus.prepare
    
    func getDetail(_ item: PostItemModel) {
        model = item
    }
}
