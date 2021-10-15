//
//  FindView.swift
//  FindView
//
//  Created by Liseami on 2021/9/16.
//

import SwiftUI
import MotionComponents
import Lottie

//public var findViewTabs = ["码力","开源","热门","天梯","公司"]

struct FindTestView: View {
    
    // MARK: 码力集市价格语言
    @EnvironmentObject var findView: FindViewState

    @StateObject var findVM: FindVM = FindVM()
    
    @State private var offset : CGFloat = 0
    var body: some View {
        

        VStack(spacing:0){
            
            MTPageSegmentView(titles: findViewTabs, offset: $offset)

            MTPageScrollView(offset: $offset) {
                HStack(spacing: 0) {
                    Group {
                        CodepowerView()
                            .environmentObject(findVM)
                        Ladder()

                        OpenSourceLibrary()

                        RecommendView()
                    }
                    .frame(width: ScreenWidth())
                }
            }
        }
        .onAppear(perform: {
            print("sssss")
        })
        .frame(width: ScreenWidth())
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
        // 一级分类弹框
        .mtSheet(isPresented: $findVM.isShowmtsheet) {} content: {
            VStack {
                CodeItemList
                .mtTopProgress(findVM.logicCode.isRequesting, usingBackgorund: true)
                .mtToast(isPresented: $findVM.logicCode.isShowToast, text: findVM.logicCode.toastText)
                
                HStack(spacing:20) {
                    Button {
                        print("\(findVM.selectFindModel.subTitle)")
                        findVM.clearItems()
                    } label: {
                        Text("重置")
                    }
                    .mtButtonStyle(.smallStorker(isEnable: true))

                    Button {
                        findVM.isShowmtsheet.toggle()
                        
                        // 请求接口
                        findVM.requestWithProductList()
                        
                    } label: {
                        Text("应用")
                            .foregroundColor(.white)
                            .font(.mt.body1)
                    }
                    .mtButtonStyle(.mainDefult(isEnable: true))
                }
                .padding(.horizontal,20)
           }
            .padding(.vertical,20)
        }
        // 二级分类弹框
        .sheet(isPresented: $findVM.isShowmtDetail) {
//            SecondItemListView
            ProductList
        }
        .mtTopProgress(findVM.logicProduct.isRequesting, usingBackgorund: true)
        .mtToast(isPresented: $findVM.logicProduct.isShowToast, text: findVM.logicProduct.toastText)
    }
    
    
    // MARK:码力集市item List 一级分类列表
    var CodeItemList: some View {
        List {
            ForEach(findVM.itemList) { item in
                HStack(spacing: 6) {
                    Image(systemName: "heart.fill")
                        .frame(width: 30, height: 30)
                    
                    Text(item.title)
                        .font(.mt.body1, textColor: .mt.gray_900)
                    Spacer()
                    Text(item.showText)
                        .font(.mt.body2, textColor: .mt.gray_800)
                }
                .contentShape(Rectangle())
                .onTapGesture(perform: {
                    // 获取一级分类下 当前选中的二级分类列表数据.
                    if let index = findVM.itemList.firstIndex(where: {$0.id == item.id}) {
                        findVM.selectIndex = index
                        findVM.selectFindModel = item
                    }
                    
                    findVM.isShowmtDetail.toggle()
                })
                .frame(height:30)
            }
            .listStyle(PlainListStyle())
        }
    }
    
    
    // MARK: 二级分类下列表数据
    var SecondItemListView: some View {
        // 方法2
//        @Environment(\.presentationMode) var presentationMode
            ZStack (alignment: .topTrailing) {
                Button {
                    findVM.isShowmtDetail.toggle() // 方法1通过外面bool
                    
                    //                presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("完成")
                        .font(.mt.body1, textColor: .blue)
                }
                .padding(20)
                
                VStack {
                    Text(findVM.selectFindModel.title)
                        .font(.mt.title2, textColor: .mt.gray_900)
                        .padding()
                    List {
                        
                        switch findVM.selectCodeSelectStyle {
                        case .lang:
                            LangListView
                            
                        case .to:
                            TechnologyListView
                            
                        case .price:
                            PriceListView
                        default:
                            Text("findVM.selectFindModel.dictKey")
                               .font(.mt.title2, textColor: .mt.gray_900)
                               .padding()
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
        }
    
    @ViewBuilder
    var ProductList : some View {
        //        let columns: [GridItem] = [
        //            GridItem(.adaptive(minimum: 100, maximum: 150)), // 范围内自动计算width
        //        ]
        let cardWidth = (ScreenWidth() - 40 - 20 ) / 3
        //排序方式
        let columns =
        Array(repeating:  GridItem(.fixed(cardWidth)), count: 3)
        
        ScrollView {
            
            // 网格列表
            LazyVGrid(columns: columns,
                      alignment: .center,
                      spacing: 20,
                      //                      pinnedViews: [.sectionHeaders],
                      content: {
                Section(header:
                            Text(findVM.selectFindModel.title)
                            .font(.mt.title2, textColor: .mt.gray_900)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                ){
                    switch findVM.selectCodeSelectStyle {
                    case .lang:
                        LangListView
                        
                    case .to:
                        TechnologyListView
                        
                    case .price:
                        PriceListView
                        
                    default:
                        Text("加载中....")
                    }
                }
            })
        }
    }
    
    
    //MARK: 语言view
    var LangListView: some View {
//        ForEach(findVM.selectFindModel.data) { item in
//            HStack {
//                Text(item.dictKey)
//                    .font(.mt.body1, textColor: item.isSelect ? .blue : .mt.gray_900)
//                Spacer()
//                Image(systemName: item.isSelect ? "checkmark.circle" : "circle")
//                    .foregroundColor(item.isSelect ? .green : .red)
//            }
//            .padding(5)
//            .contentShape(Rectangle())
//            .onTapGesture(perform: {
//                // 选中和取消
////                                findVM.updateItem(item: item)
//                findVM.updateItes(item: item)
//            })
//        }
        ForEach(findVM.selectFindModel.data) { item in
            
            HStack {
                Text(item.dictKey)
                    .font(.mt.body1, textColor: item.isSelect ? .blue : .mt.gray_900)
                    .frame(height:40)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal,16)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.mt.gray_200)
            )
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(item.isSelect ? Color.blue : .mt.gray_200, lineWidth: 1)
            )
            .contentShape(Rectangle())
            .onTapGesture(perform: {
                // 选中和取消
                findVM.updateItes(item: item)
            })
        }
    }
    //MARK: 技术view
    var TechnologyListView: some View {
//        ForEach(findVM.selectFindModel.technologyList) { item in
//            HStack {
//                Text(item.labelName)
//                    .font(.mt.body1, textColor: item.isSelect ? .blue : .mt.gray_900)
//                Spacer()
//                Image(systemName: item.isSelect ? "checkmark.circle" : "circle")
//                    .foregroundColor(item.isSelect ? .green : .red)
//            }
//            .padding(5)
//            .contentShape(Rectangle())
//            .onTapGesture(perform: {
//                // 选中和取消
////                                findVM.updateItem(item: item)
////                                    findVM.updateItes(item: item)
//                findVM.updateTechnologyItes(item: item)
//            })
//        }
        ForEach(findVM.selectFindModel.technologyList) { item in
            
            HStack {
                Text(item.labelName)
                    .font(.mt.body1, textColor: item.isSelect ? .blue : .mt.gray_900)
                    .frame(height:40)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal,16)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.mt.gray_200)
            )
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(item.isSelect ? Color.blue : .mt.gray_200, lineWidth: 1)
            )
            .contentShape(Rectangle())
            .onTapGesture(perform: {
                // 选中和取消
                findVM.updateTechnologyItes(item: item)
                
            })
        }
    }
    //MARK: 价格view
    var PriceListView: some View {
//        ForEach(findVM.selectFindModel.priceList) { item in
//            HStack {
//                Text(item.dictKey)
//                    .font(.mt.body1, textColor: item.isSelect ? .blue : .mt.gray_900)
//                Spacer()
//                Image(systemName: item.isSelect ? "checkmark.circle" : "circle")
//                    .foregroundColor(item.isSelect ? .green : .red)
//            }
//            .padding(5)
//            .contentShape(Rectangle())
//            .onTapGesture(perform: {
//                // 选中和取消
//                findVM.updateItes(item: item)
//            })
//        }
        ForEach(findVM.selectFindModel.priceList) { item in
            HStack {
                Text(item.dictKey)
                    .font(.mt.body1, textColor: item.isSelect ? .blue : .mt.gray_900)
                    .frame(height:40)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal,16)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.mt.gray_200)
            )
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(item.isSelect ? Color.blue : .mt.gray_200, lineWidth: 1)
            )
            .contentShape(Rectangle())
            .onTapGesture(perform: {
                // 选中和取消
                findVM.updateItes(item: item)
            })
        }
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
