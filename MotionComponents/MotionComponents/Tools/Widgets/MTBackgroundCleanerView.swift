//
//  FullScreenCover+mt.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/24.
//

import SwiftUI


public struct MTBackgroundCleanerView: View {
    public init() {
        
    }
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
            let superView = view.superview?.superview
            superView?.backgroundColor = .clear
            superView?.layer.shadowColor = UIColor.clear.cgColor
            superView?.layer.shadowRadius = 0
            superView?.layer.shadowOpacity = 0
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
