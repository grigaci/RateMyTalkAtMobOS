//
//  NSUserDefaults+Extra.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/12/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import Foundation

extension NSUserDefaults {
    var userUUID: String {
        get
        {
            let uuid = self.objectForKey("userUUID") as? String
            if uuid == nil {
                let newUUID = NSUUID().UUIDString
                self.setObject(newUUID, forKey: "userUUID")
                self.synchronize()
                return newUUID
            }
            return uuid!
        }
    }

    var iCloudDataDownloaded: Bool {
        get {
            let isDownloaded = self.boolForKey("iCloudDataDownloaded")
            return isDownloaded
        }
        set {
            self.setBool(newValue, forKey: "iCloudDataDownloaded")
        }
    }
}
