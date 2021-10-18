//
//  MTScrollView.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/10/18.
//

import SwiftUI


public struct MTScrollView<Content: View>: UIViewRepresentable {
    @Binding var offset: CGFloat

    var content: Content
    
    private let scrollView = UIScrollView()
    
    public init( offset: Binding<CGFloat>, @ViewBuilder content:  () -> Content) {
        self._offset = offset
        self.content = content()
    }
    
    public func makeUIView(context: Context) ->  UIScrollView {
        setupScrollView()
        
        let hostVc = UIHostingController(rootView: content)
        hostVc.view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            hostVc.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostVc.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),

            hostVc.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostVc.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            hostVc.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ]
        
        scrollView.addSubview(hostVc.view)
        scrollView.addConstraints(constraints)
        
        scrollView.delegate = context.coordinator
        return scrollView
    }
    
    public func updateUIView(_ uiView: UIScrollView, context: Context) {
        if uiView.contentOffset.x != offset {
             uiView.delegate = nil
//            UIView.animate(withDuration: 0.25) {
                uiView.contentOffset.x = offset
//            } completion: { isCompletion in
//                if isCompletion {
                    uiView.delegate = context.coordinator
//                }
//            }

        }
    }
    
    // setting up scrollView
    func setupScrollView() {
//        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }
    
  
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    public class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: MTScrollView
        init(parent: MTScrollView) {
            self.parent = parent
        }
        
        public func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.offset = scrollView.contentOffset.x
        }
    }
}
