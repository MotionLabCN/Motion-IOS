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
        NavigationView {
            List(0..<10) { _ in
                Text("123")
            }
        }
        
    }
}

struct NextView_Previews: PreviewProvider {
    static var previews: some View {
        NextView()
            .environmentObject(AppState.TabbarState())
    }
}
