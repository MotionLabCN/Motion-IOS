//
//  EdgeInsetsExtensions.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/10.
//

import SwiftUI

public extension SwiftUI.EdgeInsets {
    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
}
