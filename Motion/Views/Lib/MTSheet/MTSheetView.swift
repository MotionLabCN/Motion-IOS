//
//  MTSheet.swift
//  MotionDesgin
//
//  Created by 梁泽 on 2021/9/23.
//

import SwiftUI


struct MTSheetView<MTContent: View>: View  {
    @Binding var isPresented: Bool
    @ViewBuilder let content: MTContent
    

    var body: some View {
        Rectangle()
            .fill(Color.clear)
            .modifier(
                MTSheetViewModifier(isPresented: $isPresented, mtContent: {
                    content
                })
            )
    }
    
}








public extension View {
    func mtFullScreenCover<Content>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Content) -> some View where Content : View {
        fullScreenCover(isPresented: isPresented, onDismiss: onDismiss) {
            ZStack {
                MTBackgroundCleanerView()
                content()
            }
        }
    }
    
    func mtFullScreenCover<Item, Content>(item: Binding<Item?>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping (Item) -> Content) -> some View where Item : Identifiable, Content : View {
        fullScreenCover(item: item, onDismiss: onDismiss) { model in
            ZStack {
                MTBackgroundCleanerView()
                content(model)
            }
        }
    }

}



private struct MTBackgroundCleanerView: View {
    var body: some View {
        MTBackgroundCleanerViewRepresentable()
            .frame(size: .zero)
    }
}

private struct MTBackgroundCleanerViewRepresentable: UIViewRepresentable {
 
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            //superview = BackgroundCleanerView
            //superview = UIHostingView
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
