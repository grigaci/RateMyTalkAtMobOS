@objc(RMTRating)
class RMTRating: _RMTRating {

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
}
