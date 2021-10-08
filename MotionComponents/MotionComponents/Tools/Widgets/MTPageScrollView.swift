//
//  ScrollableTabBar.swift
//  MotionDesgin
//
//  Created by 梁泽 on 2021/10/8.
//

import SwiftUI
/*
 the main reason that we have not used the page view style is because it is clearing the previous tab data when a new tab is being swiped
 the solution or fix may be prevoided in the next swiftui release
 another bug with page tab view is. that is not ignoring edges, to avoid this we have created custom view using view builder
 https://www.youtube.com/watch?v=Q6p4QyXa2Po
 */

public struct MTPageScrollView<Content: View>: View {
    let count: Int
    @Binding var offset: CGFloat
    let content: Content
    
    public var pageIndex: Int {
        Int(floor(offset + 0.5) / ScreenWidth())
    }
    
    public init(count: Int, offset: Binding<CGFloat> = .constant(0), @ViewBuilder content: () -> Content) {
        self.count = count
        self._offset = offset
        self.content = content()
    }

    public var body: some View {
        GeometryReader { proxy in
            let rect = proxy.frame(in: .global)
            
            ScrollableTabBar(count: count, rect: rect, offset: $offset, content:  {
                HStack(spacing: 0) {
                    content
                }
            })
        }
    }
}

struct ScrollableTabBar<Content: View>: UIViewRepresentable {
    var count: Int
    var rect: CGRect
    @Binding var offset: CGFloat

    @ViewBuilder var content: Content
    
    private let scrollView = UIScrollView()
    
    func makeUIView(context: Context) ->  UIScrollView {
        setupScrollView()
        
        let contentView = extractView()
        scrollView.contentSize = contentView.bounds.size
        scrollView.addSubview(contentView)
        
        scrollView.delegate = context.coordinator
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        if uiView.contentOffset.x != offset {
             uiView.delegate = nil
            UIView.animate(withDuration: 0.25) {
                uiView.contentOffset.x = offset
            } completion: { isCompletion in
                if isCompletion {
                    uiView.delegate = context.coordinator
                }
            }

        }
    }
    
    // setting up scrollView
    func setupScrollView() {
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    func extractView() -> UIView {
        let controller = UIHostingController(rootView: content)
        
        controller.view.frame = CGRect(origin: .zero, size: CGSize(width: rect.width * count.cgFloat, height: rect.height))
       
        return controller.view
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: ScrollableTabBar
        init(parent: ScrollableTabBar) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.offset = scrollView.contentOffset.x
        }
    }
}
