//
//  RMTSpeaker+CloudKit.swift
//  RateMyTalkAtMobOSMaster
//
//  Created by Bogdan Iusco on 10/4/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import Foundation
import CloudKit

enum RMTSpeakerCKAttributes: NSString {
    case name = "name"
}

extension RMTSpeaker {
 
    class var ckRecordName: NSString
    {
        get { return "RMTSpeaker"}
    }

    class func create(record: CKRecord, managedObjectContext: NSManagedObjectContext) -> RMTSpeaker {
        
        var speaker: RMTSpeaker = RMTSpeaker(entity: RMTSpeaker.entity(managedObjectContext), insertIntoManagedObjectContext: managedObjectContext)
        
        speaker.ckRecordID = record.recordID.recordName
        
        let name: AnyObject! = record.valueForKey(RMTSpeakerCKAttributes.name.rawValue)
        speaker.name = name  as NSString

        return speaker;
    }
    
    class func speakerWithRecordID(recordID: NSString, managedObjectContext: NSManagedObjectContext) -> RMTSpeaker? {
        let predicate = NSPredicate(format: "%K == %@", RMTCloudKitAttributes.ckRecordID.rawValue, recordID)
        var existingObject: RMTSpeaker? = RMTSpeaker.MR_findFirstWithPredicate(predicate, inContext: managedObjectContext) as? RMTSpeaker
        return existingObject
    }

}
