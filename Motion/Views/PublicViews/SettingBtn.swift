//
//  SettingBtn.swift
//  Motion
//
//  Created by Liseami on 2021/9/23.
//

import SwiftUI
import MotionComponents

struct SettingBtn: View {
    @EnvironmentObject var fullscreen: AppState.TopFullScreenPage
    var body: some View {
        Button(
            action: {
                fullscreen.showFullScreen(view: FullScreenView(view: AnyView(SettingView())))
            },
            label: {
                Image
                    .mt.load(.Setting)
                    .foregroundColor(.mt.gray_900)
            }
        )
    }
}

struct SettingBtn_Previews: PreviewProvider {
    static var previews: some View {
        SettingBtn()
    }
}
