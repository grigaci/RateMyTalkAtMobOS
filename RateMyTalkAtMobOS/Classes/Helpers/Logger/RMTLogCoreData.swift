//
//  RMTLogCoreData.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/5/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import Foundation

class RMTLogCoreData {
    class func printAllSessions() {
        var allSessions: NSArray = RMTSession.MR_findAll()
        for sessionObj in allSessions {
            let session: RMTSession = sessionObj as RMTSession
            println("=====================\(session.title?)=====================")
            printSpeaker(session.speaker)
            let allRatingCategories:NSOrderedSet = session.ratingCategories
            let count = allRatingCategories.count - 1
            if count > 0 {
                for i in 0...count {
                    let ratingCategory: RMTRatingCategory = allRatingCategories.objectAtIndex(i) as RMTRatingCategory
                    println("--")
                    printRatingCategory(ratingCategory)
                    println("--")
                }
            }
            println("==========================================")
        }
    }
    
    class func printSpeaker(speaker: RMTSpeaker?) {
        println("speaker: \(speaker?.name)")
        println("recordID: \(speaker?.ckRecordID)")
    }

    class func printRatingCategory(ratingCategory: RMTRatingCategory?) {
        println("title: \(ratingCategory?.title)")
        println("ID: \(ratingCategory?.ratingCategoryID)")
    }

    class func printAllSpeakers() {
        var allSpeakers: NSArray = RMTSpeaker.MR_findAll()
        for sessionObj in allSpeakers {
            let speaker: RMTSpeaker = sessionObj as RMTSpeaker
            printSpeaker(speaker)
        }
    }
}