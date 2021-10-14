//
//  Double.swift
//  Motion
//
//  Created by Beck on 2021/10/13.
//

import Foundation

extension Double {
    /// 浮点型字符转换为货币格式 保留二位小数
    /// ```
    /// Conver 1234.56 to $1,234.56
    /// Conver 12.3456 to $12.34
    /// Conver 0.123456 to $0.12
    ///```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
//        formatter.locale = .current// 默认
//        formatter.currencyCode = "usd"// 默认
        formatter.currencySymbol = "¥" // 默认美元符号
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    /// 浮点型字符转换为货币格式 保留二位小数
    /// ```
    /// Conver 1234.56 to 1,234.56
    ///```
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "¥0.00"
    }
    
    /// double类型转换为保留二位小数的字符串
    /// ```
    /// Conver 1.2345 to 1.23
    ///```
    func asNUmberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// double类型转换为百分比字符串
    /// ```
    /// Conver 1.2345 to 1.23%
    ///```
    func asPercentString() -> String {
        return asNUmberString() + "%"
    }
}
