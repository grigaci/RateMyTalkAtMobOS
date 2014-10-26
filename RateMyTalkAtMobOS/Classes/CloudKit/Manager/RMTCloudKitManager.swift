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

    func downloadAll(finishedCallback: (error: NSError?) -> Void) {

        let reachability = Reachability.reachabilityForInternetConnection()
        if !reachability.isReachable() {
            finishedCallback(error: NSError.internetConnectionError())
            return
        }
    
        if NSUserDefaults.standardUserDefaults().iCloudDataDownloaded {
            finishedCallback(error: nil)
            return
        }

        let allTypes = [RMTSpeaker.ckRecordName, RMTSession.ckRecordName, RMTRatingCategory.ckRecordName, RMTRating.ckRecordName]
        downloadRecursive(allTypes, currentIndex: 0) { (error: NSError?) -> Void in
            RMTSession.calculateAllGeneralRatings()
            let moc = NSManagedObjectContext.MR_defaultContext()
            moc.MR_saveToPersistentStoreAndWait()
            self.downloadAllNotifyCallback(finishedCallback, error: error)
        }
    }

    private func downloadAllNotifyCallback(finishedCallback: (error: NSError?) -> Void, error: NSError?) {
        NSUserDefaults.standardUserDefaults().iCloudDataDownloaded = error == nil

        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            finishedCallback(error: error)
        })
    }

    func downloadRecursive(allTypes: [NSString], currentIndex: Int, finishedCallback: (error: NSError?) -> Void) {
        if currentIndex == allTypes.count {
            finishedCallback(error: nil)
            return
        }

        let currentType = allTypes[currentIndex] as NSString
        downloadRecordType(currentType, finishedCallback: { (error: NSError?) -> Void in
            if error != nil {
                finishedCallback(error: error)
            } else {
                let moc = NSManagedObjectContext.MR_defaultContext()
                moc.MR_saveToPersistentStoreAndWait()
                self.downloadRecursive(allTypes, currentIndex: currentIndex + 1, finishedCallback: finishedCallback)
            }
        })
    }

    func downloadRecordType(type: NSString, finishedCallback: (error: NSError?) -> Void) {
        let downloadOperation = RMTCloudKitOperationDownloadAll.downloadAll(type)

        downloadOperation.queryCompletionBlock = { (cursor : CKQueryCursor!, error : NSError!) in
            println("Download all for \(type) with error \(error)")
            var appError: NSError?
            if error != nil {
                appError = NSError.cloudKitConnectionError()
            }
            finishedCallback(error: appError)
        }

        publicDB.addOperation(downloadOperation)
    }

    func syncRatings(finishedCallback: (error: NSError?) -> Void) {
        let reachability = Reachability.reachabilityForInternetConnection()
        if !reachability.isReachable() {
            finishedCallback(error: NSError.internetConnectionError())
            return
        }

        RMTRating.deleteAllExceptMyRatings { () -> Void in
            self.uploadAllMyRatings { (errorUpload: NSError?) -> Void in
                if errorUpload != nil {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        finishedCallback(error: errorUpload)
                    })
                } else {
                    self.downloadAllRatings { (errorDownload: NSError?) -> Void in
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            finishedCallback(error: errorDownload)
                        })
                    }
                }
            }
        }
    }

    func downloadAllRatings(finishedCallback: (error: NSError?) -> Void) {
        
        let allTypes = [RMTRating.ckRecordName]
        downloadRecursive(allTypes, currentIndex: 0) { (error: NSError?) -> Void in
            if error == nil {
                RMTSession.calculateAllGeneralRatings()
                let moc = NSManagedObjectContext.MR_defaultContext()
                moc.MR_saveToPersistentStoreAndWait()
            }
            finishedCallback(error: error)
        }
    }

    func uploadAllMyRatings(finishedCallback: (error: NSError?) -> Void) {
        
        let uploadOperation = RMTCloudKitOperationUploadRatings.uploadAllMyRatings()
        
        uploadOperation.modifyRecordsCompletionBlock = { (saved: [AnyObject]!, deleted: [AnyObject]!, error: NSError!) in
            println ("Upload all my ratings complited with error \(error)")
            var appError: NSError?
            if error != nil {
                appError = NSError.cloudKitConnectionError()
            }
            finishedCallback(error: appError)
        }

        self.publicDB.addOperation(uploadOperation)
    }

}
