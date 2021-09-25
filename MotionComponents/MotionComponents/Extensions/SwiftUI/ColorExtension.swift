//
//  ColorExtension.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/11.
//

import SwiftUI


public extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
    
    static var random: Color {
        let red = Double(arc4random()%256)/255.0
        let green = Double(arc4random()%256)/255.0
        let blue = Double(arc4random()%256)/255.0
        return Color(.sRGB, red: red, green: green, blue: blue, opacity: 1)
    }
    
    var uicolor: UIColor { UIColor(self) }
}
