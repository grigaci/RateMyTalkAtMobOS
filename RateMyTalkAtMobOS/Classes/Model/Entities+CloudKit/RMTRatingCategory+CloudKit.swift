//
//  RMTRatingCategory+CloudKit.swift
//  RateMyTalkAtMobOSMaster
//
//  Created by Bogdan Iusco on 10/4/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import Foundation
import CloudKit

enum RMTRatingCategoryCKAttributes: NSString {
    case title = "title"
    case detail = "detail"
}

enum RMTRatingCategoryCKRelation: NSString {
    case session = "session"
}

extension RMTRatingCategory {

    class var ckRecordName: NSString
    {
        get { return "RMTRatingCategory"}
    }
    
}
