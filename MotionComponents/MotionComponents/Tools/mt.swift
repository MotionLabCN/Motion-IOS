//
//  mt.swift
//  MotionDesgin
//
//  Created by 梁泽 on 2021/9/7.
//

import Foundation


public struct MT<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol MTCompatible { }

extension MTCompatible {
    public static var mt: MT<Self>.Type {
          get {  return MT<Self>.self }
          set {  }
    }
    
    public var mt: MT<Self> {
        get { return MT(self) }
        set { }
    }
}

