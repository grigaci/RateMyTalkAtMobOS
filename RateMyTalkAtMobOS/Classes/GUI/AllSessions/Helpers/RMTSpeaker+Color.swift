//
//  RMTSpeaker+Color.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/19/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import UIKit

let gSpeakerColors = [UIColor(fullRed: 199.0, fullGreen: 121.0, fullBlue: 176.0),
UIColor(fullRed: 128.0, fullGreen: 171.0, fullBlue: 178.0),
UIColor(fullRed: 94.0, fullGreen: 162.0, fullBlue: 220.0),
UIColor(fullRed: 220.0, fullGreen: 122.0, fullBlue: 122.0),
UIColor.magentaColor(),
UIColor.greenColor()]

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
