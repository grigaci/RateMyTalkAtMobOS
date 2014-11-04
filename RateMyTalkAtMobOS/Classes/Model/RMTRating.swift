@objc(RMTRating)
class RMTRating: _RMTRating {

    class func insertInContext(context: NSManagedObjectContext) -> RMTRating {
        let rating = RMTRating(managedObjectContext: context)
        rating.uuid = NSUUID().UUIDString
        rating.createdAt = NSDate()
        rating.updatedAt = NSDate()
        
        let userUUID = NSUserDefaults.standardUserDefaults().userUUID
        rating.userUUID = userUUID
        rating.createCKRecordIDIfNeeded()

        return rating
    }

    class func deleteAllExceptMyRatings(finishedCallback: () -> Void) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            let userUUID = NSUserDefaults.standardUserDefaults().userUUID
            let moc: NSManagedObjectContext = NSManagedObjectContext.MR_contextForCurrentThread()
            let predicate = NSPredicate(format: "%K != %@", RMTRatingAttributes.userUUID.rawValue, userUUID)
            var objectsToDelete: [RMTRating] = RMTRating.MR_findAllWithPredicate(predicate, inContext: moc) as [RMTRating]
            for rating in objectsToDelete {
                rating.ratingCategory?.removeRatingsObject(rating)
                moc.deleteObject(rating)
            }
            
            moc.MR_saveToPersistentStoreWithCompletion({ (saved, error) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    finishedCallback()
                })
            })
        })
    }

    class func createUserRatingsIfNeeded() {
        let context = NSManagedObjectContext.MR_defaultContext()
        let allRatingCategories = RMTRatingCategory.MR_findAllInContext(context) as [RMTRatingCategory]
        for ratingCategory in allRatingCategories {
            ratingCategory.createMyRatingIfNeeded()
        }
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
        if self.temporaryRating.isRatingValid() {
            let savedStars = self.stars
            let currentStars = NSNumber(float: self.temporaryRating)
            if savedStars?.compare(currentStars) != NSComparisonResult.OrderedSame {
                self.stars = NSNumber(float: self.temporaryRating)
                self.managedObjectContext?.MR_saveOnlySelfAndWait()
            }
        }
    }
    
}
