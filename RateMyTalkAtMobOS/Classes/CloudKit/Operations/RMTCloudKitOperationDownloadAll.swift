//
//  RMTCloudKitOperationDownloadAll.swift
//  RateMyTalkAtMobOSMaster
//
//  Created by Bogdan Iusco on 10/4/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import Foundation
import CloudKit

class RMTCloudKitOperationDownloadAll: CKQueryOperation {

    let recordType: NSString!

    init(query: CKQuery, type: NSString) {
        super.init()
        self.query = query
        self.recordType = type
        recordFetchedBlock = { (record : CKRecord!) in
            self.handleRecord(record)
        }
    }

    class func downloadAll(recordType: NSString) -> RMTCloudKitOperationDownloadAll {
        let query = CKQuery(recordType: recordType, predicate: NSPredicate(value: true))
        let operation = RMTCloudKitOperationDownloadAll(query: query, type: recordType);
        return operation;
    }
 
    private func handleRecord(record: CKRecord) {
        switch self.recordType {
        case RMTSpeaker.ckRecordName:
            handleRecordSpeaker(record)
        case RMTSession.ckRecordName:
            handleRecordSession(record)
        case RMTRatingCategory.ckRecordName:
            handleRecordRatingCategory(record)
        case RMTRating.ckRecordName:
            handleRecordRating(record)
        default:
            RMTLogError("default switch case", function: __FUNCTION__, line: __LINE__)
        }
    }

    private func handleRecordSpeaker(record: CKRecord) {
        let existingSpeaker: RMTSpeaker? = RMTSpeaker.speakerWithRecordID(record.recordID.recordName)
        if existingSpeaker == nil {
            RMTSpeaker.create(record)
        }
    }
    
    private func handleRecordSession(record: CKRecord) {
        let existingSession: RMTSession? = RMTSession.sessionWithRecordID(record.recordID.recordName)
        if existingSession == nil {
            RMTSession.create(record)
        }
    }
    
    private func handleRecordRatingCategory(record: CKRecord) {
        let existingRatingCategory: RMTRatingCategory? = RMTRatingCategory.ratingCategoryWithRecordID(record.recordID.recordName)
        if existingRatingCategory == nil {
            RMTRatingCategory.create(record)
        }
    }

    private func handleRecordRating(record: CKRecord) {
        let existingRating: RMTRating? = RMTRating.ratingWithRecordID(record.recordID.recordName)
        if existingRating == nil {
            RMTRating.create(record)
        }
    }

}
