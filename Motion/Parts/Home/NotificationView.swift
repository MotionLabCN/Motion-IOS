//
//  NotificationView.swift
//  NotificationView
//
//  Created by Liseami on 2021/9/15.
//

import SwiftUI
import MotionComponents
fileprivate var notificationViewTabs = ["私信","通知","提及","小组"]

struct NotificationView: View {
    
    @State private var tag  =  notificationViewTabs[0]
    
    var body: some View {
        
                    NoticeListView()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
