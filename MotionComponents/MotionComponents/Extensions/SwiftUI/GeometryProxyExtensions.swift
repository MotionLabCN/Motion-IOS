//
//  GeometryProxyExtension.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/8.
//

import SwiftUI

public extension GeometryProxy {
    var width: CGFloat { size.width }
    var height: CGFloat { size.height }
    var min: CGFloat { Swift.min(width, height) }
}
