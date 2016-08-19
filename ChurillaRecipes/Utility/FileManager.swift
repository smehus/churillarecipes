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
    
    private let fileManager = NSFileManager.defaultManager()
    
    private var documentsDirectory: NSURL {
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        guard let directory = urls.first else {
            fatalError()
        }
        
        return directory
    }
    

    func cacheFile(file: Archivable) {
        
        if fileManager.fileExistsAtPath(file.path().path!) {
            do {
                try fileManager.removeItemAtPath(Paths.configFilePath)
            } catch {
                fatalError()
            }
        }
        
        do {
            try file.archived().writeToURL(file.path(), options: .AtomicWrite)
        } catch {
            fatalError()
        }
    }
    
    func retrieveConfigFile() {
        
    }
}
