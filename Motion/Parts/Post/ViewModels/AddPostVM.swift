//
//  AddPostVM.swift
//  Motion
//
//  Created by 梁泽 on 2021/10/20.
//

import MotionComponents
import Combine

class AddPostVM: ObservableObject {
    @Published var text = ""
    @Published var selectedPhotos : [UIImage] = []
    
    
    //MARK: - 发布
    @Published var requestAddPostStatus = RequestStatus.prepare
    func addPost() {
        // 1.先上传图片
        requestAddPostStatus = .requesting
        
        if selectedPhotos.isEmpty {
            releasePost(pics: [])
        } else {
            Networking.requestArray(OSSApi.upload(images: selectedPhotos), modeType: UploadFileResModel.self) { [weak self] r, list in
                if list.isNilOrEmpty {
                    self?.requestAddPostStatus = .completionTip(text: "上传图片失败", status: .danger)
                } else {
                    self?.releasePost(pics: list!)
                }
            }
        }
        
    }
    
    func releasePost(pics: [UploadFileResModel]) {
        var picArr: [PostApi.ReleaseParameters.PicItem] = []
        for (i, item) in pics.enumerated() {
            picArr.append(.init(seq: i + 1, picId: item.id))
        }
        
        let req: PostApi.ReleaseParameters = .init(content: text, pics: picArr)
        Networking.request(PostApi.release(p: req)) { [weak self] result in
            if result.isSuccess {
                self?.requestAddPostStatus = .completion
            } else {
                self?.requestAddPostStatus = .completionTip(text: result.message)
            }
        }
        
    }
}
