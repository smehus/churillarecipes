//
//  Observable.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 8/28/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation

internal struct Listener<T> {
    let observer: AnyObject
    let event: ((T) -> Void)
}

internal final class Observable<T> {
    
    private var observers = [Listener<T>]()
    
    var value: T {
        didSet {
            fire()
        }
    }
    
    init(_ v: T) {
        value = v
    }
    
    func startListening(observer: AnyObject, event: (T) -> Void) {
        let listener = Listener(observer: observer, event: event)
        observers.append(listener)
    }
    
    func fire() {
        for listener in observers {
            listener.event(value)
        }
    }
    
}
