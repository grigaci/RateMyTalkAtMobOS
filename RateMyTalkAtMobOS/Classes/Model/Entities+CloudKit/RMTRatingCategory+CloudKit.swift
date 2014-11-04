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
    
    
    class func create(record: CKRecord, managedObjectContext: NSManagedObjectContext) -> RMTRatingCategory {
        let ratingCategory = RMTRatingCategory(entity: RMTRatingCategory.entity(managedObjectContext), insertIntoManagedObjectContext: managedObjectContext)
        ratingCategory.ckRecordID = record.recordID.recordName
        
        let title = record.objectForKey(RMTRatingCategoryCKAttributes.title.rawValue) as? NSString
        ratingCategory.title = title

        ratingCategory.ckRecordID = record.recordID.recordName

        let ratingCategoryToSessionRelation = record.objectForKey(RMTRatingCategoryCKRelation.session.rawValue) as? CKReference
        if ratingCategoryToSessionRelation != nil {
            let sessionRecordID = ratingCategoryToSessionRelation?.recordID.recordName
            let session: RMTSession? = RMTSession.sessionWithRecordID(sessionRecordID!, managedObjectContext: managedObjectContext)
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

    class func ratingCategoryWithRecordID(recordID: NSString, managedObjectContext: NSManagedObjectContext) -> RMTRatingCategory? {
        let predicate = NSPredicate(format: "%K == %@", RMTCloudKitAttributes.ckRecordID.rawValue, recordID)
        let existingObject = RMTRatingCategory.MR_findFirstWithPredicate(predicate, inContext: managedObjectContext) as? RMTRatingCategory
        return existingObject
    }
    
    class func ratingCategoryWithID(ratingCategoryID: String, managedObjectContext: NSManagedObjectContext) -> RMTRatingCategory? {
        let predicate = NSPredicate(format: "%K == %@", RMTRatingCategoryAttributes.ratingCategoryID.rawValue, ratingCategoryID)
        let existingObject = RMTRatingCategory.MR_findFirstWithPredicate(predicate, inContext: managedObjectContext) as? RMTRatingCategory
        return existingObject
    }

}
