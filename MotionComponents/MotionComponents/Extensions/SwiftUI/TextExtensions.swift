//
//  TextExtensions.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/10.
//

import SwiftUI


public extension Text {
    func font(_ font: Font, textColor: Color) -> Text {
        self.font(font)
            .foregroundColor(textColor)
    }

}
