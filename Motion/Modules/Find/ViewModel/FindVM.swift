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
    // 当前记录一级选中索引
    var selectIndex: Int = -1
    // 当前记录二级选中索引
    var selectDetail: Int = -1
    
    // 选中当前模型
    @Published var selectFindModel: FindModel = FindModel(dictKey: "")
    
    // 列表集合
    @Published var proList: [String] = [
        "ssss","1","2"
    ]
    
    // 码力数据源
    @Published var itemList: [FindModel] = []
    
    
    init() {
        getItems()
        
        requestWithMenuList()
    }
    
    func getItems() {
        let item =  [
            FindModel(dictKey:"语言",
                      list: []),
            
            FindModel(dictKey:"技术",
                      list: []),
            
            FindModel(dictKey:"价格",
                      list: [])
        ]
        itemList.append(contentsOf: item)
        selectFindModel = item[0];
    }
    
    // MARK: 修改数据
    func updateItes(item: CodepowerModel) {
        // 所有设置false
        if let index = selectFindModel.data.firstIndex(where: {$0.isSelect == true}) {
            selectFindModel.data[index].isSelect = false
            itemList[selectIndex].data[index].isSelect = false
        }
        
        if let index = selectFindModel.data.firstIndex(where: {$0.id == item.id}) {
            let codeModel = CodepowerModel(dictKeyGroup: item.dictKeyGroup, dictKey: item.dictKey, dictValue: item.dictValue, isSelect: !item.isSelect)
            selectFindModel.data[index] = codeModel
            itemList[selectIndex].data[index] = codeModel // 修改数据源
            selectDetail = index
            itemList[selectIndex].subTitle = codeModel.isSelect ? codeModel.dictKey : "全部"
        }
        isShowmtDetail.toggle()
    }
    
    
    // MARK: 获取码力数据
    func requestWithMenuList() {
        let language = CodepowerApi.language(p: .init(group: "lang"))
        Networking.requestObject(language, modeType: UserInfo.self) { r, model in
            // 成功...
            self.getJSON()
        }
        
        let technology = CodepowerApi.technology
        Networking.requestObject(technology, modeType: UserInfo.self) { r, model in
            // 成功...
            self.getJSON()
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

            //                CodepowerModel.kj
            let json = jsonData as! [String: Any]
            let arr = json["data"]

//            let cars = json.kj.modelArray(CodepowerModel.self)

            let json1: [[String: Any]] = [
                ["dictKey": "C/C++", "dictValue": "C/C++"],
                ["dictKey": "Java", "dictValue": "Java"],
                ["dictKey": "Python", "dictValue": "Python"]
            ]

            // 调用json数组的modelArray方法即可
            let cars = json1.kj.modelArray(CodepowerModel.self)
            self.itemList[0].data.append(contentsOf: cars)
//            self.itemList[0].list.append(contentsOf: cars)
            
        } catch let error  {
            print("读取本地数据出现错误!")
        }
    }
}

struct FindModel: Identifiable {
    let id: String
    let dictKey: String
    
    var subTitle: String = ""
    
    var list: [FindModel]
    var data: [CodepowerModel] = []
    
    // 用户是否选中
//    var isSelect: Bool = false
    
    var showText: String {
        subTitle.isEmpty ? "全部" : subTitle
    }
    
    init(id: String = UUID().uuidString, dictKey:String, list: [FindModel] = []) {
        self.id = id
        self.dictKey = dictKey
        self.list = list
    }
        
    // MARK:更新数据
//    func updateCompletion() -> FindModel {
//        return FindModel(id: id, dictKey: dictKey, isSelect: !isSelect)
//    }
}

struct CodepowerModel:Identifiable, Convertible {

    let id: String = UUID().uuidString
    var dictKeyGroup: String = ""
    var dictKey: String = ""
    var dictValue: String = ""
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
