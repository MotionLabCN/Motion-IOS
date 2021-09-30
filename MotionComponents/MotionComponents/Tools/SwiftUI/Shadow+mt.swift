//
//  Shadow+mt.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/10.
//

import SwiftUI



public enum MTShadow: String, Identifiable, CaseIterable {
    public var id: String { rawValue }
    case shadowLow, shadowMid, shadowHigh
    
    struct Config {
        let color: Color
        let radius: CGFloat
        let x: CGFloat
        let y: CGFloat
    }
    
    var config: Config {
        switch self {
        case .shadowLow: return .init(color: .black.opacity(0.08), radius: 24, x: 0, y: 3)
        case .shadowMid: return .init(color: .black.opacity(0.16), radius: 24, x: 0, y: 6)
        case .shadowHigh: return .init(color: .black.opacity(0.24), radius: 32, x: 0, y: 9)
        }
    }
    
}



