//
//  SettingBtn.swift
//  Motion
//
//  Created by Liseami on 2021/9/23.
//

import SwiftUI
import MotionComponents

struct SettingBtn: View {
    @State var showSettingView : Bool = false
    var body: some View {
        Button(
            action: {
                showSettingView.toggle()
            },
            label: {
                Image .mt.load(.Setting).foregroundColor(.mt.gray_900)
            }
        )
            .fullScreenCover(isPresented: $showSettingView) {
                SettingView()
            }
    }
}

struct SettingBtn_Previews: PreviewProvider {
    static var previews: some View {
        SettingBtn()
    }
}
