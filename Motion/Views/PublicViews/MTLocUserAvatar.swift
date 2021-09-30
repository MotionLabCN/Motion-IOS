//
//  LocUserAvatar.swift
//  Motion
//
//  Created by Liseami on 2021/9/23.
//

import SwiftUI
import Kingfisher

extension String: Resource {
    public var cacheKey: String { return "absoluteString" }
    public var downloadURL: URL { return URL(string: self)! }
}


struct MTAvatar: View {
    var frame : CGFloat
    var urlString: String?
    var action : () -> Void
    
    init(frame: CGFloat = 36, urlString: String? = nil, action: @escaping () -> Void) {
        self.frame = frame
        self.urlString = urlString
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            KFImage(urlString?.url)
//                .placeholder {
//                    Capsule(style: .continuous)
//                        .foregroundColor(.mt.gray_300)
//                        .overlay(
//                            Image.mt.load(.Person)
//                                .foregroundColor(.black)
//                        )
//                }
                .resizable()
                .scaledToFill()
                .mtFrame(square: frame)
                .clipShape(Capsule(style: .continuous))
        }
    }
}

struct MTLocUserAvatar: View {
    @State var isPresented = false
    var frame : CGFloat = 36

            
    var body: some View {
        MTAvatar(frame: frame, urlString: "https://avatars.githubusercontent.com/u/14833970?v=4") {
            
        }

    }
}




struct LocUserAvatar_Previews: PreviewProvider {
    static var previews: some View {
        MTLocUserAvatar()
    }
}
