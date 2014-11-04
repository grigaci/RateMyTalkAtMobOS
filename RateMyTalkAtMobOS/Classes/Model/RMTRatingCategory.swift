@objc(RMTRatingCategory)
class RMTRatingCategory: _RMTRatingCategory {

    class func insertInContext(context: NSManagedObjectContext) -> RMTRatingCategory {
        let ratingCategory = RMTRatingCategory(managedObjectContext: context)
        ratingCategory.uuid = NSUUID().UUIDString
        ratingCategory.createdAt = NSDate()
        ratingCategory.updatedAt = NSDate()
        return ratingCategory
    }

    func totalRating() -> Float {
        var totalRating: Float = 0.0
        let allRatings = self.ratings
        let allRatingsCount = allRatings.count
        var countValidRatings: Float = 0.0
        if allRatingsCount == 0 {
            return totalRating
        }

        for index in 0..<allRatingsCount {
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
        var rating: RMTRating = RMTRating.insertInContext(moc)

        rating.ratingCategory = self
        self.addRatingsObject(rating)

        moc.MR_saveOnlySelfAndWait()
        return rating
    }
}
