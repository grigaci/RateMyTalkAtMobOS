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
        let title = "No connection"
        let description = "Please check the Internet connection or try again later."
        var userInfo = [NSError.titleKey : title, NSError.descriptionKey : description]
        let error = NSError(domain: NSError.appDomain, code: 0, userInfo: userInfo)
        return error
    }
}
