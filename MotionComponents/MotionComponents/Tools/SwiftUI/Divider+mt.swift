//
//  Divider+mt.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/10.
//

import SwiftUI

extension Divider: MTCompatible {
    private func using() {
        _ = Divider.mt.defult()
    }
}




public extension MT where Base == Divider {
    static func defult() -> some View { MTDivider.defult.value() }
}


//MARK: - Font
public enum MTDivider: CGFloat, CaseIterable, Identifiable {
    public var id: Int { Int(self.rawValue) }
    
    case defult
    
    public func value() -> some View { Divider().opacity(0.6) }
    
    public var text: String {
        switch self {
        case .defult: return "Defult"
        }
    }
}

