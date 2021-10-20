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
    func addPost() {
        // 1.先上传图片
        if selectedPhotos.isEmpty {
            print("直接传吧")
            let picArr: [PostApi.ReleaseParameters.PicItem] = []
            let req: PostApi.ReleaseParameters = .init(content: "", pics: picArr)
            Networking.request(PostApi.release(p: req)) { result in
                print("")
            }
            
            
        } else {
            Networking.request(OSSApi.upload(images: selectedPhotos)) { result in
                print("xxx")
            }
        }
        
    }
}
