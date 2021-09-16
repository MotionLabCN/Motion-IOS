//
//  NotificationView.swift
//  NotificationView
//
//  Created by Liseami on 2021/9/15.
//

import MotionComponents

struct NotificationView: View {
    var body: some View {
        ScrollView {
           NavigationLink("12345", destination: Text("detial"))
            .buttonStyle(MTButtonStyle(style: .mainDefult(isEnable: true)))
        }
        .mtAttatchTabbarSpacer()
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
