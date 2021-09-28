//
//  DiskCache.swift
//  JadeSocial
//
//  Created by liangze on 2020/4/4.
//  Copyright © 2020 Rick. All rights reserved.
//

import KakaJSON


public extension Convertible {
    
    func cacheOnDisk(fileName: String, folder: String = "MotionCacheFiles", for directory: FileManager.SearchPathDirectory = .cachesDirectory) {
        let file = Self.self.fileURL(forFolder: folder, for: directory, fileName: fileName)
        write(self, to: file)
    }
    
    static func getForDisk(fileName: String, folder: String = "MotionCacheFiles", for directory: FileManager.SearchPathDirectory = .cachesDirectory) -> Self? {
        let file = fileURL(forFolder: folder, for: directory, fileName: fileName)
        return read(self, from: file)
    }
    
    private static func fileURL(forFolder folder: String, for directory: FileManager.SearchPathDirectory, fileName: String) -> URL {
        let type = String(describing: self)
        let file = "\(type)-\(fileName).json"
        let folderURL = FileManager.default.createFolder(folderName: folder, for: directory)
        let fileURL = folderURL.appendingPathComponent(file)
        return fileURL
    }
}



