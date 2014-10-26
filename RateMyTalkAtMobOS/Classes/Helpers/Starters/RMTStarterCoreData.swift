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
        
        if !NSUserDefaults.standardUserDefaults().iCloudDataDownloaded {
            // In case of an error in a previous run we'll going to erase the database and start fresh
            let storeFileName = MagicalRecord.defaultStoreName()
            let url = NSPersistentStore.MR_urlForStoreName(storeFileName)
            NSFileManager.defaultManager().removeItemAtURL(url, error: nil)
        }
        MagicalRecord.setupCoreDataStack()
    }
}
