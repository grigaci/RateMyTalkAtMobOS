//
//  Float+Stars.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/11/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import Foundation

extension Float {
    func roundStars() -> Float {
        var temp = round(2.0 * self)
        temp = temp / 2.0
        return temp
    }
}
