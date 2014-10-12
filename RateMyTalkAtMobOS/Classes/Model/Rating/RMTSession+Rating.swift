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
        if let allSessions = RMTSession.MR_findAll() as? [RMTSession] {
            for session in allSessions {
                session.saveMyRatings()
            }
        }
    }

    func totalRating() -> Float {
        var totalRating: Float = 0.0
        let allRatingCategories = self.ratingCategories
        let allRatingCategoriesCount = allRatingCategories.count
        if allRatingCategoriesCount == 0 {
            return totalRating
        }

        for index in 0...allRatingCategoriesCount - 1 {
            let ratingCategory = allRatingCategories.objectAtIndex(index) as RMTRatingCategory
            let ratingCategoryTotalStars = ratingCategory.totalRating()
            totalRating += ratingCategoryTotalStars
        }

        totalRating = totalRating / Float(allRatingCategoriesCount)
        totalRating = totalRating.roundStars()
        return totalRating
    }

}
