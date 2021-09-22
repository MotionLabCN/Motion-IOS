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
private let UserDiskCacheFileName = "currentUser"
class UserManager: ObservableObject {
    struct User: Convertible {
        
        var nickName = ""
    }
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
        if let u = User.getForDisk(fileName: UserDiskCacheFileName) {
            user = u
        }
    }
//    @AppStorage("token") var token = "" 示例
    
    @Published private(set) var user = User() {
        didSet {
            user.cacheOnDisk(fileName: UserDiskCacheFileName) // 磁盘缓存
        }
    }
    
    func save(userJson: [String: Any]?) { //网络请求后
        if let u = userJson?.kj.model(User.self)  {
            user = u
        }
    }
    /// 修改用户昵称 并触发 Publisher 示例
    func changeNickName(_ name: String)  {
        var tmp = user
        tmp.nickName = name
        user = tmp
    }
    
    func logout() {
        user = User()
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






//MARK: - 测试
extension UserManager {
    static func test() {
        UserManager.shared.$user
            .sink { user in
                print("user= \(user)l")
            }
            .store(in: &UserManager.shared.cancellable)
        testSave()
        
        print("")
        
        testChangeNickName()
        
        print("")
        
        UserManager.shared.logout()
        
        print("")
    }
    
    static func testSave() {
        UserManager.shared.save(userJson: ["nickName" :"liangze"])
    }
    
    static func testChangeNickName() {
        UserManager.shared.changeNickName("梁泽")
    }
}
