//
//  File.swift
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/11/17.
//  Copyright © 2018 com.FBBC.JoinTown. All rights reserved.
//

import Foundation

public extension UserDefaults {
    struct Key<Value> {
        var name: String
    }
    
    subscript<T>(key: Key<T>) -> T? {
        get {
            return value(forKey: key.name) as? T
        }
        set {
            setValue(newValue, forKey: key.name)
        }
    }
    
    /*use:
     let result =  UserDefaults.standard[.test]
      UserDefaults.standard[.test] = true
     let ruslut =  UserDefaults.standard[.test, default: false]
    */
    subscript<T>(key: Key<T>, default defaultProvider: @autoclosure () -> T) -> T {
        get {
            return value(forKey: key.name) as? T ?? defaultProvider()
        }
        set {
            setValue(newValue, forKey: key.name)
        }
    }
    

}

public extension UserDefaults.Key {
    static var tests: UserDefaults.Key<[String]> {
        return .init(name: "tests")
    }
    
    static var test: UserDefaults.Key<Bool> {
        return .init(name: "test")
    }
}



