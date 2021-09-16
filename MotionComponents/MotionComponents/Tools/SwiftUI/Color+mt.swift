//
//  Color+mt.swift
//  MotionDesgin
//
//  Created by 梁泽 on 2021/9/7.
//

import SwiftUI

extension SwiftUI.Color: MTCompatible {
    private func using() {
        _ = MTColor.accent_050.value
        _ = Color.mt.accent_400
    }
}

public extension MT where Base == SwiftUI.Color {
    // Accent
    static var accent_purple = MTColor.accent_purple.value
    static var accent_900 = MTColor.accent_900.value
    static var accent_800 = MTColor.accent_800.value
    static var accent_700 = MTColor.accent_700.value
    static var accent_600 = MTColor.accent_600.value
    static var accent_500 = MTColor.accent_500.value
    static var accent_400 = MTColor.accent_400.value
    static var accent_300 = MTColor.accent_300.value
    static var accent_200 = MTColor.accent_200.value
    static var accent_100 = MTColor.accent_100.value
    static var accent_050 = MTColor.accent_050.value
    // gray
    static var gray_900 = MTColor.gray_900.value
    static var gray_800 = MTColor.gray_800.value
    static var gray_700 = MTColor.gray_700.value
    static var gray_600 = MTColor.gray_600.value
    static var gray_500 = MTColor.gray_500.value
    static var gray_400 = MTColor.gray_400.value
    static var gray_300 = MTColor.gray_300.value
    static var gray_200 = MTColor.gray_200.value
    static var gray_100 = MTColor.gray_100.value
    static var gray_050 = MTColor.gray_050.value
    // status
    static var status_danger = MTColor.status_danger.value
    static var status_warnning = MTColor.status_warnning.value
    static var status_sucess = MTColor.status_sucess.value
    static var status_play = MTColor.status_play.value
    // opacity
    static var opacity_100 = MTColor.opacity_100.value
    static var opacity_80 = MTColor.opacity_80.value
    static var opacity_60 = MTColor.opacity_60.value
}

//MARK: - Color
public enum MTColor: String, CaseIterable, Identifiable {
    public var id: String { rawValue }
    case accent_purple, accent_900, accent_800, accent_700, accent_600, accent_500, accent_400, accent_300, accent_200, accent_100, accent_050
    case gray_900, gray_800, gray_700, gray_600, gray_500, gray_400, gray_300, gray_200, gray_100, gray_050
    // Staus
    case status_danger, status_warnning, status_sucess, status_play
    // Opacity #EEEEEE
    case opacity_100, opacity_80, opacity_60
    
    public var value: SwiftUI.Color { Color(rawValue) }
    
}
