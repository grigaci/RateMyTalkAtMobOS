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

    func start() {
        if isFirstRun() {
            loadFromPlist()
        }

        NSUserDefaults.standardUserDefaults().iCloudDataDownloaded = true
        printAllSessions()
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
        var session: RMTSession = RMTSession(entity: RMTSession.entity(moc), insertIntoManagedObjectContext: moc)
    
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
            speaker = RMTSpeaker(entity: RMTSpeaker.entity(moc), insertIntoManagedObjectContext: moc)
            speaker!.name = speakerName
        }
        session.speaker = speaker
    }

    private func createRatingCategory(session: RMTSession, dictionary: NSDictionary) {
        let moc: NSManagedObjectContext = NSManagedObjectContext.MR_defaultContext()
        var ratingCategory: RMTRatingCategory = RMTRatingCategory(entity: RMTRatingCategory.entity(moc), insertIntoManagedObjectContext: moc)

        ratingCategory.title = dictionary.objectForKey("title") as NSString
        session.addRatingCategoriesObject(ratingCategory)
    }

    private func printAllSessions() {
        var allSessions: NSArray = RMTSession.MR_findAll()
        for sessionObj in allSessions {
            let session: RMTSession = sessionObj as RMTSession
            println("=====================\(session.title?)=====================")
            println("start date: \(session.startDate)")
            println("end date: \(session.endDate)")
            printSpeaker(session.speaker)
            let allRatingCategories:NSOrderedSet = session.ratingCategories
            let count = allRatingCategories.count - 1
            if count > 0 {
                for i in 0...count {
                    let ratingCategory: RMTRatingCategory = allRatingCategories.objectAtIndex(i) as RMTRatingCategory
                    printRatingCategory(ratingCategory)
                }
            }
            println("==========================================")
        }
    }

    private func printSpeaker(speaker: RMTSpeaker?) {
        if let name = speaker?.name {
            println("speaker: \(name)")
        }
    }
    
    private func printRatingCategory(ratingCategory: RMTRatingCategory?) {
        if let title = ratingCategory?.title {
            println("\t title: \(title)")
        }
        let allRatings = ratingCategory?.ratings
        let allRatingsCount = allRatings?.count
        if allRatingsCount == 0 {
            return
        }
        
        for index in 0...allRatingsCount! - 1 {
            let rating = allRatings?.objectAtIndex(index) as RMTRating!
            self.printRating(rating)
        }
    }

    private func printRating(rating: RMTRating?) {
        println("\t\t stars: \(rating!.stars!.doubleValue)")
    }
}
