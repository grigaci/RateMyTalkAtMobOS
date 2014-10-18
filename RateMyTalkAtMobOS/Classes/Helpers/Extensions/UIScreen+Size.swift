//
//  UIScreen+Size.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/18/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import Foundation

extension UIScreen {
    var fixedScreenSize: CGSize {
        get {
            let screenSize = UIScreen.mainScreen().bounds
            let screenHeight = max(screenSize.width, screenSize.height)
            let screenWidth = min(screenSize.width, screenSize.height)
            return CGSizeMake(screenWidth, screenHeight)
        }
    }
}
