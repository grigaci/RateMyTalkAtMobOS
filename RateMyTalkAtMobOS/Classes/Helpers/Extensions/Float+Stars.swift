//
//  Float+Stars.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/11/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import Foundation

let kRatingStarsMin: Float = 0
let kRatingStarsMax: Float = 4

extension Float {
    func roundStars() -> Float {
        var temp = round(2.0 * self)
        temp = temp / 2.0
        return temp
    }
    
    func isRatingValid() -> Bool {
        let greater: NSComparisonResult = NSNumber(float: self).compare(NSNumber(float: kRatingStarsMin))
        let lessOrEqual: NSComparisonResult = NSNumber(float: self).compare(NSNumber(float: kRatingStarsMax))

        return greater == .OrderedDescending && lessOrEqual != .OrderedDescending
    }

}
