//
//  ConfigStore.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 8/28/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation

internal struct ConfigStore: Store {
    
    let configFileDownload = Observable<Bool>(false)
    
    private let environment: APIProtocol

    init(environment: APIProtocol) {
        self.environment = environment
    }
    
    func downloadConfig() {
        let router = ConfigRouter()
        environment.executeRequest(router) { (result) in
            self.configFileDownload.value = true
            switch result {
            case .Success(let json):
                do {
                    let config = try Config(json: json)
                    FileManager().cacheFile(config)
                } catch {
                    print("\(json)")
                }
                
            case .Failure(let error):
                print("ERROR \(error)")
            }
        }
    }
}

