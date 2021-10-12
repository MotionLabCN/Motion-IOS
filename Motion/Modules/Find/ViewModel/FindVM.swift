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
    var selectDetail: Int = -1
    
    enum CodeSelectStyle {
        case def,lang ,to ,price
        
    }
    // 选中当前模型
    
    @Published var selectFindModel: FindModel = FindModel(dictKey:"语言", data: [],technology: [],price:[])
//    @Published var selectTogModel: FindModel = FindModel(dictKey:"技术", data: [],technology: [],price:[])
//    @Published var selectPriceModel: FindModel = FindModel(dictKey:"价格", data: [],technology: [],price:[])
    
    // 码力数据源
    @Published var itemList: [FindModel] = []
    
    //MARK: 产品接口模块 and 数据模型
    // 产品列表接口参数
    @Published var proList: [String] = [
        "ssss","1","2"
    ]
    var pageNum: Int = 0
    var lang: String = ""
    var price: String = ""
    var labelIds: String = ""
    
    
    init() {
        getItems()
        
        requestWithMenuList()
    }
    
    func getItems() {
        let item =  [
            FindModel(dictKey:"语言",data: [], technology: [], price: []),
            FindModel(dictKey:"技术",data: [], technology: [], price: []),
            FindModel(dictKey:"价格",data: [], technology: [], price: []),
        ]
        itemList.append(contentsOf: item)
//        selectFindModel = item[0];
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
        
        if let index = selectFindModel.data.firstIndex(where: {$0.id == item.id}) {
            let codeModel = LangModel(dictKeyGroup: item.dictKeyGroup, dictKey: item.dictKey, dictValue: item.dictValue, isSelect: !item.isSelect)
            selectFindModel.data[index] = codeModel
            itemList[selectIndex].data[index] = codeModel // 修改数据源
            selectDetail = index
            itemList[selectIndex].subTitle = codeModel.isSelect ? codeModel.dictKey : "全部"
        }
        isShowmtDetail.toggle()
    }
    
    
    // MARK: 获取码力数据
    func requestWithMenuList() {
        // 语言
        let language = CodepowerApi.language(p: .init(group: "lang"))
        
        let tmparr1 = mockLangs()
        Networking.requestObject(language, modeType: UserInfo.self) {[weak self] r, model in
            // 成功...
            // 调用json数组的modelArray方法即可
//            let cars = json1.kj.modelArray(LangModel.self)
            self?.itemList[0].data.append(contentsOf: tmparr1)
        }
        // 技术
        let technology = CodepowerApi.technology
        Networking.requestObject(technology, modeType: UserInfo.self) {[weak self] r, model in
            // 成功...
            let json: [[String: Any]] = [
                ["labelId":"2c9780827bf34b0e017bf6a45f9e0016","labelName":"redis","labelHeat":10],
                ["labelId":"2c9780827bf34b0e017c15c07235017e","labelName":"spring","labelHeat":7],
                ["labelId":"2c9780827bf34b0e017c134b0ded0135","labelName":"python","labelHeat":4]
            ]
            
            let cars = json.kj.modelArray(TechnologyModel.self)
            self?.itemList[1].technologyList.append(contentsOf: cars)
            
        }
        
        // 价格
        let json1: [[String: Any]] = [
            ["dictKey": "全部", "dictValue": "C/C++"],
            ["dictKey": "免费", "dictValue": "Java"],
            ["dictKey": "1-98", "dictValue": "Python"],
            ["dictKey": "99-198", "dictValue": "Python"],
            ["dictKey": "199-1998", "dictValue": "Python"],
            ["dictKey": "1999-2998", "dictValue": "Python"],
            ["dictKey": "2999以上", "dictValue": "Python"]
        ]
        
        let cars = json1.kj.modelArray(LangModel.self)
        self.itemList[2].data.append(contentsOf: cars)
        
    }
    
    
    // MARK:产品列表接口
    func requestWithProductList() {
        let technology = CodepowerApi.productList(p: .init(labelIds: labelIds, lang: lang, price: price, page: pageNum, size: 10, sort: ""))
        Networking.requestObject(technology, modeType: UserInfo.self) { r, model in
            // 成功...
            
        }
    }
    
    // MARK: 获取码力列表数据
    func requestWithCodeList() {
//        addItem(title: "beck")
        let target = LoginApi.github
        Networking.requestObject(target, modeType: UserInfo.self) { r, model in
            // 成功...
        }
    }
    
    func getJSON() {
        let path = Bundle.main.path(forResource: "Codepower", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        do {
            let data = try Data(contentsOf: url)
            let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)

            //                LangModel.kj
            let json = jsonData as! [String: Any]
            let arr = json["data"]

//            let cars = json.kj.modelArray(LangModel.self)

            let json1: [[String: Any]] = [
                ["dictKey": "C/C++", "dictValue": "C/C++"],
                ["dictKey": "Java", "dictValue": "Java"],
                ["dictKey": "Python", "dictValue": "Python"]
            ]

            // 调用json数组的modelArray方法即可
            let cars = json1.kj.modelArray(LangModel.self)
            self.itemList[0].data.append(contentsOf: cars)
            
        } catch let error  {
            print("读取本地数据出现错误!")
        }
    }
}

//mark: - mock
extension FindVM {
    func mockLangs() -> [LangModel] {
        let r = read(NetResponse<LangModel>.self, from:Bundle.main.path(forResource: "codepower_lang", ofType: "json") ?? "")
        return r?.data as? [LangModel] ?? []
    }
}

struct FindModel: Identifiable {
    var id: String
    var dictKey: String
    
    var subTitle: String = ""
    
    var list: [FindModel] = []
    
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
    
    init(id: String = UUID().uuidString, dictKey:String, data: [LangModel], technology: [TechnologyModel],price: [LangModel]) {
        self.id = id
        self.dictKey = dictKey
        self.data = data
        self.technologyList = technology
        self.priceList = price
    }
    // MARK:更新数据
//    func updateCompletion() -> FindModel {
//        return FindModel(id: id, dictKey: dictKey, isSelect: !isSelect)
//    }
}


struct LangModel: Identifiable, Convertible {

    let id: String = UUID().uuidString
    var dictKeyGroup: String = ""
    var dictKey: String = ""
    var dictValue: String = ""
    // 用户是否选中
    var isSelect: Bool = false
}


struct TechnologyModel: Identifiable, Convertible {
    let id: String = UUID().uuidString
    var labelId: String = ""
    var labelName: String = ""
    var labelHeat: String = ""
    // 用户是否选中
    var isSelect: Bool = false
}




//    func updateItem(item: FindModel) {
//        // 所有设置false
//        if let index = selectFindModel.list.firstIndex(where: {$0.isSelect == true}) {
//            selectFindModel.list[index].isSelect = false
//            itemList[selectIndex].list[index].isSelect = false
//        }
//
//        if let index = selectFindModel.list.firstIndex(where: {$0.id == item.id}) {
//            let findModel = FindModel(dictKey:item.dictKey, isSelect: !item.isSelect)
//            selectFindModel.list[index] = findModel
//            itemList[selectIndex].list[index] = findModel // 修改数据源
//            selectDetail = index
//            itemList[selectIndex].subTitle = findModel.isSelect ? findModel.dictKey : "全部"
//        }
//        isShowmtDetail.toggle()
//    }
