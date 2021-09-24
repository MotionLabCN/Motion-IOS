//
//  FullScreenCover+mt.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/24.
//

import SwiftUI

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



public struct MTBackgroundCleanerView: View {
    public var body: some View {
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
