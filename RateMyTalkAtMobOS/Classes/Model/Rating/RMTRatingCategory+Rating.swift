//
//  RMTRatingCategory+Rating.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/11/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import Foundation
import CoreData

extension RMTRatingCategory {

    func totalRating() -> Float {
        var totalRating: Float = 0.0
        let allRatings = self.ratings
        let allRatingsCount = allRatings.count
        var countValidRatings: Float = 0.0
        if allRatingsCount == 0 {
            return totalRating
        }

        for index in 0...allRatingsCount - 1 {
            let rating = allRatings.objectAtIndex(index) as RMTRating
            if let starsNumber = rating.stars {
                if starsNumber.floatValue > 0 {
                    totalRating += starsNumber.floatValue
                    countValidRatings += 1.0
                }
            }
        }

        if countValidRatings > 0.0 {
            totalRating = totalRating / Float(countValidRatings)
            totalRating = totalRating.roundStars()
        }
        return totalRating
    }
    
    func myRating() -> RMTRating? {
        let userUUID = NSUserDefaults.standardUserDefaults().userUUID
        let moc: NSManagedObjectContext = NSManagedObjectContext.MR_defaultContext()
        let predicate = NSPredicate(format: "%K == %@ AND %K == %@", RMTRatingRelationships.ratingCategory.rawValue, self,
            RMTRatingAttributes.userUUID.rawValue, userUUID)
        var existingObject: RMTRating? = RMTRating.MR_findFirstWithPredicate(predicate, inContext: moc) as? RMTRating
        return existingObject
    }

    func createMyRatingIfNeeded() -> RMTRating {
        if let existingRating = self.myRating() {
            return existingRating
        }
        
        let moc: NSManagedObjectContext = NSManagedObjectContext.MR_defaultContext()
        var rating: RMTRating = RMTRating(entity: RMTRating.entity(moc), insertIntoManagedObjectContext: moc)
        let userUUID = NSUserDefaults.standardUserDefaults().userUUID
        
        rating.userUUID = userUUID
        rating.ratingCategory = self
        self.addRatingsObject(rating)
        rating.createCKRecordIDIfNeeded()

        moc.MR_saveOnlySelfAndWait()
        return rating
    }

}
