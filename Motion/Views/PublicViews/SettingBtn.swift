//
//  SettingBtn.swift
//  Motion
//
//  Created by Liseami on 2021/9/23.
//

import SwiftUI
import MotionComponents

struct SettingBtn: View {
    
    var body: some View {
        Button(
            action: {
               
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
