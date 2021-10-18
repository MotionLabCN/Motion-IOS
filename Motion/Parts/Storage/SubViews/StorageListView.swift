//
//  StorageListView.swift
//  Motion
//
//  Created by Beck on 2021/10/18.
//

import SwiftUI
import MotionComponents


struct StorageListView: View {
    
    @State var isPushWeb: Bool = false
    @State var webUrlString: String = ""
    
    var itemList: [ShardStorageModel] = [
        ShardStorageModel(shardStyle: .windows),
        ShardStorageModel(shardStyle: .linux)
    ]
    
    var body: some View {
        ScrollView {
            ForEach(itemList) { item in
                cellItem(item: item)
                    .background(item.backgroundColor.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal,10)
                    .onTapGesture {
                        isPushWeb.toggle()
                        webUrlString = item.webUrl
                    }
            }
            .mtRegisterRouter(isActive: $isPushWeb) {
                MTWebView(urlString: webUrlString)
            }
        }
    }
    
    //MARK:cell
    @ViewBuilder
    func cellItem(item: ShardStorageModel) -> some View {
        HStack {
            VStack(alignment:.leading) {
                Image.mt.load(.Github)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(item.backgroundColor)
                    )
                
                Text(item.name)
                    .foregroundColor(item.color)
                    .font(.mt.body1.mtBlod())
                
                Text("操作系统版本")
                    .foregroundColor(item.color)
                    .font(.mt.body1)
            }
            .padding(.vertical,10)
            Spacer()
            VStack(alignment:.trailing) {
                Image.mt.load(.Chevron_right_On)
                
                Image.mt.load(.Github)
                    .resizable()
                    .foregroundColor(item.color.opacity(0.3))
                    .frame(width: 80, height: 80)
            }
        }
        .padding(.init(horizontal: 20, vertical: 0))
    }
}


struct ShardStorageModel: Identifiable {
    let id = UUID().uuidString
    var name: String {
        switch shardStyle {
        case .windows: return "Windows"
        case .linux: return "Linux"
        }
    }
    
    let desc: String = "操作系统版本"
    
//    var image: String
    var color: Color {
        switch shardStyle {
        case .windows: return Color.blue
        case .linux: return Color.pink
        }
    }
    
    var backgroundColor: Color {
        switch shardStyle {
        case .windows: return Color.blue
        case .linux: return Color.pink
        }
    }
    
    // 调整web
    var webUrl: String {
        switch shardStyle {
        case .windows: return "https://gitbook.ttchain.tntlinking.com/%E7%AE%97%E5%8A%9B/02-%E5%8A%A0%E5%85%A5%E5%AD%98%E5%82%A8%E8%8A%82%E7%82%B9_Windows.html"
        case .linux: return "https://gitbook.ttchain.tntlinking.com/%E7%AE%97%E5%8A%9B/01-%E5%8A%A0%E5%85%A5%E5%AD%98%E5%82%A8%E8%8A%82%E7%82%B9_Linux.html"
        }
    }
    var shardStyle: ShardStyle
    
    enum ShardStyle {
        case windows, linux
    }
}




struct StorageListView_Previews: PreviewProvider {
    static var previews: some View {
        StorageListView()
    }
}
