//
//  Fond+mt.swift
//  MotionDesgin
//
//  Created by 梁泽 on 2021/9/7.
//

import SwiftUI

extension Font: MTCompatible {
    private func using() {
        _ = Font.mt.largeTitle
    }
    
    public func mtBlod() -> Font {
//        self.weight(.black)
        switch self {
        case .mt.largeTitle: return MTFont.largeTitle.blodValue
        case .mt.title1: return MTFont.title1.blodValue
        case .mt.title2: return MTFont.title2.blodValue
        case .mt.title3: return MTFont.title3.blodValue
        case .mt.body1: return MTFont.body1.blodValue
        case .mt.body2: return MTFont.body2.blodValue
        case .mt.body3: return MTFont.body3.blodValue
        case .mt.caption1: return MTFont.caption1.blodValue
        case .mt.caption2: return MTFont.caption2.blodValue
        default:  return MTFont.body1.blodValue
        }
        
        
       

    }
}




public extension MT where Base == Font {
    static var largeTitle = MTFont.largeTitle.value
    static var title1 = MTFont.title1.value
    static var title2 = MTFont.title2.value
    static var title3 = MTFont.title3.value
    static var body1 = MTFont.body1.value
    static var body2 = MTFont.body2.value
    static var body3 = MTFont.body3.value
    static var caption1 = MTFont.caption1.value
    static var caption2 = MTFont.caption2.value
}


//MARK: - Font
public enum MTFont: CGFloat, CaseIterable, Identifiable {
    public var id: Int { Int(self.rawValue) }
    
    // large title - 大标题
    case largeTitle = 34
    // title - 标题
    case title1 = 28
    case title2 = 22
    case title3 = 20
    // body - 正文
    case body1 = 17
    case body2 = 15
    case body3 = 13
    // caption - 辅助
    case caption1 = 12
    case caption2 = 11
    
    public var value: Font {
        Font.custom("OPPOSans L", size: rawValue)
//        Font.system(size: rawValue, weight: .regular, design: .monospaced)
    }
    
    public var blodValue: Font {
        Font.custom("OPPOSans B", size: rawValue)
    }
    
    public var uifont: UIFont {
        UIFont(name: "OPPOSans L", size: rawValue) ?? UIFont.monospacedSystemFont(ofSize: rawValue, weight: .regular)
    }
    
    public var text: String {
        switch self {
        case .largeTitle: return "largeTitle"
        case .title1: return "title1"
        case .title2: return "title2"
        case .title3: return "title3"
        case .body1: return "body1"
        case .body2: return "body2"
        case .body3: return "body3"
        case .caption1: return "caption1"
        case .caption2: return "caption2"
        }
    }
}



//MARK: - UIFont
extension UIFont: MTCompatible {
    public func mtBlod() -> UIFont {
//        self.weight(.black)
        UIFont(name: "OPPOSans B", size: self.pointSize) ?? UIFont.monospacedSystemFont(ofSize: self.pointSize, weight: .regular)
//        UIFont.monospacedSystemFont(ofSize: pointSize, weight: .black)
    }
}


public extension MT where Base == UIFont {
    static var largeTitle = MTFont.largeTitle.uifont
    static var title1 = MTFont.title1.uifont
    static var title2 = MTFont.title2.uifont
    static var title3 = MTFont.title3.uifont
    static var body1 = MTFont.body1.uifont
    static var body2 = MTFont.body2.uifont
    static var body3 = MTFont.body3.uifont
    static var caption1 = MTFont.caption1.uifont
    static var caption2 = MTFont.caption2.uifont
}
