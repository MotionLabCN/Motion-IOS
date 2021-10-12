//
//  NoticeListView.swift
//  Motion
//
//  Created by Beck on 2021/10/9.
//

import SwiftUI
import MotionComponents

struct NoticeListView: View {
    @State private var notifListVM: NotifListVM = NotifListVM()
    
    var body: some View {
        ScrollView {
            ForEach(notifListVM.list) { item in
                NotificationItemCell(item: item)
                Divider.mt.defult()
            }
        }
    }
    

}

struct NoticeListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NoticeListView()
        }
    }
}


// MARK: 通知cell
struct NotificationItemCell: View {
    let item: NotifiListModel
    var body: some View {
        HStack(alignment: .top,spacing:10) {
            Image(systemName: "heart.fill")
                .foregroundColor(
                    item.notifStyle == .charging ? .purple : .green
                )
            VStack {
                UserIconListView
                
                TitleMsgView
                
                if item.notifStyle == .charging {
                    Text(item.text)
                        .font(.mt.body3, textColor: .mt.gray_600)
                }
            }
        }
        .padding(10)
    }
    
    // MARK: 用户头像
    var UserIconListView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing:10) {
                ForEach(0..<50) { index in
                    Circle()
                        .fill(Color.red)
//                    Image.mt.load(.Search)
                        .frame(width: 40, height: 40)
                }
            }
        }
    }
    
    // MARK: 富文本标题
    @ViewBuilder
    var TitleMsgView: some View {
        
        let custom = ActiveType.custom(pattern: "路人甲|小奶瓶|324,244.00")
        
        MTRichText("路人甲和小奶瓶等6人，为你的动态充能共计324,244.00 TTC。")
            .textColor(.mt.gray_800, font: .mt.body3)
            .customTypes([ActiveType.custom(pattern: "路人甲|小奶瓶|324,244.00")])
            .configureLinkAttribute { type, attri, _ in
                var mattri = attri
                switch type {
                case .custom:
                    mattri[.font] = UIFont.mt.body3.mtBlod()
                    mattri[.foregroundColor] = UIColor.mt.gray_900
                default:  break
                }
                return mattri
            }
            .onCustomTap(for: custom) { text in
                print("click \(custom) text: \(text)")
            }
    }
}
