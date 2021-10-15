//
//  NotifListVM.swift
//  Motion
//
//  Created by Beck on 2021/10/9.
//

import Foundation

class NotifListVM: ObservableObject {
    
    @Published var list: [NotifiListModel] = [
        NotifiListModel(notifStyle: .charging, text: "动态详情动态详情动态详情动态详情动态详情动态详情动态详情动态详情动态详情动态详情动态详情动态详情动态详情动态详情动态详情动态详情动态详情。"),
        NotifiListModel(notifStyle: .followMore),
        NotifiListModel(notifStyle: .charging, text: "111动态详情动态详情动态详情动态详情详情动态详情。"),

    ]
    
    init() {
        print("NotifListVM init")
    }
}
