//
//  RMTStarterDataImporter.swift
//  RateMyTalkAtMobOSMaster
//
//  Created by Bogdan Iusco on 10/3/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import CoreData

@objc(RMTStarterDataImporter)
class RMTStarterDataImporter: NSObject, RMTStarterItem {

    private var ratingCategoryIDCounter: Int = 0
    func start() {
        if isFirstRun() {
            self.loadFromPlist()

            // Create empty user ratings
            RMTRating.createUserRatingsIfNeeded()
        }
    }

    private func isFirstRun() -> Bool {
        let allSessions: NSArray = RMTSession.MR_findAll()
        return allSessions.count == 0
    }

    private func loadFromPlist() {
        let filePath = NSBundle.mainBundle().pathForResource("DefaultData", ofType: "plist")
        let allSesstions = NSArray(contentsOfFile:filePath!)!
        for sessionObj in allSesstions {
            let sessionDictionary: NSDictionary = sessionObj as NSDictionary
            createSession(sessionDictionary)
        }
    }

    private func createSession(dictionary: NSDictionary) {
        let moc: NSManagedObjectContext = NSManagedObjectContext.MR_defaultContext()
        var session: RMTSession = RMTSession.insertInContext(moc)
    
        // Set title
        session.title = dictionary.objectForKey("title") as NSString
    
        // Set start and end dates
        session.startDate = dictionary.objectForKey("startDate") as? NSDate
        session.endDate = dictionary.objectForKey("endDate") as? NSDate

        // Set speaker
        let speakerObj: AnyObject? = dictionary.objectForKey("speaker")
        if speakerObj != nil {
            let speakerDict = speakerObj as NSDictionary
            self.createSpeaker(session, dictionary: speakerDict)
        }

        // Set rating categories
        let ratingCategoriesObj: AnyObject? = dictionary.objectForKey("ratingCategories")
        if ratingCategoriesObj != nil {
            let ratingCategories: NSArray = ratingCategoriesObj as NSArray
            for ratingCategoryObj in ratingCategories {
                let ratingCategoryDictionary = ratingCategoryObj as NSDictionary
                self.createRatingCategory(session, dictionary: ratingCategoryDictionary)
            }
        }

        // Save it!
        moc.MR_saveOnlySelfAndWait()
    }

    private func createSpeaker(session: RMTSession, dictionary: NSDictionary) {
        let moc: NSManagedObjectContext = NSManagedObjectContext.MR_defaultContext()
        let speakerName = dictionary.objectForKey("name") as NSString
        var speaker = RMTSpeaker.MR_findFirstByAttribute(RMTSpeakerAttributes.name.rawValue, withValue: speakerName) as? RMTSpeaker
        if speaker == nil {
            speaker = RMTSpeaker.insertInContext(moc)
            speaker!.name = speakerName
        }
        session.speaker = speaker
    }

    private func createRatingCategory(session: RMTSession, dictionary: NSDictionary) {
        let moc: NSManagedObjectContext = NSManagedObjectContext.MR_defaultContext()
        var ratingCategory: RMTRatingCategory = RMTRatingCategory.insertInContext(moc)

        ratingCategory.title = dictionary.objectForKey("title") as NSString

        // In order to ahve the same ID across all devices
        ratingCategory.ratingCategoryID = NSNumber(integer: self.ratingCategoryIDCounter)
        self.ratingCategoryIDCounter += 1

        session.addRatingCategoriesObject(ratingCategory)
    }

}
