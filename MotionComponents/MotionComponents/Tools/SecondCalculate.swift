//
//  SecondCalculate.swift
//  SwiftComponentsDemo
//
//  Created by liangze on 2020/8/22.
//  Copyright © 2020 liangze. All rights reserved.
//

import Foundation

//MARK: - 时间计算
public struct SecondCalculate {
    public let second: TimeInterval
    /*
     "--:mm:ss"
     "hh:mm:ss"
     "mm:ss"
     */
    public let formatter: String
    
    public init(second: TimeInterval = 0, formatter: String = "--:mm:ss") {
        self.second = second
        self.formatter = formatter
    }
    
    public var hour: Int {
        guard second > 0 else {
            return 0
        }
        return Int(second) / 3600
    }
    
    public var minute: Int {
        guard second > 0 else {
            return 0
        }
        return (Int(second)/60) % 60
    }
    
    public var sec: Int {
        guard second > 0 else {
            return 0
        }
        return Int(second) % 60
    }
    
//    public var formatterText: String {
//        let hour = self.hour.formatCustom("00")
//        let minute = self.minute.formatCustom("00")
//        let sec = self.sec.formatCustom("00")
//        
//        switch formatter {
//        case "hh:mm:ss":
//            return "\(hour):\(minute):\(sec)"
//        case "--:mm:ss":
//            return self.hour > 0 ? "\(hour):\(minute):\(sec)" : "\(minute):\(sec)"
//        default:
//            return "\(hour):\(minute):\(sec)"
//        }
//    }
}
