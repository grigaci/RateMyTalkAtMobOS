//
//  RMTStarterFactory.swift
//  RateMyTalkAtMobOS
//
//  Created by bogdan on 03/10/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import Foundation

@objc(RMTStarterItem)
protocol RMTStarterItem {
    func start();
}

class RMTStarterFactory {
    var allStarters: [NSString]
    init () {
        allStarters = []
        addStarter(NSStringFromClass(RMTStarterCoreData.self))
    }

    func addStarter(starter: NSString) {
        allStarters += [starter]
    }

    func runStarters() {
        for starterClassString in allStarters {
            // With this type of reflection, the class MUST be inherited from NSObject
            var anyobjectype : AnyObject.Type = NSClassFromString(starterClassString)
            var nsobjectype : NSObject.Type = anyobjectype as NSObject.Type
            var object: AnyObject = nsobjectype()

            assert(object.conformsToProtocol(RMTStarterItem), "Doesn't conform to RMTStarterItem")
            var starterItem: RMTStarterItem = object as RMTStarterItem
            starterItem.start()
        }
    }
}
