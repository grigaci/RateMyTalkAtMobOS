//
//  RMTSession+Rating.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/11/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import Foundation
import CoreData

extension RMTSession {
    
    class func saveAllMyRatings() {
        if let allSessions = RMTSession.MR_findAllInContext(NSManagedObjectContext.MR_defaultContext()) as? [RMTSession] {
            for session in allSessions {
                session.saveMyRatings()
            }
        }
    }

    class func calculateAllGeneralRatings() {
        if let allSessions = RMTSession.MR_findAllInContext(NSManagedObjectContext.MR_defaultContext()) as? [RMTSession] {
            for session in allSessions {
                session.calculateGeneralRating()
            }
        }
    }

    func calculateGeneralRating() {
        var totalRating: Float = 0.0
        let allRatingCategories = self.ratingCategories
        let allRatingCategoriesCount = allRatingCategories.count
        if allRatingCategoriesCount == 0 {
            self.generalRating = NSNumber(float: 0.0)
            return
        }

        for index in 0...allRatingCategoriesCount - 1 {
            let ratingCategory = allRatingCategories.objectAtIndex(index) as RMTRatingCategory
            let ratingCategoryTotalStars = ratingCategory.totalRating()
            totalRating += ratingCategoryTotalStars
        }

        totalRating = totalRating / Float(allRatingCategoriesCount)
        totalRating = totalRating.roundStars()
        self.generalRating = NSNumber(float: totalRating)
    }
}
