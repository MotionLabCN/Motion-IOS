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
                    Image.mt.load(.Person)
                        .resizable()
                        .foregroundColor(.mt.gray_500)
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .clipShape(Capsule(style: .continuous))
                }
                .resizable()
                .scaledToFill()
                .mtFrame(square: frame)
                .background(Color.mt.gray_200)
                .clipShape(Capsule(style: .continuous))
        }
    }
}

class MTLocUserVM: ObservableObject {
    @Published var isShowProfile = false
}

struct MTLocUserAvatar: View {
//    @EnvironmentObject var vm: MTLocUserVM
    
    @StateObject var vm = MTLocUserVM()
    @State private var isgotonext = false
    
    var frame : CGFloat = 36
    var body: some View {
        MTAvatar(frame: frame, urlString: UserManager.shared.user.headImgUrl) {
//            router.profile.toggle()
            isgotonext.toggle()
        }
        .fullScreenCover(isPresented: $isgotonext) {
            ProfileView()
                .environmentObject(vm)
        }
        .mtRegisterRouter(isActive: $vm.isShowProfile) {
            Text("detail")
        }
                
    
    }
}




struct LocUserAvatar_Previews: PreviewProvider {
    static var previews: some View {
        MTLocUserAvatar()
    }
}
