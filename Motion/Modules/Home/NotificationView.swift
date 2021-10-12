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
        VStack(spacing:0){
            //TOP Tabbar
                TabView(selection: $tag, content:{ //tabview start
                    MessageView().tag(notificationViewTabs[0])
                    NoticeListView().tag(notificationViewTabs[1])
                    MessageView().tag(notificationViewTabs[2])
                    MessageView().tag(notificationViewTabs[3])
                    }) //tabview end
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .transition(.slide)
        }
        .padding(.top,44)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems( trailing:     SettingBtn())
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
