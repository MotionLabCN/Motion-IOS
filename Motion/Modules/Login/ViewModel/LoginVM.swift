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
        static let codeMaxNum = 6
    }
    
//    private var cancellableSet = Set<Combine.AnyCancellable>()
    /// 手机号
    @Published var phone = "15327335149" {
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
        UserManager.shared.updateSaveUserInfo(.init(id: "假的"))
    }
    

    
    func loginInWithGithub() {
        let target = LoginApi.github
        Networking.requestObject(target, modeType: UserInfo.self) { r, model in
            UserManager.shared.updateSaveUserInfo(model)
        }
    }
    
    
    @Published var logicSendCode = LogicSendCode()
    var accountIsExsit = false
    func sendCode(atPage page: LogicSendCode.Page) {
        logicSendCode.isRequesting = true
        
        Networking.request(LoginApi.sendCode(p: .init(mobile: phone))) { [weak self] result in
            self?.accountIsExsit = result.dataJson?["isExsit"].boolValue ?? false
            /*
             在哪个页面点
             如果在输入手机号点下一步请求验证码 成功后跳转到输入验证码
             如果在输入验证码点重发 仅发送验证码
            */
            switch page {
            case .inputPhone:
                self?.logicSendCode.isRequesting = false
                self?.logicSendCode.isPushCodeView = true
            case .validateCode: break
            }
        }
    }
    
    
  

  
    
    @Published var logicAuth = LogicAuth()
    func loginInWithCode() {
        logicAuth.isRequesting = true
        
        let target = LoginApi.loginInWithCode(p: .init(mobile: phone, smsCode: code))
        Networking.requestObject(target, modeType: LoginSuccessInfo.self, atKeyPath: nil) { [weak self] r, model in
            self?.logicAuth.isRequesting = false
            
            if let model = model {
                UserManager.shared.loginSusscessSaveToken(model, channel: .手机验证码)
                // 登录成功了有一个token  然后去获取用户信息
                self?.getUserInfo()
            } else { //失败
                self?.logicAuth.toastisPresented = true
                self?.logicAuth.toastText = r.errorDesc
                #if DEBUG
                self?.getUserInfo()
                #endif
            }
            
//            UserManager.shared.loginSuccessSaveUser(model)
        }
    }
    
    
    func getUserInfo() {
        Networking.requestObject(CommunityServiceApi.userinfo, modeType: UserInfo.self) { [weak self] r, model in
            //判断当前账号是否存在  如果存在直接关掉视图  accountIsExsit
            guard let self = self else { return }
            
            guard let m = model else {
                self.logicAuth.toastisPresented = true
                self.logicAuth.toastText = r.message
                return
            }

            
            
            
            if self.accountIsExsit {
                UserManager.shared.updateSaveUserInfo(m)
            } else {
                self.logicAuth.isPushBaseInfoView = true
            }
            
            print("model")
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
    
    //MARK: - Logic Published
    struct LogicSendCode {
        /*
         在哪个页面点
         如果在输入手机号点下一步请求验证码 成功后跳转到输入验证码
         如果在输入验证码点重发 停在当前面
        */
        enum Page {
        case inputPhone, validateCode
        }
        
        var isRequesting = false
        var isPushCodeView = false
    }
    
    
    // logic
    struct LogicAuth {
        var isRequesting = false
        var toastisPresented = false
        var toastText = ""
        var isPushBaseInfoView = false
    }
}


