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
    
    @Published var isCanModifierUserName = false
    
    
    init() {
        $userName.map({ $0.count > 0 && $0 != UserManager.shared.user.username })
            .assign(to: &$isCanModifierUserName)
    }
    
    
    
    @Published var requestStateForUpdateUserName = RequestStatus.prepare
    /// 目前只修改user name success: @escaping (Bool) -> ()
    func updateUserName() {
        requestStateForUpdateUserName = .requesting
        let un = userName
        Networking.request(ModifilerUserInfoApi.updateInfo(p: .init(nickname: userName))) { [weak self] result in
            if result.isSuccess {
                UserManager.shared.updateUserName(un)
                self?.requestStateForUpdateUserName = .completion
            } else {
                self?.requestStateForUpdateUserName = .completionTip(text: result.message)
            }
        }
    }
    
}
