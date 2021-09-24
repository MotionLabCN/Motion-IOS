//
//  MTSheetManager.swift
//  MotionDesgin
//
//  Created by 梁泽 on 2021/9/23.
//

import SwiftUI



private class MTSheetManager: ObservableObject {
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
    func showContent<Content: View>(_ isPresented: Binding<Bool>, isCanDrag: Bool = false, @ViewBuilder content: () -> Content) -> MTSheetModel {
        let item = MTSheetModel(isPresented: isPresented, isCanDrag: isCanDrag, content: AnyView(content()))
        items.append(item)
        return item
    }
}




private struct MTSheetModel: Identifiable {
    let id = UUID()
    @Binding fileprivate var isPresented: Bool
    let isCanDrag: Bool
    fileprivate var content: AnyView
    
//    func sheetView() -> some View {
//        MTSheetView(isPresented: $isPresented, isCanDrag: isCanDrag) {
//            content
//        }
//        
//    }
}


//struct MTSheetView<MTContent: View>: View  {
//    @Binding var isPresented: Bool
//    let isCanDrag: Bool
//    @ViewBuilder let content: MTContent
//
//    var body: some View {
//        if isCanDrag {
//            Rectangle()
//                .fill(Color.clear)
//                .modifier(
//                    MTSheetDragViewModifier(isPresented: $isPresented, onDismiss: nil, mtContent: {
//                        content
//                    })
//                )
//        } else {
//            Rectangle()
//                .fill(Color.clear)
//                .modifier(
//                    MTSheetNoramlViewModifier(isPresented: $isPresented, onDismiss: nil, mtContent: {
//                        content
//                    })
//                )
//        }
//
//    }
//
//}

