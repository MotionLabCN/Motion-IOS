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
    
    private(set) var channel: LoginSuccessInfo.ChannelType = .unkown {
        didSet {
            phone = "15271327766"
        }
    }

//    private var cancellableSet = Set<Combine.AnyCancellable>()
    /// 手机号
    @Published var phone = "" {
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
    @Published var code = "" {
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
    
    private var accountIsExsit = false
    var userInfo: UserInfo?
    
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

    @Published var logicStart = LogicStart()

    
    func debugLoginIn() {
        UserManager.shared.updateSaveUserInfo(.init(id: "假的"))
    }
    
    
    @Published var logicSendCode = LogicSendCode()
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
            case .validateCode:
                self?.logicAuth.toastisPresented = true
                self?.logicAuth.toastText = result.message
            }
        }
    }
    
    
  

  
    
    @Published var logicAuth = LogicAuth()
    func loginInWithCode() {
        logicAuth.isRequesting = true
        
        let target = LoginApi.loginInWithCode(p: .init(mobile: phone, smsCode: code))
        Networking.requestObject(target, modeType: LoginSuccessInfo.self, atKeyPath: nil) { [weak self] r, model in
            
            if let model = model {
                UserManager.shared.loginSusscessSaveToken(model, channel: .手机验证码)
                // 登录成功了有一个token  然后去获取用户信息
                self?.getUserInfo() //隐藏   logicAuth.isRequesting = false
            } else { //失败
                self?.logicAuth.isRequesting = false //失败了
                
                self?.logicAuth.toastisPresented = true
                self?.logicAuth.toastText = r.errorDesc
                #if DEBUG
                self?.getUserInfo()
                #endif
            }
            
//            UserManager.shared.loginSuccessSaveUser(model)
        }
    }
    
    func loginInWithGithub() {
        channel = .github
        logicStart.isShowLoading = true
        
        ThirdAuth.shared.signIn(platform: .git(method: .asAuth), completion: { [weak self] response in
            guard let self = self  else {
                return
            }

            guard case let .git(result) = response?.response else {
                self.logicStart.isShowToast = true
                self.logicStart.toastText = "Github登录失败"
                self.logicStart.isShowLoading = false
                return
            }
            
            UserManager.shared.loginSusscessSaveToken(LoginSuccessInfo(access_token: result.token), channel: .github)
            // 调用接口信息
            // 去绑定手机号
            self.getUserInfo()
            
        })
    }
    
    // 手机号验证码登录时
    @Published var isGetUserInfo = false
    func getUserInfo() {
        isGetUserInfo = true
        
        Networking.requestObject(CommunityServiceApi.userinfo, modeType: UserInfo.self) { [weak self] r, model in
            //判断当前账号是否存在  如果存在直接关掉视图  accountIsExsit
            guard let self = self else { return }
            self.isGetUserInfo = false
            
            guard let m = model else {
                self.logicAuth.toastisPresented = true
                self.logicAuth.toastText = r.message
                return
            }

            
            
            self.userInfo = m

            switch self.channel {
            case .unkown, .wechat: break
            case .手机验证码:
                self.logicAuth.isRequesting = false

                if self.accountIsExsit {
                    self.loginCompletion()
                } else {
                    self.logicAuth.isPushBaseInfoView = true
                }
            case .一键手机登陆: break
            case .github, .apple: //绑定手机号
                if UserManager.shared.user.mobileAuth { //已经授权了
                    self.loginCompletion()
                } else { // 去绑定手机号
                    self.logicStart.isShowLoading = false
                    self.logicStart.isShowLoginSheet = false
                    self.logicStart.isPushInputPhoneView = true
                }
       
     
            }
            
           
            
        }
    }
    
    /// 个人资料页面 点跳过
    func loginCompletion() {
        UserManager.shared.updateSaveUserInfo(userInfo)
    }
    
    
    @Published var logicBaseInfo = LogicBaseInfo()
    /// 目前只修改user name
    func updateUserBaseInfo() {
        logicBaseInfo.isRequesting = true
        // 修改完成后  loginCompletion()
    }
}



//MARK: - 点击事件
extension LoginVM {
    func clickLoginStart() {
        logicStart.isShowLoginSheet = true
    }
    
    func clickPhoneCodeLogin() {
        channel = .手机验证码
        
        logicStart.isShowLoginSheet = false
        logicStart.isPushInputPhoneView = true
    }
   
    func clickNextAtInputPhone() {
        print("channle \(channel)")
        if channel == .手机验证码 {
            sendCode(atPage: .inputPhone)
        }
        
        if channel == .github {
            print("绑定手机号")
        }
    }
   
    
}


//MARK: - 配置
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
    struct LogicStart {
        var isShowLoading = false

        var isShowToast = false
        var toastText = ""
        var toastStyle = MTPushNofi.PushNofiType.danger
        
        var isShowLoginSheet = false 
        var isPushInputPhoneView = false
        
    }
    
    
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
    
    
    // 填写验证码页面
    struct LogicAuth {
        var isRequesting = false
        var toastisPresented = false
        var toastText = ""
        var isPushBaseInfoView = false
    }
    
    // 修改用户资料
    struct LogicBaseInfo {
        var isRequesting = false

    }
}


