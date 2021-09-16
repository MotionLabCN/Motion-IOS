//
//  SwiftUICommonSetting.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/7.
//

import Foundation


public struct AppearConfig {
    public static func config() {
        /// 设置返回按钮图片 fix 导航栏返回键
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "Chevron_left_On")?.withRenderingMode(.alwaysOriginal)
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "Chevron_left_On")?.withRenderingMode(.alwaysOriginal)
        
        UINavigationBar.appearance().shadowImage = .init()
        
        UITableViewCell.appearance().selectionStyle = .blue
        
        UITableView.appearance().backgroundColor = UIColor(.mt.gray_050)
    }
}

// 隐藏返回按钮默认的文字
extension UINavigationController {
    // Remove back button text
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

}

