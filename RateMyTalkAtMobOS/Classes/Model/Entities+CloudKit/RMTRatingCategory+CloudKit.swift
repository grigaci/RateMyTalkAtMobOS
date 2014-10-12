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
    
    
    class func create(record: CKRecord) -> RMTRatingCategory {
        let moc = NSManagedObjectContext.MR_defaultContext()
        let ratingCategory = RMTRatingCategory(entity: RMTRatingCategory.entity(moc), insertIntoManagedObjectContext: moc)
        ratingCategory.ckRecordID = record.recordID.recordName
        
        let title = record.objectForKey(RMTRatingCategoryCKAttributes.title.toRaw()) as? NSString
        ratingCategory.title = title
        
        let detail = record.objectForKey(RMTRatingCategoryCKAttributes.detail.toRaw()) as? NSString
        ratingCategory.detail = detail

        let ratingCategoryToSessionRelation = record.objectForKey(RMTRatingCategoryCKRelation.session.toRaw()) as? CKReference
        if ratingCategoryToSessionRelation != nil {
            let sessionRecordID = ratingCategoryToSessionRelation?.recordID.recordName
            let session: RMTSession? = RMTSession.sessionWithRecordID(sessionRecordID!)
            if session != nil {
                session?.addRatingCategoriesObject(ratingCategory)
            }
        }
    
        return ratingCategory
    }

    func createdCKRecord() -> CKRecord {
        var ckRecord: CKRecord
        let recordIDString = self.ckRecordID!
        let recordID = CKRecordID(recordName: recordIDString)
        ckRecord = CKRecord(recordType: RMTRating.ckRecordName, recordID: recordID)
        return ckRecord;
    }

    class func ratingCategoryWithRecordID(recordID: NSString) -> RMTRatingCategory? {
        let moc = NSManagedObjectContext.MR_defaultContext()
        let predicate = NSPredicate(format: "%K == %@", RMTCloudKitAttributes.ckRecordID.toRaw(), recordID)
        let existingObject = RMTRatingCategory.MR_findFirstWithPredicate(predicate, inContext: moc) as? RMTRatingCategory
        return existingObject
    }
}
