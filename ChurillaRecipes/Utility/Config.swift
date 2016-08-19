//
//  Config.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 8/28/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import SwiftyJSON

internal final class Config: NSObject, NSCoding, Archivable, Object {
    
    let bucket: String
    let secret: String
    let accessKey: String
    
    init(json: JSON) throws {
        guard let
            bucket: String = json["bucket"].string,
            secret: String = json["secret"].string,
            key: String = json["accessKey"].string else {
                throw ObjectError.MappingError
        }
        
        self.bucket = bucket
        self.secret = secret
        self.accessKey = key
    }
    
    func toJSON() -> APIParams {
        return nil
    }
    
    static func path() -> URL {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        guard let directory = urls.first else {
            fatalError()
        }
        
        return directory.URLByAppendingPathComponent("/config")
    }
    
    func path() -> URL {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        guard let directory = urls.first else {
            fatalError()
        }
        
        return directory.URLByAppendingPathComponent("/config")
    }
    
    func archived() -> NSData {
        return NSKeyedArchiver.archivedDataWithRootObject(self)
    }

    init?(coder aDecoder: NSCoder) {
        guard let
            bucket = aDecoder.decodeObjectForKey("bucket") as? String,
            secret = aDecoder.decodeObjectForKey("secret") as? String,
            accessKey = aDecoder.decodeObjectForKey("accessKey") as? String else {
                return nil
        }
        
        self.bucket = bucket
        self.secret = secret
        self.accessKey = accessKey
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(bucket, forKey: "bucket")
        aCoder.encodeObject(secret, forKey: "secret")
        aCoder.encodeObject(accessKey, forKey: "accessKey")
    }
}
