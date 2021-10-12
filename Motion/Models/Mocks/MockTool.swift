//
//  MockTool.swift
//  Motion
//
//  Created by 梁泽 on 2021/10/12.
//

import MotionComponents
import Foundation


struct MockTool {
 
    static func readObject<T: Convertible>(_ type: T.Type, fileName: String, atKeyPath keyPath: String? = "data") -> T? {
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"), let data = try? Data(contentsOf: url) else {
            return nil
        }
        let json =  try? JSON(data: data)
        
        if let keyPath = keyPath {
            guard let originDic = (json?.dictionaryObject as NSDictionary?)?.value(forKeyPath: keyPath) else {
                return nil
            }
            
            return JSON(originDic).dictionaryObject?.kj.model(T.self)
        }
        
        return json?.dictionaryObject?.kj.model(T.self)
    }
    
    static func readArray<T: Convertible>(_ type: T.Type, fileName: String, atKeyPath keyPath: String? = "data") -> [T]? {
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"), let data = try? Data(contentsOf: url) else {
            return nil
        }
        let json =  try? JSON(data: data)
        
        if let keyPath = keyPath {
            guard let originDic = (json?.dictionaryObject as NSDictionary?)?.value(forKeyPath: keyPath) else {
                return nil
            }
            
            return JSON(originDic).arrayObject?.kj.modelArray(T.self)
        }
        
        return json?.arrayObject?.kj.modelArray(T.self)
    }
    
    
    /// 示例
    static func using() {
        let arr = readArray(LangModel.self, fileName: "codepower_langs")
        print("")
    }
}
