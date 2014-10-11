//
//  RMTCloudKitManager.swift
//  RateMyTalkAtMobOSMaster
//
//  Created by Bogdan Iusco on 10/4/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import Foundation
import CloudKit

class RMTCloudKitManager {
    
    // Our own custom container
    private let publicDB = CKContainer(identifier: "iCloud.RateMyTalkAtMobOS").publicCloudDatabase

    class var sharedInstance : RMTCloudKitManager {
    struct Static {
        static var onceToken : dispatch_once_t = 0
        static var instance : RMTCloudKitManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = RMTCloudKitManager()
        }
        return Static.instance!
    }

    func downloadAll(finishedCallback: () -> Void) {
        
        let allTypes = [RMTSpeaker.ckRecordName, RMTSession.ckRecordName, RMTRatingCategory.ckRecordName, RMTRating.ckRecordName]
        downloadRecursive(allTypes, currentIndex: 0) { () -> Void in
            let moc = NSManagedObjectContext.MR_defaultContext()
            moc.MR_saveToPersistentStoreAndWait()

            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                finishedCallback()
            })
        }
    }

    func downloadRecursive(allTypes: [NSString], currentIndex: Int, finishedCallback: () -> Void) {
        if currentIndex == allTypes.count {
            finishedCallback()
            return
        }

        let currentType = allTypes[currentIndex] as NSString
        downloadRecordType(currentType, finishedCallback: { (successul : Bool) -> Void in
            self.downloadRecursive(allTypes, currentIndex: currentIndex + 1, finishedCallback: finishedCallback)
        })
    }

    func downloadRecordType(type: NSString, finishedCallback: (Bool) -> Void) {
        let downloadOperation = RMTCloudKitOperationDownloadAll.downloadAll(type)

        downloadOperation.queryCompletionBlock = { (cursor : CKQueryCursor!, error : NSError!) in
            println("Download all for \(type) with error \(error)")
            finishedCallback((error != nil))
        }

        publicDB.addOperation(downloadOperation)
    }

}
