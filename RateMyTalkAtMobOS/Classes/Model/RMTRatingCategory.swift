@objc(RMTRatingCategory)
class RMTRatingCategory: _RMTRatingCategory {

    func myRating() -> RMTRating? {
        let userUUID = NSUserDefaults.standardUserDefaults().userUUID
        let moc: NSManagedObjectContext = NSManagedObjectContext.MR_defaultContext()
        let predicate = NSPredicate(format: "%K == %@ AND %K == %@", RMTRatingRelationships.ratingCategory.toRaw(), self,
                                    RMTRatingAttributes.userUUID.toRaw(), userUUID)
        var existingObject: RMTRating? = RMTRating.MR_findFirstWithPredicate(predicate, inContext: moc) as? RMTRating
        return existingObject
    }

}
