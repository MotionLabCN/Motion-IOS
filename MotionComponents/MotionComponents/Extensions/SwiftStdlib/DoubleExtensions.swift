//
//  DoubleExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/6/16.
//  Copyright © 2016 SwifterSwift
//

#if canImport(CoreGraphics)
import CoreGraphics
#endif

#if os(macOS) || os(iOS)
import Darwin
#elseif os(Linux)
import Glibc
#endif
import Foundation

//MARK: - Methods
public extension Double {
    func format(_ f: String) -> String {
        return String(format: "%\(f)", self)
    }
    
    var numberFormat: String {
        let format = NumberFormatter()
        format.positiveFormat = "0.00;"
        format.roundingMode = .down
        return format.string(for: self) ?? ""
    }
    
    func formatCustom(_ positive: String, roundingMode: NumberFormatter.RoundingMode = .down) -> String {
        let format = NumberFormatter()
        format.positiveFormat = positive
        format.roundingMode = roundingMode
        return format.string(for: self) ?? ""
    }
}
