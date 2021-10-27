//
//  FindView.swift
//  FindView
//
//  Created by Liseami on 2021/9/16.
//

import SwiftUI
import MotionComponents
import Lottie

public var findViewTabs = ["码力","开源","热门"]

struct FindView: View {
    
    // MARK: 码力集市价格语言
    @EnvironmentObject private var findView: FindViewState
//    @StateObject var vm: OpenSourceLibraryVm = OpenSourceLibraryVm()
    @StateObject private var findVM: FindVM = FindVM()
    
    /// MARK: 开源请求loading
    @State private var isOpenLoading: Bool = false
    
    @State private var offset : CGFloat = 0
    @State private var pageIndex : Int = 0
    
    
    var body: some View {
        
        VStack(spacing:0){
            MTPageSegmentView(titles: findViewTabs, offset: $offset)
            //            Text("\(Int(floor(offset + 0.5) / ScreenWidth()))")
            MTPageScrollView(offset: $offset) {
                mainViews
            }
        }
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
            SelectLtpView
        }
        // 二级分类弹框
        .sheet(isPresented: $findVM.isShowmtDetail) {
            SecondItemList
        }
        .mtTopProgress(isOpenLoading, usingBackgorund: true)
//        .mtToast(isPresented: $findVM.logicProduct.isShowToast, text: findVM.logicProduct.toastText)
        // 开源接口请求loading
//        .mtTopProgress(findVM.logicProduct.isRequesting, usingBackgorund: true)
    }
    
    @ViewBuilder
    var mainViews : some View {
        HStack(spacing: 0) {
            Group {
                CodepowerView()
                    .environmentObject(findVM)
                //                    Ladder()
                OpenSourceLibrary(isOpenLoading: $isOpenLoading)
                RecommendView()
            }
            .frame(width: ScreenWidth())
            .onChange(of: offset) { value in
                self.pageIndex = Int(floor(offset + 0.5) / ScreenWidth())
            }
        }
    }
    
    
    // MARK: 一级分类 语言技术 价格弹框view
    var SelectLtpView: some View {
        VStack {
            CodeItemList
                .mtTopProgress(findVM.logicCode.isRequesting, usingBackgorund: true)
            //                .mtToast(isPresented: $findVM.logicCode.isShowToast, text: findVM.logicCode.toastText)
            
            HStack(spacing:20) {
                Button {
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
                    if let index: Int = findVM.itemList.firstIndex(where: {$0.id == item.id}) {
                        findVM.selectIndex = index
                        
                        if index == 0 {
                            // 语言
                            findVM.requestWIthLangList()
                        }else if index == 1 {
                            // 技术
                            findVM.requestWithTechnology()
                        }
                    }
                    findVM.isShowmtDetail.toggle()
                })
                .frame(height:30)
            }
            .listStyle(PlainListStyle())
        }
    }
    
    
    // MARK: 二级分类下列表数据
    @ViewBuilder
    var SecondItemList : some View {
        
        let cardWidth = (ScreenWidth() - 40 - 20 ) / 3
        //排序方式
        let columns = Array(repeating:  GridItem(.fixed(cardWidth)), count: 3)
        
        NavigationView {
            
            ScrollView {
                // 网格列表
                LazyVGrid(columns: columns,
                          alignment: .center,
                          spacing: 20,
                          content: {
                    switch findVM.selectCodeSelectStyle {
                    case .lang:
                        LangListView
                        
                    case .technology:
                        TechnologyListView
                        
                    case .price:
                        PriceListView
                        
                    default:
                        Text("加载中....")
                    }
                })
            }
            .listStyle(.grouped)
            .navigationBarTitle(Text(findVM.selectSecondTitle))
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(trailing: closeBtn)
        }
    }
    
    var closeBtn : some View {
        
        Button {
            //            self.persentationMode.wrappedValue.dismiss()
            findVM.isShowmtDetail.toggle()
        } label: {
            Image.mt.load(.Close)
                .resizable()
                .frame(width: 24, height: 24)
        }
        .foregroundColor(Color.black)
        .padding(.all,4)
        .background(Color.mt.gray_100)
        .clipShape(Circle())
        .frame(maxWidth:.infinity,alignment: .trailing)
    }
    
    //MARK: 语言view
    var LangListView: some View {
        ForEach(findVM.itemList[0].data) { item in
            
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
                findVM.updateLangItems(item: item)
            })
        }
    }
    //MARK: 技术view
    var TechnologyListView: some View {
        ForEach(findVM.itemList[1].technologyList) { item in
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
        ForEach(findVM.itemList[2].priceList) { item in
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
                findVM.updatePriceItes(item: item)
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
        FindView()
    }
}
