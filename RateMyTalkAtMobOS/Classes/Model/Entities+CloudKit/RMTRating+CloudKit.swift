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
        let rating = RMTRating(entity: RMTRating.entity(managedObjectContext), insertIntoManagedObjectContext: managedObjectContext)
        rating.ckRecordID = record.recordID.recordName
        
        let starsFloat = record.objectForKey(RMTRatingCKAttributes.stars.rawValue) as? Float
        let stars = starsFloat != nil ? starsFloat : 0.0
        rating.stars = NSNumber(float: stars!)
        if let userUUID = record.objectForKey(RMTRatingAttributes.userUUID.rawValue) as? String {
            rating.userUUID = userUUID
        }

        let ratingToRatingCategoryRelation = record.objectForKey(RMTRatingCKRelations.ratingCategory.rawValue) as? CKReference
        if ratingToRatingCategoryRelation != nil {
            let ratingCategoryID = ratingToRatingCategoryRelation?.recordID.recordName
            let ratingCategory: RMTRatingCategory? = RMTRatingCategory.ratingCategoryWithRecordID(ratingCategoryID!, managedObjectContext: managedObjectContext)
            if ratingCategory != nil {
                ratingCategory!.addRatingsObject(rating)
                rating.ratingCategory = ratingCategory
            }
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
            ckRecord.setValue(userUUID, forKey: RMTRatingAttributes.userUUID.rawValue)
        }

        let ratingCategory = self.ratingCategory!
        let ratingCategoryCK = ratingCategory.createdCKRecord()
        let ratingToRatingCategoryReference = CKReference(record: ratingCategoryCK, action: CKReferenceAction.None)
        ckRecord.setObject(ratingToRatingCategoryReference, forKey: RMTRatingCKRelations.ratingCategory.rawValue)

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

    func updateCK(ckRecord: CKRecord) {
        let starsFloat = ckRecord.objectForKey(RMTRatingCKAttributes.stars.rawValue) as? Float
        if let stars = starsFloat {
            self.stars = NSNumber(float: stars)
            
            if self.userUUID == NSUserDefaults.standardUserDefaults().userUUID {
                self.temporaryRating = stars
            }
        }
    }
}
