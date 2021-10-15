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
    
    var channel: LoginSuccessInfo.ChannelType = .unkown {
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
    @Published var sendCodeRequestStatus = RequestStatus.prepare

    /*
     在哪个页面点
     如果在输入手机号点下一步请求验证码 成功后跳转到输入验证码
     如果在输入验证码点重发 停在当前面
    */
    enum SendCodePage {
    case inputPhone, validateCode
    }
    
    func sendCode(atPage page: SendCodePage, completion: @escaping Block_T) {
        sendCodeRequestStatus  = .requesting
        
        if channel == .手机验证码 {
            Networking.request(LoginApi.sendCode(p: .init(mobile: phone))) { [weak self] result in
                self?.accountIsExsit = result.dataJson?["isExsit"].boolValue ?? false
                /*
                 在哪个页面点
                 如果在输入手机号点下一步请求验证码 成功后跳转到输入验证码
                 如果在输入验证码点重发 仅发送验证码
                */
                switch page {
                case .inputPhone:
                    self?.sendCodeRequestStatus = .completion
                    if result.isSuccess {
                        completion()
                    } else {
                        self?.logicSendCode.toastisPresented = true
                        self?.logicSendCode.toastText = result.message
                    }
                    
                case .validateCode:
                    self?.logicAuth.toastisPresented = true
                    self?.logicAuth.toastText = result.message
                }
            }
        }
        
        // 绑定手机过来
        if channel == .github || channel == .apple {
            Networking.request(ModifilerUserInfoApi.sendCode(p: .init(mobile: phone))) { [weak self] result in
                self?.sendCodeRequestStatus  = .completion

                if result.isSuccess { //绑定成功
                    completion()
                } else {
                    self?.logicSendCode.toastisPresented = true
                    self?.logicSendCode.toastText = result.message
                }
            }
        }
        
    }
    
    
  
    /// 页面的push
    private var hanlderPushBlock: Block_T?

    @Published var logicAuth = LogicAuth()
    func loginInWithCode(preparePush: @escaping (() -> Void)) {        
        logicAuth.isRequesting = true
        self.hanlderPushBlock = preparePush
        
        if channel == .手机验证码 {
            let target = LoginApi.loginInWithCode(p: .init(mobile: phone, smsCode: code))
            Networking.requestObject(target, modeType: LoginSuccessInfo.self, atKeyPath: nil) { [weak self] r, model in
                
                if let model = model, model.access_token.count > 0 {
                    UserManager.shared.loginSusscessSaveToken(model, channel: .手机验证码)
                    // 登录成功了有一个token  然后去获取用户信息
                    self?.getUserInfo() //隐藏   logicAuth.isRequesting = false
                } else { //失败
                    self?.logicAuth.isRequesting = false //失败了
                    
                    self?.logicAuth.toastisPresented = true
                    self?.logicAuth.toastText = r.message
                    #if DEBUG
                    self?.getUserInfo()
                    #endif
                }
            }
        }
        
        
        
        // 绑定手机过来
        if channel == .github || channel == .apple {
            guard let user = userInfo else { return }
            
            let ph = phone
            Networking.request(ModifilerUserInfoApi.updatePhone(p: .init(userId: user.id, mobile: phone, code: code))) { [weak self] result in
                self?.logicAuth.isRequesting = false
                if result.isSuccess {
                    UserManager.shared.updatePhone(ph)
                    self?.loginCompletion()
                } else {
                    self?.logicAuth.toastisPresented = true
                    self?.logicAuth.toastText = result.message
                }
            }
        }
       
    }
    
    func loginInWithGithub(preparePush: @escaping (() -> Void)) {
        channel = .github
        logicStart.isShowLoading = true
        hanlderPushBlock = preparePush
        
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
    
    // apple登录
    func loginInWithApple(preparePush: @escaping (() -> Void)) {
        /// 获取苹果token
        Networking.request(LoginApi.apple(p: .init(appleIdentityToken: "eyJraWQiOiJZdXlYb1kiLCJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FwcGxlaWQuYXBwbGUuY29tIiwiYXVkIjoiY29tLnRudGxpbmtpbmcubW90aW9uIiwiZXhwIjoxNjM0MzQ3MTI5LCJpYXQiOjE2MzQyNjA3MjksInN1YiI6IjAwMDIxNS4wYjAyOGE1NDc0YWE0N2YwODVhN2Y0YzcwZWRkZmZhNC4wMDQ3IiwiY19oYXNoIjoicnVHR3Awd0VyWTRKSk13VHVDRXEtdyIsImF1dGhfdGltZSI6MTYzNDI2MDcyOSwibm9uY2Vfc3VwcG9ydGVkIjp0cnVlfQ.nhTf8yeNlf6FZ91rdsd5_BOAET_1_Y2F0LLFRJh4CdkdD1h39BxUmyZwvKOFJw3W-qvy7PyUKaGL37eXYUOnM5V326bjbDvmrxZk3KB84W0Eq6hy9CBUePZ_flnOntfmGb_s9gvepjI2SfIHHw5vIUmvtXEV213PxXpke8huBmJvGs4h6lIx7I__nuwPuuy8fBAi21Hp7PmKWwtLvOewyOsjkjQ7v_85_k55AzQ30kY2XNcIVN1Rl5tUdI2-1_maeulo2Nsoi0lGWJ2I4cYl07gdxzlvtj1bCpQe5R_cuSxyClyObI_cNoNVG7xhQdMTz6FYwQU0WQfEtQRrvT0cQA", appleUserId: "000215.0b028a5474aa47f085a7f4c70eddffa4.0047"))) { [weak self] result in
            let token = result.dataJson?["access_token"].string ?? ""
            UserManager.shared.loginSusscessSaveToken(LoginSuccessInfo(access_token: token), channel: .apple)
            // 调用接口信息
            // 去绑定手机号
            self?.getUserInfo()
            
        }
        
        
//        channel = .apple
//        logicStart.isShowLoading = true
//        hanlderPushBlock = preparePush
//
//        ThirdAuth.shared.signIn(platform: .apple, completion: { [weak self] response in
//            guard let self = self  else {
//                return
//            }
//
//            guard  let res = response else {
//                self.logicStart.isShowToast = true
//                self.logicStart.toastText = "Apple登录失败"
//                self.logicStart.isShowLoading = false
//                return
//            }
//            switch res.response {
//            case let .apple(r):
//                /// 获取苹果token
//                Networking.request(LoginApi.apple(p: .init(appleIdentityToken: r.appleIdentityToken, appleUserId: r.appleUserid))) { [weak self] result in
//                    let token = result.dataJson?["access_token"].string ?? ""
//                    UserManager.shared.loginSusscessSaveToken(LoginSuccessInfo(access_token: token), channel: .apple)
//                    // 调用接口信息
//                    // 去绑定手机号
//                    self?.getUserInfo()
//
//                }
//            default: break
//            }
//
//
//        })
    }
    
    // 手机号验证码登录时
    @Published var isGetUserInfo = false
    func getUserInfo() {
        isGetUserInfo = true
        
        Networking.requestObject(CommunityServiceApi.userinfo, modeType: UserInfo.self) { [weak self] r, model in
            //判断当前账号是否存在  如果存在直接关掉视图  accountIsExsit
            guard let self = self else { return }
            self.isGetUserInfo = false
            self.logicAuth.isRequesting = false
            self.logicStart.isShowLoading = false

            
            guard let m = model else {
                self.logicAuth.toastisPresented = true
                self.logicAuth.toastText = r.message
                return
            }

            
            
            self.userInfo = m

            switch self.channel {
            case .unkown, .wechat: break
            case .手机验证码:
                if self.accountIsExsit {
                    self.loginCompletion()
                } else {
                    self.hanlderPushBlock?()
//                    self.logicAuth.isPushBaseInfoView = true
                }
            case .一键手机登陆: break
            case .github, .apple: //绑定手机号
                if UserManager.shared.user.mobileAuth { //已经授权了
                    self.loginCompletion()
                } else { // 去绑定手机号
                    self.hanlderPushBlock?()
                }
       
     
            }
            
           
            
        }
    }
    
    /// 个人资料页面 点跳过
    func loginCompletion() {
        UserManager.shared.updateSaveUserInfo(userInfo)
    }
    
    
    @Published var requestStateForBaseInfo = RequestStatus.prepare
    /// 目前只修改user name
    func updateUserBaseInfo() {
        requestStateForBaseInfo = .requesting
        
        let un = userName
        Networking.request(ModifilerUserInfoApi.updateInfo(p: .init(nickname: userName))) { [weak self] result in
            self?.requestStateForBaseInfo = .completion
            if result.isSuccess {
                self?.userInfo?.nickname = un
                
                UserManager.shared.updateSaveUserInfo(self?.userInfo)
            }
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
    }
    
    
    struct LogicSendCode {
        var toastisPresented = false
        var toastText = ""
    }
    
    
    // 填写验证码页面
    struct LogicAuth {
        var isRequesting = false
        var toastisPresented = false
        var toastText = ""
    }
    
    
}


