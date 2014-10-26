//
//  RMTNetworkActivityIndicator.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/26/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import UIKit

class RMTNetworkActivityIndicator {
    class var sharedInstance : RMTNetworkActivityIndicator {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : RMTNetworkActivityIndicator? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = RMTNetworkActivityIndicator()
        }
        return Static.instance!
    }

    private var counter: Int {
        didSet {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = counter != 0
        }
    }
    
    init() {
        self.counter = 0
    }

    func activate() {
        self.counter++
    }

    func deactivate() {
        self.counter--
    }
}
