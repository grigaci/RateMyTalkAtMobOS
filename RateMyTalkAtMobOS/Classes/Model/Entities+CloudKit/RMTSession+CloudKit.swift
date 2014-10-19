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
    
    class func create(record: CKRecord) -> RMTSession {
        
        let moc: NSManagedObjectContext = NSManagedObjectContext.MR_defaultContext()
        let session: RMTSession = RMTSession(entity: RMTSession.entity(moc), insertIntoManagedObjectContext: moc)
        session.ckRecordID = record.recordID.recordName

        let title = record.valueForKey(RMTSessionCKAttributes.title.toRaw()) as? NSString
        session.title = title
        
        let startDate = record.valueForKey(RMTSessionCKAttributes.startDate.toRaw()) as? NSDate
        session.startDate = startDate
        
        let endDate = record.valueForKey(RMTSessionCKAttributes.endDate.toRaw()) as? NSDate
        session.endDate = endDate
        
        let sessionToSpeakerReference = record.objectForKey(RMTSessionCKRelations.speaker.toRaw()) as? CKReference
        if sessionToSpeakerReference != nil {
            let speakerRecordID = sessionToSpeakerReference?.recordID.recordName
            let speaker = RMTSpeaker.speakerWithRecordID(speakerRecordID!)
            session.speaker = speaker
        }

        return session;
    }
    
    class func sessionWithRecordID(recordID: NSString) -> RMTSession? {
        let moc: NSManagedObjectContext = NSManagedObjectContext.MR_defaultContext()
        let predicate = NSPredicate(format: "%K == %@", RMTCloudKitAttributes.ckRecordID.toRaw(), recordID)
        let existingObject = RMTSession.MR_findFirstWithPredicate(predicate, inContext: moc) as? RMTSession
        return existingObject
    }

}
