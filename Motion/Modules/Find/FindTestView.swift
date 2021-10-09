//
//  FindView.swift
//  FindView
//
//  Created by Liseami on 2021/9/16.
//

import SwiftUI
import MotionComponents

//public var findViewTabs = ["码力","开源","热门","天梯","公司"]

struct FindTestView: View {
    
    @EnvironmentObject var findView: FindViewState
    
    @State var offset : CGFloat = 0
    var body: some View {
        
        VStack(spacing:0){
            
            MTPageSegmentView(titles: findViewTabs, offset: $offset)
            
            MTPageScrollView(offset: $offset) {
                HStack(spacing: 0) {
                    Group {
                        CodepowerView()
                        
                        OpenSourceLibrary()
                        
                        RecommendView()
                        
                        Ladder()
                        
                        RecommendView()
                    }
                    .frame(width: ScreenWidth())
                }
            }
        }
        .mtNavbar(content: {
            Capsule().frame(width: 255, height: 32)
                .foregroundColor(.mt.gray_200)
                .overlay(HStack{
                    Image.mt.load(.Search)
                        .frame(width: 16, height: 16)
                    Text("搜索Motion")
                        .font(.mt.body3 )
                } .foregroundColor(.mt.gray_500)
                )
        }, leading: {
            MTLocUserAvatar()
        }, trailing: {
            SettingBtn()
        })
        .navigationBarTitleDisplayMode(.inline)
     
        
    }
    
   
 
    
}


//
//struct UIScrollViewWrapper<Content: View>: UIViewControllerRepresentable {
//    @Binding var offset: CGFloat
//
//    var content: () -> Content
//
//    private let vc = UIScrollViewViewController()
//
//    init(offset: Binding<CGFloat>,  @ViewBuilder content: @escaping () -> Content) {
//        self.content = content
//        self._offset = offset
//    }
//
//    func makeUIViewController(context: Context) -> UIScrollViewViewController {
//        vc.hostingController.rootView = AnyView(self.content())
//        vc.scrollView.delegate = context.coordinator
//        return vc
//    }
//
//    func updateUIViewController(_ viewController: UIScrollViewViewController, context: Context) {
//        viewController.hostingController.rootView = AnyView(self.content())
//
//        if viewController.scrollView.contentOffset.x != offset {
//            viewController.scrollView.delegate = nil
//            UIView.animate(withDuration: 0.25) {
//                viewController.scrollView.contentOffset.x = offset
//            } completion: { isCompletion in
//                if isCompletion {
//                    viewController.scrollView.delegate = context.coordinator
//                }
//            }
//
//
//        }
//    }
//
//    public func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self)
//    }
//
//    public class Coordinator: NSObject, UIScrollViewDelegate {
//        var parent: UIScrollViewWrapper
//        init(parent: UIScrollViewWrapper) {
//            self.parent = parent
//        }
//
//        public func scrollViewDidScroll(_ scrollView: UIScrollView) {
//            parent.offset = scrollView.contentOffset.x
//        }
//    }
//}
//
//class UIScrollViewViewController: UIViewController {
//
//    lazy var scrollView: UIScrollView = {
//        let v = UIScrollView()
//        v.isPagingEnabled = true
//        v.bounces = false
//        v.showsVerticalScrollIndicator = false
//        v.showsHorizontalScrollIndicator = false
//        v.backgroundColor = .red
//        return v
//    }()
//
//    var hostingController: UIHostingController<AnyView> = UIHostingController(rootView: AnyView(EmptyView()))
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.addSubview(self.scrollView)
//        self.pinEdges(of: self.scrollView, to: self.view)
//
//        self.hostingController.willMove(toParent: self)
//        self.scrollView.addSubview(self.hostingController.view)
//        self.pinEdges(of: self.hostingController.view, to: self.scrollView)
//        self.hostingController.didMove(toParent: self)
//
//    }
//
//    func pinEdges(of viewA: UIView, to viewB: UIView) {
//        viewA.translatesAutoresizingMaskIntoConstraints = false
//        viewB.addConstraints([
//            viewA.leadingAnchor.constraint(equalTo: viewB.leadingAnchor),
//            viewA.trailingAnchor.constraint(equalTo: viewB.trailingAnchor),
//            viewA.topAnchor.constraint(equalTo: viewB.topAnchor),
//            viewA.bottomAnchor.constraint(equalTo: viewB.bottomAnchor),
//        ])
//    }
//
//}
//









struct FindTestView_Previews: PreviewProvider {
    static var previews: some View {
        FindTestView()
    }
}
