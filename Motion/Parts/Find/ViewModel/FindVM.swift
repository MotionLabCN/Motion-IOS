//
//  FindVM.swift
//  Motion
//
//  Created by Beck on 2021/10/9.
//


import MotionComponents

class FindVM: ObservableObject {
    
    // MARK: 码力集市价格语言
    @Published var isShowmtsheet: Bool = false // 一级分类下弹框
    @Published var isShowmtDetail: Bool = false// 二级分类下弹框
    // MARK: 项目列表弹框
//    @Published var logicProduct = LogicProduct()
    // MARK: 语言技术价格

    @Published var requestAddPostStatus = RequestStatus.prepare
    
    @Published var detailWebUrl: String = ""
    @Published var publishProductWebUrl: String = ""
    
    let page = PageRequest()
    
    // 当前记录一级选中索引
    var selectCodeSelectStyle: CodeSelectStyle = .def
    
    enum CodeSelectStyle {
        case def,lang ,technology ,price
    }
    
    // 选中二级分类字段
    var selectSecondTitle: String {
        switch selectCodeSelectStyle {
        case .lang:
            return itemList[0].title
        
        case .technology:
            return itemList[1].title
            
        case .price:
            return itemList[2].title
        default:
            return ""
        }
    }
    
    // 码力数据源
    @Published var itemList: [FindModel] = []
    
    //MARK: 产品接口模块 and 数据模型
    // 产品列表接口参数
    @Published var proList: [CodeProductModel] = []
    

    // 选中
    var selectLang: String {
        itemList[0].subTitle
    }
    var selectTec: String {
        itemList[1].subTitle
    }
    var selectPrice: String {
        itemList[2].subTitle
    }
    
    init() {
        self.getItems()
        self.getPriceItems()
        
        page.pageSize = 20
        
        DispatchQueue.global().async {
            self.requestWithProductList()
        }
    }
    
    func getItems() {
        let item =  [
            FindModel(title:"语言",langList: [], technology: [], price: []),
            FindModel(title:"技术",langList: [], technology: [], price: []),
            FindModel(title:"价格",langList: [], technology: [], price: [])
        ]
        itemList.append(contentsOf: item)
    }
    
    func refresh() {
        page.reset()
        requestWithProductList()
    }
}


// MARK: 网络请求模块
extension FindVM {
    // MARK: 获取码力数据
    func requestWIthLangList() {
        // 显示加
        requestAddPostStatus = .requesting
        
        // 语言https
        let language = CodepowerApi.language(p: .init(group: "lang"))
        Networking.requestArray(language, modeType: LangModel.self) {[weak self] r, list in
            // 成功...
            if list.isNilOrEmpty {
                self?.requestAddPostStatus = .completionTip(text: "请求失败", status: .danger)
                
            } else {
                
            }
            let arr = MockTool.readArray(LangModel.self, fileName: "codepower_langs") ?? []
            self?.itemList[0].langList = arr
            // 拿到数据开始设置上次选中模型 设置选中状态
            self?.itemList[0].langUpdateSelectItem()
        }
    }
    
    func requestWithTechnology() {
        // 技术
        let technology = CodepowerApi.technology
        Networking.requestArray(technology, modeType: TechnologyModel.self) {[weak self] r, list in
            // 成功...
            if list.isNilOrEmpty {
                self?.requestAddPostStatus = .completionTip(text: "请求失败", status: .danger)
                
            } else {
                
            }
            let arr = MockTool.readArray(TechnologyModel.self, fileName: "codepower_te") ?? []
            self?.itemList[1].technologyList = arr
            // 拿到数据开始设置上次选中模型 设置选中状态
            self?.itemList[1].technologyUpdateSelectItem()
        }
    }
    
    // MARK:产品列表接口
    func requestWithProductList() {
        
        let lang = itemList[0].selectValue
        let price = itemList[2].selectValue
        let labelIds = itemList[1].selectValue
        
        let technology = CodepowerApi.productList(p: .init(labelIds: labelIds, lang: lang, price: price, page: page.pageNum, size: 20, sort: ""))
        Networking.requestArray(technology, modeType: CodeProductModel.self, atKeyPath: "data.content") {[weak self] r, list in
            // 成功...
            guard let self = self else { return }
//            self.logicProduct.isRequesting = false
            
            if let list = list {
//                self.proList = list
//                self.proList.append(contentsOf: list)
            }else {
                
            }
            // mock数据
            let arr = MockTool.readArray(CodeProductModel.self, fileName: "codepower_pro", atKeyPath: "data.content") ?? []
            self.proList.append(contentsOf: arr)
        }
    }
    
    // MARK: 获取价格数据
    func getPriceItems() {
        // 价格
        let arr = MockTool.readArray(LangModel.self, fileName: "codepower_price") ?? []
        self.itemList[2].priceList = arr
    }
}

// MARK: 模型处理模块
extension FindVM {
    //MARK: 重置数据
    func clearItems() {
        selectCodeSelectStyle = .def
        
        // 清空选中
//        pageNum = 0
        itemList[0].clearLangSelectItem()
        itemList[1].clearTechnologySelectItem()
        itemList[2].clearPriceSelectItem()
    }
    
    // MARK:点击一级分类
    func selectCellWithModel(item: FindModel) {
        isShowmtDetail.toggle()
        // 获取一级分类下 当前选中的二级分类列表数据.
        if let index: Int = itemList.firstIndex(where: {$0.id == item.id}) {
//            selectIndex = index

            if index == 0 {
                // 语言
                selectCodeSelectStyle = .lang
                requestWIthLangList()
            }else if index == 1 {
                // 技术
                selectCodeSelectStyle = .technology
                requestWithTechnology()
            }else {
                selectCodeSelectStyle = .price
                itemList[2].priceUpdateSelectItem()
            }
        }
    }
    
    // MARK: 修改数据
    func updateLangItems(item: LangModel) {
        itemList[0].langUpdate(item: item)
        isShowmtDetail.toggle()
    }
    
    // MARK:修改价格
    func updatePriceItes(item: LangModel) {
        itemList[2].priceUpdate(item: item)
        isShowmtDetail.toggle()
    }
    
    //MARK: 技术选中数据模型更新
    func updateTechnologyItes(item: TechnologyModel) {
        // 所有设置false
        itemList[1].technologyUpdate(item: item)
        isShowmtDetail.toggle()
    }
}


