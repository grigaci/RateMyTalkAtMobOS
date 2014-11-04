//
//  RMTRating+CloudKit.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/11/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import Foundation
import CloudKit

enum RMTRatingCKAttributes: NSString {
    case stars = "stars"
    case ratingCategoryID = "ratingCategoryID"
    case userUUID = "userUUID"
}

enum RMTRatingCKRelations: NSString {
    case ratingCategory = "ratingCategory"
}

extension RMTRating {
    
    // CloudKit record name
    class var ckRecordName: NSString
    {
        get { return "RMTRating"}
    }
    
    class func create(record: CKRecord, managedObjectContext: NSManagedObjectContext) -> RMTRating {
        let rating = RMTRating.insertInContext(managedObjectContext)
        rating.ckRecordID = record.recordID.recordName

        let starsFloat = record.objectForKey(RMTRatingCKAttributes.stars.rawValue) as? Float
        let stars = starsFloat != nil ? starsFloat : 0.0
        rating.stars = NSNumber(float: stars!)
        if let userUUID = record.objectForKey(RMTRatingCKAttributes.userUUID.rawValue) as? String {
            rating.userUUID = userUUID
        }
        
        if let ratingCategoryIDString = record.objectForKey(RMTRatingCKAttributes.ratingCategoryID.rawValue) as? String {
            let ratingCategory = RMTRatingCategory.ratingCategoryWithID(ratingCategoryIDString, managedObjectContext: managedObjectContext)
            ratingCategory?.addRatingsObject(rating)
            rating.ratingCategory = ratingCategory
        }
        return rating
    }

    func ckRecord() -> CKRecord? {

        if let stars = self.stars {
            if !stars.floatValue.isRatingValid() {
                return nil
            }
        }

        var ckRecord: CKRecord
        self.createCKRecordIDIfNeeded()

        let recordIDString = self.ckRecordID!
        let recordID = CKRecordID(recordName: recordIDString)
        ckRecord = CKRecord(recordType: RMTRating.ckRecordName, recordID: recordID)

        if let stars = self.stars {
            ckRecord.setValue(stars.doubleValue, forKey: RMTRatingCKAttributes.stars.rawValue)
        }

        if let userUUID = self.userUUID {
            ckRecord.setValue(userUUID, forKey: RMTRatingCKAttributes.userUUID.rawValue)
        }

        let ratingCategory = self.ratingCategory!
        ckRecord.setValue(ratingCategory.ratingCategoryID!.stringValue, forKey: RMTRatingCKAttributes.ratingCategoryID.rawValue)

        return ckRecord;
    }

    func createCKRecordIDIfNeeded() {
        if self.ckRecordID == nil {
            let ckRecord = CKRecord(recordType: RMTRating.ckRecordName)
            self.ckRecordID = ckRecord.recordID.recordName
            NSManagedObjectContext.MR_contextForCurrentThread().MR_saveOnlySelfAndWait()
        }
    }

    class func ratingWithRecordID(recordID: NSString, managedObjectContext: NSManagedObjectContext) -> RMTRating? {
        let predicate = NSPredicate(format: "%K == %@", RMTCloudKitAttributes.ckRecordID.rawValue, recordID)
        let existingObject = RMTRating.MR_findFirstWithPredicate(predicate, inContext: managedObjectContext) as? RMTRating
        return existingObject
    }
}
