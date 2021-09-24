//
//  MTSheetManager.swift
//  MotionDesgin
//
//  Created by 梁泽 on 2021/9/23.
//

import SwiftUI



class MTSheetManager: ObservableObject {
    @Published var items = [MTSheetModel]()
    static let shared = MTSheetManager()
    
    func drop(_ id: UUID?) {
        guard let id = id else {
            return
        }

        items = items.filter({ $0.id != id })
    }
    
    func drop(_ item: MTSheetModel?) {
        guard let item = item else {
            return
        }

        items = items.filter({ $0.id != item.id })
    }
    
    /// 根据isPresented来显示 配置一次
    @discardableResult
    func showContent<Content: View>(_ isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) -> MTSheetModel {
        let item = MTSheetModel(isPresented: isPresented, content: AnyView(content()))
        items.append(item)
        return item
    }
    
//    private func showContent<Content: View, Item: Identifiable>(item: Binding<Item?>, @ViewBuilder content: (Item?) -> Content) {
//        var resultContent = AnyView(EmptyView())
//        if let i = item.wrappedValue {
//            resultContent = AnyView(content(i))
//        }
//        let item = MTSheetModel(isPresented: .constant(false), content: resultContent)
//        items.append(item)
//    }
}




struct MTSheetModel: Identifiable {
    let id = UUID()
    @Binding fileprivate var isPresented: Bool
    fileprivate var content: AnyView
    
    func sheetView() -> some View {
        MTSheetView(isPresented: $isPresented) {
            content
        }
        
    }
}
