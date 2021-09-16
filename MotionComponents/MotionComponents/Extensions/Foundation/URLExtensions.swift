//
//  URLExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 03/02/2017.
//  Copyright © 2017 SwifterSwift
//

#if canImport(Foundation)
import Foundation

#if canImport(UIKit) && canImport(AVFoundation)
import UIKit
import AVFoundation
#endif


//MARK: - 初始化
public extension URL {
    init(staticString string: StaticString) {
        guard let url = URL(string: "\(string)") else {
            preconditionFailure("Invalid static URL string: \(string)")
        }
        
        self = url
    }
}

extension URL: ExpressibleByStringLiteral {
    public init(stringLiteral value: StaticString) {
        guard let url = URL(string: "\(value)") else {
            preconditionFailure("This url: \(value) is not invalid")
        }
        self = url
    }
}


#endif
