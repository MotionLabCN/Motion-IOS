//
//  ScrollableTabbar.swift
//  ScrollableTabbar
//
//  Created by Liseami on 2021/9/16.
//

import SwiftUI

struct ScrollableTabView<Content : View> : UIViewRepresentable {
    
    var content : Content
    var rect : CGRect
    @Binding var offset : CGFloat
    let scrollview = UIScrollView()
    var tabs : [Any]
   
    init(tabs:[Any],rect:CGRect,offset:Binding<CGFloat>,@ViewBuilder content : ()-> Content){
        self.content = content()
        self._offset = offset
        self.rect = rect
        self.tabs = tabs
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        
        setUpScrollView()
        scrollview.contentSize = CGSize(width: rect.width * CGFloat(tabs.count), height: rect.height)
        scrollview.addSubview(extractView())
        scrollview.delegate = context.coordinator
        return scrollview
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        if uiView.contentOffset.x != offset{
            uiView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
        }
    }
    
    func setUpScrollView(){
        scrollview.isPagingEnabled = true
        scrollview.bounces = false
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.alwaysBounceVertical = false
   
        
    }
    
    func extractView() -> UIView{
        let controller = UIHostingController(rootView: content)
        controller.view.frame = CGRect(x: 0, y: 0, width: rect.width * CGFloat(tabs.count), height: rect.height)
        return controller.view!
    }
    
    func makeCoordinator() -> Coordinator {
        return ScrollableTabView.Coordinator(partent: self)
    }
    
    class Coordinator : NSObject,UIScrollViewDelegate {
        var partent : ScrollableTabView
        init(partent:ScrollableTabView){
            self.partent = partent
        }
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            partent.offset = scrollView.contentOffset.x
        }
    }
    
}
