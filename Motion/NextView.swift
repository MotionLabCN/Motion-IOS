//
//  NextView.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/14.
//

import SwiftUI
import MotionComponents

struct NextView: View {
    @Environment(\.presentationMode) var  presentationMode
    @State private var isShowToast = false
    
    @State private var isShow = true
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
        .sheet(isPresented: $isShowToast) {
            
        } content: {
            Text("123")
        }
    }
}


















struct NextView_Previews: PreviewProvider {
    
    
    
    static var previews: some View {
        NextView()
    }
}
