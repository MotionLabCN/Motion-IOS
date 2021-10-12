//
//  LoginVM.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/26.
//

import Combine
import UIKit
import MotionComponents

class LoginVM: ObservableObject {
    struct Constant {
        static let phoneMaxNum = 11
        static let codeMaxNum = 4
    }
    
//    private var cancellableSet = Set<Combine.AnyCancellable>()
    /// 手机号
    @Published var phone = "15271327766" {
        didSet {
            if phone.count > Constant.phoneMaxNum && oldValue.count <= Constant.phoneMaxNum {
                HapticManager.shared.notification(type: .error)
                phone = oldValue
            } else {
                if !phone.isDigits, oldValue.isDigits {
                    HapticManager.shared.notification(type: .error)
                    phone = oldValue
                }
            }
        }
    }
        
    /// 验证码
    @Published var code = "2222" {
        didSet {
            if code.count > Constant.codeMaxNum && oldValue.count <= Constant.codeMaxNum {
                HapticManager.shared.notification(type: .error)
                code = oldValue
            } else {
                if !code.isDigits, code.isDigits {
                    HapticManager.shared.notification(type: .error)
                    code = oldValue
                }
            }
        }
    }
    
    /// 基础资料
    @Published var userName = "梁泽"
    
    @Published var teamList: [TeamModel] = [
        .init(text: "远程协作", isSelected: true),
        .init(text: "社团、班级、小组"),
        .init(text: "品牌客户群"),
        .init(text: "运动、兴趣组"),
        .init(text: "自定义创建"),
    ]
    
    func choose(_ team: TeamModel) {
        if let index = teamList.firstIndex(where: { $0 == team }) {
            teamList = teamList.map({
                var tmp = $0
                tmp.isSelected = false
                return tmp
            })
          
            teamList[index].isSelected = true
        }
    }

    
    func debugLoginIn() {
        UserManager.shared.loginSuccessSaveUser(.init(id: "假的"))
    }
    
    func loginInWithCode() {
//        let target = LoginApi.loginIn(p: .init(mobile: "15271327766", smsCode: "888888"))
//        Networking.requestObject(target, modeType: UserInfo.self, atKeyPath: "data.member") { r, model in
//            let token = r.dataJson?["token"].string ?? ""
//            UserManager.shared.loginSusscessSaveToken(token, channel: .手机验证码)
//            UserManager.shared.loginSuccessSaveUser(model)
//        }
    }
    
    func loginInWithGithub() {
        let target = LoginApi.github
        Networking.requestObject(target, modeType: UserInfo.self) { r, model in
            UserManager.shared.loginSuccessSaveUser(model)
        }
    }
    
    
    @Published var isRequestingSendCode = false
    var accountIsExsit = false
    func sendCode() {
        isRequestingSendCode = true
        
        Networking.request(LoginApi.sendCode(p: .init(mobile: phone))) { [weak self] result in
            self?.accountIsExsit = result.dataJson?["isExsit"].boolValue ?? false
            self?.isRequestingSendCode = false
        }
    }
}


extension LoginVM {
    struct TeamModel: Identifiable, Equatable {
        var id: UUID = UUID()
        
        var text: String
        var isSelected: Bool = false
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.text == rhs.text
        }
    }
}


