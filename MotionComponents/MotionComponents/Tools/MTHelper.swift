//
//  MTHelper.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/27.
//

import Foundation


public struct MTHelper {
    public static func closeKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
    }
}
