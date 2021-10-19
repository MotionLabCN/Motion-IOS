//
//  UserManager.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/19.
//

import MotionComponents
import SwiftUI

/*
 swiftUI 代码结构  https://www.youtube.com/watch?v=JfSiO2OjqTo&list=PLHWvYoDHvsOUoqeFqHp2xEe6njKEk04kH&index=8
 */

//MARK: - 用户模型
struct UserInfo: Convertible {
    var id = "" //: "e897c635-9ce6-4aa8-a9c0-e14180cee3e7",
    var username = "Motion用户" //: "15527864162",
    var nickname = "@motion" //: "15527864162",
    var headImgUrl = "" //: null,
    var country = "" //: null,
    var province = "" //: null,
    var city = "" //: null,
    var mobile = "" //: "15527864162",
    var realName = "" //: null,
    var sex = "" //: null,
    var email = "" //: null,
    var lastLoginTime = "" //: null,
    var emailAuth = false //: false,
    var mobileAuth = false //: true,
    var wechatAuth = false //: false,
    var age = "" //: null,
    var profession = "" //: null,
    var education = "" //: null,
    var weight = "" //: null,
    var openid = "" //: null,
    var unionid = "" //: null,
    var tcc = "" //: 0,
    var metaCoin = "" //: 5000,
    var linkNum = 0 //: 0,
    var bylinkNum = 0 //: 0,
    var description = "" //: null,
    var lastActiveTime = "" //: "2021-10-12 16:03:10",
    var linkUrl = "" //: null
}


struct LoginSuccessInfo: Convertible {
    //1.一键手机登陆 2.github 3.apple 4.wechat 5.手机验证码
    enum ChannelType: String, ConvertibleEnum {
        case unkown = "", 一键手机登陆 = "1", github = "2", apple = "3", wechat = "4", 手机验证码 = "5"
    }
    
    var access_token = ""
    var token_type = "" //: "bearer",
    var refresh_token = "" //: "",
    var expires_in = 0 //: 28799,
    var scope = "" //: "all",
    var jti = "" //: "4529eb3c-be6f-455e-9405-57b32ef42275"
    var channel = ChannelType.unkown
}


//MARK: - 用户管理
private let UserDiskCacheFileName = "currentUser"
private let CurrenTokenInfo = "CurrenTokenInfo"
class UserManager: ObservableObject {
    /* 在App环境下通过
     .environmentObject(UserManager.shared) 注入
     或
     @Environment(\.userManager) var userManager 注入
     更具备swiftui style
     */
    static let shared = UserManager()
    var cancellable = Set<AnyCancellable>()
    init() {
        #if DEBUG
        let directory = FileManager.default.createFolder(folderName: "MotionCacheFiles")
        print("模型缓存目录: \(directory)")
        #endif
        if let u = UserInfo.getForDisk(fileName: UserDiskCacheFileName) {
            user = u
        }
        if let to = LoginSuccessInfo.getForDisk(fileName: CurrenTokenInfo) {
            tokenInfo = to
        }
        
    }
    
    @Published private(set) var user = UserInfo() {
        didSet {
            user.cacheOnDisk(fileName: UserDiskCacheFileName) // 磁盘缓存
        }
    }
    
    private(set) var tokenInfo = LoginSuccessInfo() {
        didSet {
            tokenInfo.cacheOnDisk(fileName: CurrenTokenInfo)
        }
    }
    var token: String {
        "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJjcnQiOiIxNjM0NjIyNDg4ODg4IiwidXNlcl9pZCI6ImE3NTdiZDU5LWRhMTUtNDM2OS1hNzViLWRlNDI4NWJhZGQ4YyIsInNjb3BlIjpbImFsbCJdLCJtb2JpbGUiOiIxNTUyNzg2NDE2MiIsImV4cCI6MTYzNDY1MTI4OCwiZGV2aWNlIjoiUEMiLCJqdGkiOiIxYWIxZDY5MS1mN2U2LTRkMzEtOWI0YS1iZTQyZTEyZWEzYTQiLCJjbGllbnRfaWQiOiJ0bnRsaW5raW5nIn0.WqcHE9xiosNJMwfhwdbcT0m4l4R6DYM67H0UhDHL8HVYZcXOXP9nIiLpp4h49xwWLM2AP37S0Zx6XU1dmLtoayj1rLLec080Sf-rTzvbN2KknJmsbGVMkpxtLn66aaWjSwvXb5IQxjUlpcldl_mmAAgBaAo5oBr6S8Pqttg75bwmJ91o57rDJYqyzKb_PhcmJNeSQRVldpp7xLhSmM4jQtbTMO77I7LAhVqhK-p9HmZ6-gvxV1hlhsFdCJBBbweY9_OwpAlLmxIIjiJYyoKfKrChl9pqQlQEAofX_0bzSvl2S29MzetrsxZ5fe9m5m07Bk5U3DhZbB3oKp3KHmg9Yg"
//        tokenInfo.access_token
    }
    var channel: String { tokenInfo.channel.rawValue }

    
    var hasLogin: Bool {
        user.id.count > 0
    }

    func loginSusscessSaveToken(_ token: LoginSuccessInfo, channel: LoginSuccessInfo.ChannelType) {
        var tmp = token
        tmp.channel = channel
        self.tokenInfo = tmp
    }
    
    func updateSaveUserInfo(_ user: UserInfo?) { //网络请求后
        withAnimation(.easeInOut(duration: 1)) {
            self.user = user ?? .init()
        }
    }
    
    /// 修改用户昵称 并触发 Publisher 示例
    func changeNickName(_ name: String)  {

    }
    
    func updatePhone(_ phone: String) {
        user.mobile = phone
        user.mobileAuth = true 
    }
    
    func logout() {
        tokenInfo = .init()
        withAnimation(.easeInOut(duration: 1)) {
            user = UserInfo()
        }
    }
    
}












//MARK: - Environment示例
struct UserManagerEnvironmentKey: EnvironmentKey {
    static var defaultValue = UserManager.shared
}

extension EnvironmentValues {
    var userManager: UserManager {
        get { self[UserManagerEnvironmentKey.self] }
        set {self[UserManagerEnvironmentKey.self] = newValue }
    }
}

struct UserManagerTestView {
    @Environment(\.userManager) var userManager
//    var body: some View {
//        EmptyView()
//    }
}


