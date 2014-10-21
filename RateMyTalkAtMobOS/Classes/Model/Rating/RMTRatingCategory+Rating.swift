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
}
