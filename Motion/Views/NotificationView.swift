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
    @EnvironmentObject var fullscreen : AppState.TopFullScreenPage
    @State var tag  =  notificationViewTabs[0]
    
    var body: some View {
        VStack(spacing:0){
            //TOP Tabbar
            FindViewTopTabBar(tag: $tag, items: notificationViewTabs)
                TabView(selection: $tag, content:{ //tabview start
                    MessageView().tag(notificationViewTabs[0])
                    MessageView().tag(notificationViewTabs[1])
                    MessageView().tag(notificationViewTabs[2])
                    MessageView().tag(notificationViewTabs[3])
                    }) //tabview end
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .transition(.slide)
            
        }
        .navigationBarHidden(true)
        .padding(.top,44)
        .navigationBarTitleDisplayMode(.inline)
        .mtNavbar(content: {
            Text("新消息")
                .font(.mt.body1.mtBlod(),textColor: .black)
        }, leading: {
            MTLocUserAvatar()
        }, trailing: {
            SettingBtn()
        })
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
