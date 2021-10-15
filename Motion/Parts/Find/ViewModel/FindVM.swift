//
//  FindVM.swift
//  Motion
//
//  Created by Beck on 2021/10/9.
//


import MotionComponents
import Foundation

class FindVM: ObservableObject {
    
    // MARK: 码力集市价格语言
    @Published var isShowmtsheet: Bool = false // 一级分类下弹框
    @Published var isShowmtDetail: Bool = false// 二级分类下弹框
    // MARK: 项目列表弹框
    @Published var logicProduct = LogicProduct()
    
    // MARK:语言技术价格
    @Published var logicCode = LogicProduct()
    
    @Published var detailWebUrl: String = ""
    
    // 当前记录一级选中索引
    var selectCodeSelectStyle: CodeSelectStyle = .def
    
    var selectIndex: Int = -1 {
        didSet {
            switch selectIndex {
            case 0:
                selectCodeSelectStyle = .lang
                break
            case 1:
                selectCodeSelectStyle = .to
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
        case def,lang ,to ,price
    }
    // 选中当前模型
    
    @Published var selectFindModel: FindModel = FindModel(title:"全部", data: [],technology: [],price:[])
    
//    @Published var sltLangModel: FindModel = FindModel(title:"语言",data: [], technology: [], price: [])
//    @Published var sltTeModel: FindModel = FindModel(title:"技术",data: [], technology: [], price: [])
//    @Published var sltPriceModel: FindModel = FindModel(title:"价格",data: [], technology: [], price: [])

    
    // 码力数据源
    @Published var itemList: [FindModel] = []
    
    //MARK: 产品接口模块 and 数据模型
    // 产品列表接口参数
    @Published var proList: [CodeProductModel] = []
    var pageNum: Int = 0
    var lang: String = ""
    var price: String = ""
    var labelIds: String = ""
    
    init() {
        getItems()
//        requestWithMenuList()
        
        requestWithProductList()
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
    func requestWithMenuList() {
        // 显示加载
        self.logicCode.isRequesting = true

        // 语言https
        let language = CodepowerApi.language(p: .init(group: "lang"))
        Networking.requestArray(language, modeType: LangModel.self) {[weak self] r, list in
            // 成功...
            self?.logicCode.isRequesting = false
            
            if let list = list {
                self?.itemList[0].data = list
                
               
            }else {
                //失败
//                let arr = MockTool.readArray(LangModel.self, fileName: "codepower_langs") ?? []
//                self?.itemList[0].data = arr
                
                    self?.logicCode.toastText = "请求失败"
                    self?.logicCode.isShowToast = true
            }
            
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
            // 成功...
            if let list = list {
//                self?.itemList[1].technologyList.append(contentsOf: list)
                
//                    let arr = MockTool.readArray(TechnologyModel.self, fileName: "codepower_te") ?? []
                    self?.itemList[1].technologyList = list
                
            }else {
//                let arr = MockTool.readArray(TechnologyModel.self, fileName: "codepower_te") ?? []
//                self?.itemList[1].technologyList = arr
            }
            
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
        
        // 价格
        let json1: [[String: Any]] = [
            ["dictKey": "全部", "dictValue": ""],
            ["dictKey": "免费", "dictValue": "0"],
            ["dictKey": "1-98", "dictValue": "1"],
            ["dictKey": "99-198", "dictValue": "2"],
            ["dictKey": "199-1998", "dictValue": "3"],
            ["dictKey": "1999-2998", "dictValue": "4"],
            ["dictKey": "2999以上", "dictValue": "5"]
        ]
        
        let cars = json1.kj.modelArray(LangModel.self)
        self.itemList[2].priceList = cars
    }
    
    
    // MARK:产品列表接口
    func requestWithProductList() {
        logicProduct.isRequesting = true

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
        case .to:
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
            self?.logicProduct.isRequesting = false
//            if let list = list {
//                self?.proList.append(contentsOf: list)
//            }else {
//                self?.logicProduct.toastText = "请求失败"
//                self?.logicProduct.isShowToast = true
//            }
            
            let arr = MockTool.readArray(CodeProductModel.self, fileName: "codepower_pro", atKeyPath: "data.content") ?? []
            self?.proList.append(contentsOf: arr)
        }
    }
}

// MARK: 模型处理模块
extension FindVM {
    //MARK: 重置数据
    func clearItems() {
        
        selectCodeSelectStyle = .def
        
        itemList[0].data[selectLangIndex].isSelect = false
        itemList[0].subTitle = ""
        itemList[1].technologyList[selectTechnologyIndex].isSelect = false
        itemList[1].subTitle = ""
        itemList[2].priceList[selectPriceIndex].isSelect = false
        itemList[2].subTitle = ""
        
        selectLangIndex = 0
        selectTechnologyIndex = 0
        selectPriceIndex = 0
        pageNum = 0
        
        lang = ""
        price = ""
        labelIds = ""
        
    }
    
    // MARK: 修改数据
    func updateItes(item: LangModel) {
        // 所有设置false
        var selectIndex = 0
        switch selectCodeSelectStyle {
        case .lang:
            selectIndex = 0
        case .to:
            selectIndex = 1
        case .price:
            selectIndex = 2
        case .def:
            selectIndex = 0
        }
        if let index = selectFindModel.data.firstIndex(where: {$0.isSelect == true}) {
            selectFindModel.data[index].isSelect = false
            
            itemList[selectIndex].data[index].isSelect = false
        }
        
        if selectIndex == 0 {
            if let index = selectFindModel.data.firstIndex(where: {$0.id == item.id}) {
                let codeModel = LangModel(dictKeyGroup: item.dictKeyGroup, dictKey: item.dictKey, dictValue: item.dictValue, isSelect: !item.isSelect)
                selectFindModel.data[index] = codeModel
                
                if selectCodeSelectStyle == .lang {
                    selectLangIndex = index
                    itemList[selectIndex].data[index] = codeModel // 修改数据源
                    lang = codeModel.isSelect ? codeModel.dictValue : ""
                }else {
                    selectPriceIndex = index
                    itemList[selectIndex].priceList[index] = codeModel // 修改数据源
                    price = codeModel.isSelect ? codeModel.dictValue : ""
                }
               
                itemList[selectIndex].subTitle = codeModel.isSelect ? codeModel.dictKey : "全部"
            }

        }else {
            if let index = selectFindModel.priceList.firstIndex(where: {$0.id == item.id}) {
                let codeModel = LangModel(dictKeyGroup: item.dictKeyGroup, dictKey: item.dictKey, dictValue: item.dictValue, isSelect: !item.isSelect)
                selectFindModel.priceList[index] = codeModel
                
                if selectCodeSelectStyle == .lang {
                    selectLangIndex = index
                    itemList[selectIndex].priceList[index] = codeModel // 修改数据源
                    lang = codeModel.isSelect ? codeModel.dictValue : ""
                }else {
                    selectPriceIndex = index
                    itemList[selectIndex].priceList[index] = codeModel // 修改数据源
                    price = codeModel.isSelect ? codeModel.dictValue : ""
                }
               
                itemList[selectIndex].subTitle = codeModel.isSelect ? codeModel.dictKey : "全部"
            }

        }
        isShowmtDetail.toggle()
    }
    //MARK: 技术选中数据模型更新
    func updateTechnologyItes(item: TechnologyModel) {
        // 所有设置false
        let selectIndex = 1
        if let index = selectFindModel.technologyList.firstIndex(where: {$0.isSelect == true}) {
            selectFindModel.technologyList[index].isSelect = false
            
            itemList[selectIndex].technologyList[index].isSelect = false
        }
        
        if let index = selectFindModel.technologyList.firstIndex(where: {$0.id == item.id}) {
            let codeModel = TechnologyModel(labelId: item.labelId, labelName: item.labelName, labelHeat: item.labelHeat, isSelect: !item.isSelect)
            selectFindModel.technologyList[index] = codeModel
            itemList[selectIndex].technologyList[index] = codeModel // 修改数据源
            selectTechnologyIndex = index
            itemList[selectIndex].subTitle = codeModel.isSelect ? codeModel.labelName : "全部"
            labelIds = codeModel.isSelect ? codeModel.labelId : ""
        }
        isShowmtDetail.toggle()
    }
}


// MARK: 语言技术价格一级分类数据模型
struct FindModel: Identifiable {
    var id: String
    
    var title: String
    
    var subTitle: String = ""
    
//    var list: [FindModel] = []
    
    // 语言
    var data: [LangModel] = []
    
    // 技术
    var technologyList: [TechnologyModel] = []
    
    // 价格
    var priceList: [LangModel] = []
    
    // 用户是否选中
//    var isSelect: Bool = false
    
    var showText: String {
        subTitle.isEmpty ? "全部" : subTitle
    }
    
    init(id: String = UUID().uuidString, title:String, data: [LangModel], technology: [TechnologyModel],price: [LangModel]) {
        self.id = id
        self.title = title
        self.data = data
        self.technologyList = technology
        self.priceList = price
    }
}

// MARK: 语言 or 价格模型
struct LangModel: Identifiable, Convertible {
    let id: String = UUID().uuidString
    var dictKeyGroup: String = ""
    var dictKey: String = ""
    var dictValue: String = ""
    // 用户是否选中
    var isSelect: Bool = false
}

// MARK: 技术模型
struct TechnologyModel: Identifiable, Convertible {
    let id: String = UUID().uuidString
    var labelId: String = ""
    var labelName: String = ""
    var labelHeat: String = ""
    // 用户是否选中
    var isSelect: Bool = false
}

struct CodeProductModel: Identifiable, Convertible {
    var id: String = UUID().uuidString
    var productId = "" //:"2c9780827c30630d017c306c65600000",
    var productName = ""//:"网站后台权限管理系统",
    var productLang = ""//:"Java",
    var productPrice = ""// ":0.01,
    var productOriginalPrice = ""//:0.01,
    var status = ""//:0,
    var cstCreate = ""
    var cstCreateTimestamp = ""
    var createUserId = ""
    var authorNickname = ""
    var authorHeadImgUrl = ""
    var countBrowses = "" // 浏览个数
    var bought = ""
    
    var storageAttachments: [CodeDetailModel] = []
    
    var productImg: String {
        storageAttachments.count > 2 ? storageAttachments[1].attachmentKey : ""
    }
}

struct CodeDetailModel: Identifiable, Convertible {
    var id: String = UUID().uuidString
    
    var attachmentKey: String = ""
    
    var attachmentKeyThumbnail: String = ""
}
