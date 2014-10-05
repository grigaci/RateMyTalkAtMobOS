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

    class func create(record: CKRecord) -> RMTSpeaker {
        
        let moc: NSManagedObjectContext = NSManagedObjectContext.MR_defaultContext()
        var speaker: RMTSpeaker = RMTSpeaker(entity: RMTSpeaker.entity(moc), insertIntoManagedObjectContext: moc)
        
        speaker.ckRecordID = record.recordID.recordName
        
        let name: AnyObject! = record.valueForKey(RMTSpeakerCKAttributes.name.toRaw())
        speaker.name = name  as NSString

        return speaker;
    }
    
    class func speakerWithRecordID(recordID: NSString) -> RMTSpeaker? {
        let moc: NSManagedObjectContext = NSManagedObjectContext.MR_defaultContext()
        let predicate = NSPredicate(format: "%K == %@", RMTCloudKitAttributes.ckRecordID.toRaw(), recordID)
        var existingObject: RMTSpeaker? = RMTSpeaker.MR_findFirstWithPredicate(predicate, inContext: moc) as? RMTSpeaker
        return existingObject
    }

}
