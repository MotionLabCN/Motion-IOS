//
//  ScrollableTabbar.swift
//  ScrollableTabbar
//
//  Created by Liseami on 2021/9/16.
//

import SwiftUI

struct ScrollableTabbar<Content : View> : UIViewRepresentable {
    
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
        return scrollview
    }
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
    }
    
    func setUpScrollView(){
        scrollview.isPagingEnabled = true
        scrollview.bounces = false
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
        
    }
    
    func extractView() -> UIView{
        
        let controller = UIHostingController(rootView: content)
        controller.view.frame = CGRect(x: 0, y: 0, width: rect.width * CGFloat(tabs.count), height: rect.height)
        return controller.view!
    }
}
