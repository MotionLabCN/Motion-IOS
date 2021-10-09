//
//  NotifiListModel.swift
//  Motion
//
//  Created by Beck on 2021/10/9.
//

import Foundation

struct NotifiListModel: Identifiable {
    
    enum NotifStyle {
        case charging       //充能消息
        case followMore     // 多人关注我
//        case followJustOne  // 一个人关注我
//        case updataInfo     // 好友近期更新消息
//        case followOther    // 同时关注另外一个人
    }
    
    var id = UUID().uuidString
    var notifStyle: NotifStyle = .charging
    // 内容
    var text: String = ""
    
}
