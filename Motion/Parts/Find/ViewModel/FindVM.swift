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
    @Published var logicCode = LogicProduct()
    @Published var detailWebUrl: String = ""
    @Published var publishProductWebUrl: String = ""
    
    
    // 当前记录一级选中索引
    var selectCodeSelectStyle: CodeSelectStyle = .def
    
    var selectIndex: Int = -1 {
        didSet {
            switch selectIndex {
            case 0:
                selectCodeSelectStyle = .lang
                break
            case 1:
                selectCodeSelectStyle = .technology
                break
            case 2:
                selectCodeSelectStyle = .price
                break
                
            default:
                selectCodeSelectStyle = .def
            }
        }
    }
    
    // 当前记录二级选中索引
    var selectLangIndex: Int = 0
    var selectTechnologyIndex: Int = 0
    var selectPriceIndex: Int = 0
    
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
    var pageNum: Int = 0
    var lang: String = ""
    var price: String = ""
    var labelIds: String = ""
    
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
        DispatchQueue.global().async {
            self.requestWithProductList()
        }
    }
    
    func getItems() {
        let item =  [
            FindModel(title:"语言",data: [], technology: [], price: []),
            FindModel(title:"技术",data: [], technology: [], price: []),
            FindModel(title:"价格",data: [], technology: [], price: [])
        ]
        itemList.append(contentsOf: item)
    }
}

//MARK: - Logic Published
struct LogicProduct {
    var isRequesting = false
    var isShowLoading = false

    var isShowToast = false
    var toastText = ""
    var toastStyle = MTPushNofi.PushNofiType.danger
}

// MARK: 网络请求模块
extension FindVM {
    // MARK: 获取码力数据
    func requestWIthLangList() {
        // 显示加载
        self.logicCode.isRequesting = true
        
        // 语言https
        let language = CodepowerApi.language(p: .init(group: "lang"))
        Networking.requestArray(language, modeType: LangModel.self) {[weak self] r, list in
            // 成功...
            
            self?.logicCode.isRequesting = false
            
//            if let list = list {
//                self?.itemList[0].data = list
//            }else {
                //失败
//                let arr = MockTool.readArray(LangModel.self, fileName: "codepower_langs") ?? []
//                self?.itemList[0].data = arr
                
//                    self?.logicCode.toastText = "请求失败"
//                    self?.logicCode.isShowToast = true
//            }
            
            let arr = MockTool.readArray(LangModel.self, fileName: "codepower_langs") ?? []
            self?.itemList[0].data = arr
            
            // 拿到数据开始设置上次选中模型 设置选中状态
            if self?.lang.isEmpty == false {
                if let index = self?.itemList[0].data.firstIndex(where: {$0.dictValue == self?.lang}) {
                    self?.selectLangIndex = index
                    let langModel = self?.itemList[0].data[index] ?? LangModel()
                    self?.itemList[0].data[index].isSelect = true
                    self?.itemList[0].subTitle = langModel.dictValue
                }
            }
        }
    }
    
    func requestWithTechnology() {
        // 技术
        
        let technology = CodepowerApi.technology
        Networking.requestArray(technology, modeType: TechnologyModel.self) {[weak self] r, list in
            self?.logicCode.isRequesting = false
            // 成功...
            //            if let list = list {
            ////                self?.itemList[1].technologyList.append(contentsOf: list)
            //                    self?.itemList[1].technologyList = list
            //            }else {
            //                let arr = MockTool.readArray(TechnologyModel.self, fileName: "codepower_te") ?? []
            //                self?.itemList[1].technologyList = arr
            //            }
            let arr = MockTool.readArray(TechnologyModel.self, fileName: "codepower_te") ?? []
            self?.itemList[1].technologyList = arr
            // 拿到数据开始设置上次选中模型 设置选中状态
            if self?.labelIds.isEmpty == false {
                if let index = self?.itemList[1].technologyList.firstIndex(where: {$0.labelId == self?.labelIds}) {
                    DispatchQueue.main.async {
                        self?.selectTechnologyIndex = index
                        let technologyModel = self?.itemList[1].technologyList[index] ?? TechnologyModel()
                        self?.itemList[1].technologyList[index].isSelect = true
                        self?.itemList[1].subTitle = technologyModel.labelName
                    }
                }
            }
        }
    }
    
    func requestWithMenuList() {
        // 显示加载
        self.logicCode.isRequesting = true

        // 语言https
        let language = CodepowerApi.language(p: .init(group: "lang"))
        Networking.requestArray(language, modeType: LangModel.self) {[weak self] r, list in
            // 成功...
            self?.logicCode.isRequesting = false
            
//            if let list = list {
//                self?.itemList[0].data = list
//
//
//            }else {
                //失败
//                let arr = MockTool.readArray(LangModel.self, fileName: "codepower_langs") ?? []
//                self?.itemList[0].data = arr
                
//                    self?.logicCode.toastText = "请求失败"
//                    self?.logicCode.isShowToast = true
//            }
            
            let arr = MockTool.readArray(LangModel.self, fileName: "codepower_langs") ?? []
            self?.itemList[0].data = arr
            
            // 拿到数据开始设置上次选中模型 设置选中状态
            if self?.lang.isEmpty == false {
                if let index = self?.itemList[0].data.firstIndex(where: {$0.dictValue == self?.lang}) {
                    self?.selectLangIndex = index
                    let langModel = self?.itemList[0].data[index] ?? LangModel()
                    self?.itemList[0].data[index].isSelect = true
                    self?.itemList[0].subTitle = langModel.dictValue
                }
            }
        }
        
        // 技术
        let technology = CodepowerApi.technology
        Networking.requestArray(technology, modeType: TechnologyModel.self) {[weak self] r, list in
            self?.logicCode.isRequesting = false
            // 成功...
//            if let list = list {
////                self?.itemList[1].technologyList.append(contentsOf: list)
//                    self?.itemList[1].technologyList = list
//            }else {
//                let arr = MockTool.readArray(TechnologyModel.self, fileName: "codepower_te") ?? []
//                self?.itemList[1].technologyList = arr
//            }
            let arr = MockTool.readArray(TechnologyModel.self, fileName: "codepower_te") ?? []
            self?.itemList[1].technologyList = arr
            // 拿到数据开始设置上次选中模型 设置选中状态
            if self?.labelIds.isEmpty == false {
                if let index = self?.itemList[1].technologyList.firstIndex(where: {$0.labelId == self?.labelIds}) {
                    self?.selectTechnologyIndex = index
                    let technologyModel = self?.itemList[1].technologyList[index] ?? TechnologyModel()
                    self?.itemList[1].technologyList[index].isSelect = true
                    self?.itemList[1].subTitle = technologyModel.labelName
                }
            }
        }
        
        
    }
    
    
    // MARK:产品列表接口
    func requestWithProductList() {
        
//        logicProduct.isRequesting = true

        pageNum = 0
        switch selectCodeSelectStyle {
        case .def:
            labelIds = ""
            lang = ""
            price = ""
            
        case .lang:
            if selectPriceIndex > -1 {
                lang = itemList[0].data[selectLangIndex].dictValue
            }
        case .technology:
            if selectTechnologyIndex > -1 {
                labelIds = itemList[1].technologyList[selectTechnologyIndex].labelId
            }
        case .price:
            if selectPriceIndex > -1 {
                price = itemList[2].priceList[selectPriceIndex].dictValue
            }
        }
        
        let technology = CodepowerApi.productList(p: .init(labelIds: labelIds, lang: lang, price: price, page: pageNum, size: 10, sort: ""))
        Networking.requestArray(technology, modeType: CodeProductModel.self, atKeyPath: "data.content") {[weak self] r, list in
            // 成功...
            guard let self = self else { return }
            
//            self.logicProduct.isRequesting = false
            
            if let list = list {
                self.proList.append(contentsOf: list)
            }else {
//                self.logicProduct.toastText = "请求失败"
//                self.logicProduct.isShowToast = true
            }
            
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
        
        itemList[0].data[selectLangIndex].isSelect = false
        itemList[0].subTitle = "全部"
        itemList[1].technologyList[selectTechnologyIndex].isSelect = false
        itemList[1].subTitle = "全部"
        itemList[2].priceList[selectPriceIndex].isSelect = false
        itemList[2].subTitle = "全部"
        
        selectLangIndex = 0
        selectTechnologyIndex = 0
        selectPriceIndex = 0
        pageNum = 0
        
        lang = ""
        price = ""
        labelIds = ""
    }
    
    // MARK: 修改数据
    func updateLangItems(item: LangModel) {
        if let index = itemList[0].data.firstIndex(where: {$0.isSelect == true}) {
            itemList[selectIndex].data[index].isSelect = false
        }
        if let index = itemList[0].data.firstIndex(where: {$0.id == item.id}) {
            let codeModel = LangModel(dictKeyGroup: item.dictKeyGroup, dictKey: item.dictKey, dictValue: item.dictValue, isSelect: !item.isSelect)
            selectLangIndex = index
            itemList[0].data[index] = codeModel // 修改数据源
            lang = codeModel.isSelect ? codeModel.dictValue : ""
            itemList[0].subTitle = codeModel.isSelect ? codeModel.dictKey : "全部"
        }
        isShowmtDetail.toggle()
        
    }
    // MARK:修改价格
    func updatePriceItes(item: LangModel) {
        if let index = itemList[2].data.firstIndex(where: {$0.isSelect == true}) {
            itemList[selectIndex].data[index].isSelect = false
        }
        
        if let index = itemList[2].priceList.firstIndex(where: {$0.id == item.id}) {
            let codeModel = LangModel(dictKeyGroup: item.dictKeyGroup, dictKey: item.dictKey, dictValue: item.dictValue, isSelect: !item.isSelect)
            selectPriceIndex = index
            itemList[selectIndex].priceList[index] = codeModel // 修改数据源
            price = codeModel.isSelect ? codeModel.dictValue : ""
            itemList[2].subTitle = codeModel.isSelect ? codeModel.dictKey : "全部"
        }
        isShowmtDetail.toggle()
    }
    
    //MARK: 技术选中数据模型更新
    func updateTechnologyItes(item: TechnologyModel) {
        // 所有设置false
        
        if let index = itemList[1].technologyList.firstIndex(where: {$0.isSelect == true}) {
            itemList[1].technologyList[index].isSelect = false
        }
        
        if let index = itemList[1].technologyList.firstIndex(where: {$0.id == item.id}) {
            let codeModel = TechnologyModel(labelId: item.labelId, labelName: item.labelName, labelHeat: item.labelHeat, isSelect: !item.isSelect)
            itemList[1].technologyList[index] = codeModel // 修改数据源
            selectTechnologyIndex = index
            itemList[1].subTitle = codeModel.isSelect ? codeModel.labelName : "全部"
            labelIds = codeModel.isSelect ? codeModel.labelId : ""
        }
        isShowmtDetail.toggle()
    }
}


