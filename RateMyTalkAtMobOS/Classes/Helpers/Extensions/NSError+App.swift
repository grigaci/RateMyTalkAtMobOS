//
//  NSError+App.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/18/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import Foundation

extension NSError {
     class var titleKey: String  {
        get {
            return "windowTitle"
        }
    }

    class var descriptionKey: String  {
        get {
            return "windowDescription"
        }
    }

    class var appDomain: String  {
        get {
            return "RMTRateMyTalk"
        }
    }

    var titleText: String?  {
        get {
            if let dictionary = self.userInfo {
                if let title = dictionary[NSError.titleKey] as? NSString {
                    return title
                }
            }
            return nil
        }
    }

    var descriptionText: String?  {
        get {
            if let dictionary = self.userInfo {
                if let description = dictionary[NSError.descriptionKey] as? NSString {
                    return description
                }
            }
            return nil
        }
    }

    class func internetConnectionError() -> NSError {
        let title = NSLocalizedString("No connection", comment: "No internet error title")
        let description = NSLocalizedString("Please check your internet connection.", comment: "No internet error description")
        var userInfo = [NSError.titleKey : title, NSError.descriptionKey : description]
        let error = NSError(domain: NSError.appDomain, code: 0, userInfo: userInfo)
        return error
    }

    class func cloudKitConnectionError() -> NSError {
        let title = NSLocalizedString("CloudKit error", comment: "Cloudkit error title")
        let description = NSLocalizedString("Cannot sync your ratings. Please make sure that you are logged into your iCloud account and iCloud Drive is enabled.", comment: "Cloudkit error description")
        var userInfo = [NSError.titleKey : title, NSError.descriptionKey : description]
        let error = NSError(domain: NSError.appDomain, code: 0, userInfo: userInfo)
        return error
    }
}
