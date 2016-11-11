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
            let secret: String = json["secret"].string,
            let key: String = json["accessKey"].string else {
                throw ObjectError.mappingError
        }
        
        self.bucket = bucket
        self.secret = secret
        self.accessKey = key
    }
    
    func toJSON() -> APIParams {
        return nil
    }
    
    static func path() -> URL {
        let urls = Foundation.FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let directory = urls.first else {
            fatalError()
        }
        
        return directory.appendingPathComponent("/config") as URL
    }
    
    func path() -> URL {
        let urls = Foundation.FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let directory = urls.first else {
            fatalError()
        }
        
        return directory.appendingPathComponent("/config") as URL
    }
    
    func archived() -> Foundation.Data {
        return NSKeyedArchiver.archivedData(withRootObject: self)
    }

    init?(coder aDecoder: NSCoder) {
        guard let
            bucket = aDecoder.decodeObject(forKey: "bucket") as? String,
            let secret = aDecoder.decodeObject(forKey: "secret") as? String,
            let accessKey = aDecoder.decodeObject(forKey: "accessKey") as? String else {
                return nil
        }
        
        self.bucket = bucket
        self.secret = secret
        self.accessKey = accessKey
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(bucket, forKey: "bucket")
        aCoder.encode(secret, forKey: "secret")
        aCoder.encode(accessKey, forKey: "accessKey")
    }
}
