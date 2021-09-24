//
//  LocUserAvatar.swift
//  Motion
//
//  Created by Liseami on 2021/9/23.
//

import SwiftUI


struct MTLocUserAvatar: View {
    
    var frame : CGFloat = 36
    var body: some View {
        Button {
         
        } label: {
        Image("touxiang")
                .resizable()
                .scaledToFill()
            .frame(width: frame, height: frame)
            .clipShape(Capsule(style: .continuous))
        }
    }
}

struct MTUserAvatar: View {
    
    var frame : CGFloat = 36
    var action : () -> Void
    
    var body: some View {
        Button {
          action()
        } label: {
        Image("touxiang")
                .resizable()
                .scaledToFill()
            .frame(width: frame, height: frame)
            .clipShape(Capsule(style: .continuous))
        }
    }
}



struct LocUserAvatar_Previews: PreviewProvider {
    static var previews: some View {
        MTLocUserAvatar()
    }
}
