//
//  RMTSession+CloudKit.swift
//  RateMyTalkAtMobOSMaster
//
//  Created by Bogdan Iusco on 10/4/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import Foundation
import CloudKit

enum RMTSessionCKAttributes: NSString {
    case title = "title"
}

enum RMTSessionCKRelations: NSString {
    case speaker = "speaker"
}

extension RMTSession {

    class var ckRecordName: NSString
    {
        get { return "RMTSession"}
    }
}
