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
    case startDate = "startDate"
    case endDate = "endDate"
}

enum RMTSessionCKRelations: NSString {
    case speaker = "speaker"
}

extension RMTSession {

    class var ckRecordName: NSString
    {
        get { return "RMTSession"}
    }
    
    class func create(record: CKRecord, managedObjectContext: NSManagedObjectContext) -> RMTSession {
        
        let session: RMTSession = RMTSession(entity: RMTSession.entity(managedObjectContext), insertIntoManagedObjectContext: managedObjectContext)
        session.ckRecordID = record.recordID.recordName

        let title = record.valueForKey(RMTSessionCKAttributes.title.rawValue) as? NSString
        session.title = title
        
        let startDate = record.valueForKey(RMTSessionCKAttributes.startDate.rawValue) as? NSDate
        session.startDate = startDate
        
        let endDate = record.valueForKey(RMTSessionCKAttributes.endDate.rawValue) as? NSDate
        session.endDate = endDate
        
        let sessionToSpeakerReference = record.objectForKey(RMTSessionCKRelations.speaker.rawValue) as? CKReference
        if sessionToSpeakerReference != nil {
            let speakerRecordID = sessionToSpeakerReference?.recordID.recordName
            let speaker = RMTSpeaker.speakerWithRecordID(speakerRecordID!, managedObjectContext: managedObjectContext)
            session.speaker = speaker
        }

        return session;
    }

    class func sessionWithRecordID(recordID: NSString, managedObjectContext: NSManagedObjectContext) -> RMTSession? {
        let predicate = NSPredicate(format: "%K == %@", RMTCloudKitAttributes.ckRecordID.rawValue, recordID)
        let existingObject = RMTSession.MR_findFirstWithPredicate(predicate, inContext: managedObjectContext) as? RMTSession
        return existingObject
    }

}
