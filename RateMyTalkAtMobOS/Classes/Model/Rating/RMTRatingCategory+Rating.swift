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
        if allRatingsCount == 0 {
            return totalRating
        }

        for index in 0...allRatingsCount - 1 {
            let rating = allRatings.objectAtIndex(index) as RMTRating
            if let starsNumber = rating.stars {
                totalRating += starsNumber.floatValue
            }
        }

        totalRating = totalRating / Float(allRatingsCount)
        totalRating = totalRating.roundStars()
        return totalRating
    }
}
