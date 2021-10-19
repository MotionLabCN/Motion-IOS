//
//  MTAddPostView.swift
//  Motion
//
//  Created by 梁泽 on 2021/10/18.
//

import SwiftUI
import MotionComponents

struct MTAddPostView: View {
    @EnvironmentObject var tabbarState: TabbarState
    @EnvironmentObject var userManager: UserManager
    @State var isShowEditorPost = false
    
    var body: some View {
        VStack {
            Spacer()
            HStack{
                Spacer()
                Button {
                    isShowEditorPost.toggle()
                } label: {
                    Image.mt.load(.Add)
                        .foregroundColor(.white)
                }
                .mtButtonStyle(.cricleDefult(.mt.accent_700))
                .offset(y : -TabbarHeight - 16 )
            }
        }
        .padding(.horizontal,16)
        .opacity(tabbarState.isShowActionCricleBtn ? 1 : 0)
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .fullScreenCover(isPresented: $isShowEditorPost) {
            PostEditorView()
        }
    }
}

struct MTAddPostView_Previews: PreviewProvider {
    static var previews: some View {
        MTAddPostView()
    }
}
