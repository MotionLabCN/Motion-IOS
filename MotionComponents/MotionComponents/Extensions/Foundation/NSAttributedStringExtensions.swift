//
//  NSAttributedStringExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 26/11/2016.
//  Copyright © 2016 SwifterSwift
//

#if canImport(Foundation)
import Foundation

#if canImport(UIKit)
import UIKit
#endif

#if canImport(Cocoa)
import Cocoa
#endif


//MARK: -
public extension NSAttributedString {    
    func font(with font: UIFont) -> NSAttributedString {
        let copy = NSMutableAttributedString(attributedString: self)
        let range = (string as NSString).range(of: string)
        copy.addAttributes([.font: font], range: range)
        return copy
    }
    
    func range(of: String) -> NSRange {
        let range = (string as NSString).range(of: of)
        return range
    }
    
    func rangeAll() -> NSRange {
        range(of: string)
    }
}

#endif
