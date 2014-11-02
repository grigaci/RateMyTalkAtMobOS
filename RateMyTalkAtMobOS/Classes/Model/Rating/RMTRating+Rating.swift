//
//  RMTRating+Rating.swift
//  RateMyTalkAtMobOS
//
//  Created by bogdan on 02/11/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import Foundation

let kRatingStarsMin: Float = 0
let kRatingStarsMax: Float = 4

extension RMTRating {

    class func createUserRatingsIfNeeded() {
        let context = NSManagedObjectContext.MR_defaultContext()
        let allRatingCategories = RMTRatingCategory.MR_findAllInContext(context) as [RMTRatingCategory]
        for ratingCategory in allRatingCategories {
            ratingCategory.createMyRatingIfNeeded()
        }
    }

    class func isRatingValid(rating: Float) -> Bool {
        let greaterOrEqual: NSComparisonResult = NSNumber(float: rating).compare(NSNumber(float: kRatingStarsMin))
        let lessOrEqual: NSComparisonResult = NSNumber(float: rating).compare(NSNumber(float: kRatingStarsMax))
            
        return greaterOrEqual != .OrderedAscending && lessOrEqual != .OrderedDescending
    }

    var temporaryRating: Float {
        set {
            NSUserDefaults.standardUserDefaults().setFloat(newValue, forKey: self.ckRecordID!)
        }
        get {
            let rating = NSUserDefaults.standardUserDefaults().floatForKey(self.ckRecordID!)
            return rating
        }
    }

    func saveTemporaryRatingAsStars() {
        if RMTRating.isRatingValid(self.temporaryRating) {
            self.stars = NSNumber(float: self.temporaryRating)
            self.managedObjectContext?.MR_saveOnlySelfAndWait()
        }
    }
}
