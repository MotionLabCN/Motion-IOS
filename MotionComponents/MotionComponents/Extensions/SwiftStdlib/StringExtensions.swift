//
//  StringExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 SwifterSwift
//

import Foundation
import SwifterSwift

public extension String {

    func validateMobile() -> Bool {
        let phoneRegex: String = "^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }

    
    func font(with font: UIFont) -> NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.font: font])
    }
    
    func isContainChinese() -> Bool {
        let regex = ".*[\u{4E00}-\u{9FA5}]{1,}.*"
        let test:NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: self)
    }
    
    /// 超出几个字后打点
    func dot(forLength length: Int) -> String {
        guard count > length else {
            return self
        }
        return String(prefix(length)) +  "..."
    }
}

public extension String {
    func format(_ f: String) -> String {
        return String(format: "%\(f)", self)
    }
    
    var numberFormat: String {
        let format = NumberFormatter()
//        format.positiveFormat = "0.##;"
        format.positiveFormat = "0.00;"
        format.roundingMode = .down
        return format.string(for: Decimal(string: self)) ?? ""
    }
    
    func formatCustom(_ positive: String, roundingMode: NumberFormatter.RoundingMode = .down) -> String {
        let format = NumberFormatter()
        format.positiveFormat = positive
        format.roundingMode = roundingMode
        return format.string(for:  Decimal(string:self)) ?? ""
    }
    
    func rangeOf(_ text: String) -> NSRange {
        return (self as NSString).range(of: text)
    }
    
    func rangeAll() -> NSRange {
        return rangeOf(self)
    }
    
    func boundingWidth(with font: UIFont) -> CGFloat {
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: font.lineHeight)
        let preferredRect = (self as NSString).boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(preferredRect.width)
    }
    
    func bounding(with font: UIFont, size: CGSize) -> CGSize {
//        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: font.lineHeight)
        let preferredRect = (self as NSString).boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return preferredRect.size
    }
    
 
    
    var toDouble: Double { self.double() ?? 0 }
}


public extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
}

public extension Substring {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
}

public extension String {
    static func + (lhs: String, rhs: NSAttributedString) -> NSAttributedString {
        let string = NSMutableAttributedString(string: lhs)
        string.append(rhs)
        return NSAttributedString(attributedString: string)
    }
}
