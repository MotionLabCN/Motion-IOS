//
//  NextView.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/14.
//

import SwiftUI

struct NextView: View {
    @EnvironmentObject var uiStateObj: AppState.TabbarState
    
    @State var isShowToast = false
    
    @State var isShow = false
    var body: some View {
        NavigationView {
            Button {
                isShowToast.toggle()
            } label: {
                Image.mt.load(.ATM)
            }

            List(0..<10) { _ in
                Text("123")
            }
        }
//        .mtFullScreen($isShow)
        
        
    }
}

struct MTFullScreenViewModifier: ViewModifier {
    @Binding var isShow: Bool
    
    func body(content: Content) -> some View {
        Group {
            
        }
    }

}

public extension View {
    func mtFullScreen(_ isShow: Binding<Bool>) -> some View {
        modifier(MTFullScreenViewModifier(isShow: isShow))
    }
}

















struct NextView_Previews: PreviewProvider {
    static var previews: some View {
        NextView()
            .environmentObject(AppState.TabbarState())
    }
}
