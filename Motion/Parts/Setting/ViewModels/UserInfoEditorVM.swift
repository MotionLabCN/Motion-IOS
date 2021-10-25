//
//  UserInfoEditorVM.swift
//  Motion
//
//  Created by 梁泽 on 2021/10/25.
//

import Combine
import MotionComponents

class UserInfoEditorVM: ObservableObject {
    @Published var userName = UserManager.shared.user.username
    @Published var nickName = UserManager.shared.user.nickname

    @Published var isCanModifierName = false
    @Published var isCanModifierNickName = false

    
    init() {
        $userName.map({ $0.count > 0 && $0 != UserManager.shared.user.username })
            .assign(to: &$isCanModifierName)
        
        $nickName.map({ $0.count > 0 && $0 != UserManager.shared.user.nickname })
            .assign(to: &$isCanModifierName)
    }
    
    
    
    @Published var requestStateForUpdate = RequestStatus.prepare
    /// 目前只修改user name success: @escaping (Bool) -> ()
    func updateUserName() {
        requestStateForUpdate = .requesting
        let un = userName
        Networking.request(ModifilerUserInfoApi.updateInfo(p: .init(username: userName))) { [weak self] result in
            if result.isSuccess {
                UserManager.shared.updateUserName(un)
                self?.requestStateForUpdate = .completion
            } else {
                self?.requestStateForUpdate = .completionTip(text: result.message)
            }
        }
    }
    
    func updateNickName() {
        requestStateForUpdate = .requesting
        let nn = nickName
        Networking.request(ModifilerUserInfoApi.updateInfo(p: .init(nickname: nickName))) { [weak self] result in
            if result.isSuccess {
                UserManager.shared.updateNickName(nn)
                self?.requestStateForUpdate = .completion
            } else {
                self?.requestStateForUpdate = .completionTip(text: result.message)
            }
        }
    }

    
}
