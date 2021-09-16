//
//  FileManagerExtensions.swift
//  SwifterSwift
//
//  Created by Jason Jon E. Carreos on 05/02/2018.
//  Copyright © 2018 SwifterSwift
//

#if canImport(Foundation)
import Foundation

//MARK: - 创建文件夹
public extension FileManager {
    func createFolder(folderName: String, for directory: SearchPathDirectory = .cachesDirectory) -> URL {
        let folderParentURL = FileManager.default.urls(for: directory, in: .userDomainMask)[0]
        let folderURL = folderParentURL.appendingPathComponent(folderName)
        do {
            try createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
            return folderURL
        } catch {
            return folderURL
        }
    }
}

#endif
