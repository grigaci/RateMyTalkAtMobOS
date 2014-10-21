@objc(RMTRatingCategory)
class RMTRatingCategory: _RMTRatingCategory {
    
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
        moc.MR_saveOnlySelfAndWait()
        return rating
    }

    func saveMyRating() {
        let myRating = self.createMyRatingIfNeeded()
        if let stars = self.myLocalRating?.floatValue {
            myRating.stars = NSNumber(float: stars)
            NSManagedObjectContext.MR_defaultContext().MR_saveOnlySelfAndWait()
        } else {
            println("Category \(self.title!) not rated")
        }
    }
}
