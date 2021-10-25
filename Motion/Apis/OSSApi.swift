//
//  OSSApi.swift
//  Motion
//
//  Created by 梁泽 on 2021/10/14.
//

import MotionComponents
import Moya

enum OSSApi: MTTargetType {
    case upload(images: [UIImage])


    
    
    var path: String {
        switch self {
        case .upload: return "api/gateway/motion-file/files/upload/batch/1"
        }
    }
    
    var method: HTTPRequestMethod {
        switch self {
        case .upload: return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .upload(images):
            let arr = images
                .compactMap({ $0 })
                .map({
                    MultipartFormData(provider: .data($0.jpegData(compressionQuality: 0.1)!), name: "files", fileName: "filename", mimeType: "png")
                })
            return .uploadMultipart(arr)
        }
    }

}
