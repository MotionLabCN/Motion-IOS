//
//  LocUserAvatar.swift
//  Motion
//
//  Created by Liseami on 2021/9/23.
//

import SwiftUI
import Kingfisher


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
                .placeholder {
                    Image("touxiang")
                        .resizable()
                        .clipShape(Capsule(style: .continuous))
                }
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
        MTAvatar(frame: frame, urlString: UserManager.shared.user.avatarUrl) {
            
        }

    }
}




struct LocUserAvatar_Previews: PreviewProvider {
    static var previews: some View {
        MTLocUserAvatar()
    }
}
