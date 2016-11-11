//
//  FileManager.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 8/28/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation

typealias File = AnyObject

private struct Paths {
    static let configPath = "/config"
    static let configFilePath = "/config/config.json"
}

internal struct FileManager {
    
    fileprivate let fileManager = Foundation.FileManager.default
    
    fileprivate var documentsDirectory: Foundation.URL {
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        guard let directory = urls.first else {
            fatalError()
        }
        
        return directory
    }
    

    func cacheFile(_ file: Archivable) {
        
        if fileManager.fileExists(atPath: file.path().path) {
            do {
                try fileManager.removeItem(atPath: Paths.configFilePath)
            } catch {
                fatalError()
            }
        }
        
        do {
            try file.archived().write(to: file.path(), options: .atomicWrite)
        } catch {
            fatalError()
        }
    }
    
    func retrieveConfigFile() {
        
    }
}
