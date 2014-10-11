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
    
    class func create(record: CKRecord) -> RMTRating {
        let moc = NSManagedObjectContext.MR_defaultContext()
        let rating = RMTRating(entity: RMTRating.entity(moc), insertIntoManagedObjectContext: moc)
        rating.ckRecordID = record.recordID.recordName
        
        let starsFloat = record.objectForKey(RMTRatingCKAttributes.stars.toRaw()) as? Float
        let stars = starsFloat != nil ? starsFloat : 0.0
        rating.stars = NSNumber(float: stars!)

        let ratingToRatingCategoryRelation = record.objectForKey(RMTRatingCKRelations.ratingCategory.toRaw()) as? CKReference
        if ratingToRatingCategoryRelation != nil {
            let ratingCategoryID = ratingToRatingCategoryRelation?.recordID.recordName
            let ratingCategory: RMTRatingCategory? = RMTRatingCategory.ratingCategoryWithRecordID(ratingCategoryID!)
            if ratingCategory != nil {
                ratingCategory?.addRatingsObject(rating)
            }
        }
        
        return rating
    }

    class func ratingWithRecordID(recordID: NSString) -> RMTRating? {
        let moc = NSManagedObjectContext.MR_defaultContext()
        let predicate = NSPredicate(format: "%K == %@", RMTCloudKitAttributes.ckRecordID.toRaw(), recordID)
        let existingObject = RMTRating.MR_findFirstWithPredicate(predicate, inContext: moc) as? RMTRating
        return existingObject
    }

}
