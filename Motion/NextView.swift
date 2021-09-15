//
//  NextView.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/14.
//

import SwiftUI

struct NextView: View {
    @EnvironmentObject var uiStateObj: AppState.TabbarState
    @Environment(\.presentationMode) var persentationMode
    
    var body: some View {
//        VStack {
            ZStack {
                List(0..<40) { _ in
                    Text("12314")
                    
                }
            }
            .onDisappear(perform: {
                withAnimation {
                    uiStateObj.isShowTabbar = true
                }
            })
//        }
    }
}

struct NextView_Previews: PreviewProvider {
    static var previews: some View {
        NextView()
            .environmentObject(AppState.TabbarState())
    }
}
