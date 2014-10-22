//
//  RMTConstants.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/10/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import Foundation

func RMTLogError(message: String, function: String = __FUNCTION__, line: Int = __LINE__) {
        
        println("Error \"\(message)\" in  \(function) at line \(line))")
}

let kNotificationSessionSaveCurrentRatings = "saveRatings"
