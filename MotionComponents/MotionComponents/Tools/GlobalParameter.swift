//
//  GlobalParameter.swift
//  LearningSwift
//
//  Created by 梁泽 on 2018/9/14.
//  Copyright © 2018年 梁泽. All rights reserved.
//

import UIKit
/*
 Todo: 34 - 40 安全区域
 */

public func ScreenWidth() -> CGFloat { UIScreen.main.bounds.width }
public func ScreenHeight() -> CGFloat { UIScreen.main.bounds.height }
public func ScreenSize() -> CGSize { UIScreen.main.bounds.size }

public func StatusBarH() -> CGFloat {
//    UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
//           statusBarHeight = statusBarManager.statusBarFrame.size.height;
    UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0//.windowScene?.statusBarManager?.statusBarFrame.height ?? 20
}

public func SafeBottomArea() -> CGFloat  {
    UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
}

public func MTSCALE() -> CGFloat { ScreenWidth() / 375 }

public let NavBarH: CGFloat = 44
public let ISIphoneX  = (StatusBarH() >= 44)
public let TabbarHeight: CGFloat = 50

/// 分页请求入参
public let pageStart = 0
public let limitSize = 20



public typealias Block_T = () -> Void
public typealias Block_T_String = (String?) -> Void
public typealias Block_T_Bool = (Bool) -> Void
public typealias Block_T_Any = (Any?) -> Void



public enum RequestStatus: Equatable {
    /// 准备状态
    case prepare
    /// 请求中
    case requesting
    /// 请求完成
    case completion
    case completionTip(text: String, status: MTPushNofi.PushNofiType = .defult)
    
    public var isRequesting: Bool {
        switch self {
        case .requesting: return true
        default: return false
        }
    }
}





