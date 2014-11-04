//
//  RMTCloudKitOperationUploadRatings.swift
//  RateMyTalkAtMobOSMaster
//
//  Created by Bogdan Iusco on 10/11/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import Foundation
import CloudKit

class RMTCloudKitOperationUploadRatings: CKModifyRecordsOperation {
    
    class func uploadAllMyRatings() -> RMTCloudKitOperationUploadRatings {
        
        let allMyRatings = RMTCloudKitOperationUploadRatings.allMyRatings()
        var allMyRatingsCK = [CKRecord]()
        
        for rating in allMyRatings {
            if let ratingCK = rating.ckRecord() {
                allMyRatingsCK += [ratingCK]
            }
        }

        let uploadOperation = RMTCloudKitOperationUploadRatings(recordsToSave: allMyRatingsCK, recordIDsToDelete: nil);
        uploadOperation.savePolicy = .AllKeys
        return uploadOperation;
    }

    class func allMyRatings() -> [RMTRating] {
        let userUUID = NSUserDefaults.standardUserDefaults().userUUID
        let moc: NSManagedObjectContext = NSManagedObjectContext.MR_defaultContext()
        let predicate = NSPredicate(format: "%K == %@", RMTRatingAttributes.userUUID.rawValue, userUUID)
        let allMyRatingsNSArray: [RMTRating] = RMTRating.MR_findAllWithPredicate(predicate, inContext: moc)  as [RMTRating]
        return allMyRatingsNSArray
    }
}
