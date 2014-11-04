//
//  RMTStarterCoreData.swift
//  RateMyTalkAtMobOS
//
//  Created by bogdan on 03/10/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import Foundation

@objc(RMTStarterCoreData)
class RMTStarterCoreData: NSObject, RMTStarterItem {

    func start() {
        MagicalRecord.setupCoreDataStack()
    }
}
