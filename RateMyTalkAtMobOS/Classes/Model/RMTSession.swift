@objc(RMTSession)
class RMTSession: _RMTSession {

    class func insertInContext(context: NSManagedObjectContext) -> RMTSession {
        let session = RMTSession(managedObjectContext: context)
        session.uuid = NSUUID().UUIDString
        session.createdAt = NSDate()
        session.updatedAt = NSDate()
        return session
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
        var countValidRatedCategories: Float = 0.0
        
        if allRatingCategoriesCount == 0 {
            self.generalRating = NSNumber(float: 0.0)
            return
        }
        
        for index in 0..<allRatingCategoriesCount {
            let ratingCategory = allRatingCategories.objectAtIndex(index) as RMTRatingCategory
            let ratingCategoryTotalStars = ratingCategory.totalRating()
            if ratingCategoryTotalStars > 0.0 {
                totalRating += ratingCategoryTotalStars
                countValidRatedCategories += 1.0
            }
        }
        
        if (countValidRatedCategories > 0.0) {
            totalRating = totalRating / countValidRatedCategories
            totalRating = totalRating.roundStars()
        }
        self.generalRating = NSNumber(float: totalRating)
    }

}
