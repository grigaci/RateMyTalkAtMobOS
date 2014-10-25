//
//  RMTSpeaker+Color.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/19/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import UIKit

let gSpeakerColors = [
    UIColor(fullRed: 85.0,  fullGreen: 186.0, fullBlue: 239.0),
    UIColor(fullRed: 99.0,  fullGreen: 218.0, fullBlue: 185.0),
    UIColor(fullRed: 240.0, fullGreen: 130.0, fullBlue: 139.0),
    UIColor(fullRed: 159.0, fullGreen: 96.0,  fullBlue: 186.0),
    UIColor(fullRed: 71.0,  fullGreen: 160.0, fullBlue: 134.0),
    UIColor(fullRed: 88.0,  fullGreen: 132.0, fullBlue: 190.0)]

let gSpeakerDefaultColor = UIColor.purpleColor()

extension RMTSpeaker {
    func color() -> UIColor {
        let moc = NSManagedObjectContext.MR_defaultContext()
        let allSpeakers = RMTSpeaker.MR_findAllSortedBy(RMTSpeakerAttributes.name.rawValue, ascending: true, inContext: moc)
        var speakerIndex = NSNotFound
        for (index, speakerObj) in enumerate(allSpeakers) {
            let speaker = speakerObj as RMTSpeaker
            if speaker.name == self.name {
                speakerIndex = index
                break
            }
        }
        if speakerIndex == NSNotFound {
            return gSpeakerDefaultColor
        } else {
            return gSpeakerColors[speakerIndex] as UIColor
        }
    }
}
