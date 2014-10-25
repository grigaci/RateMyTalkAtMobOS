//
//  UIColor+Extra.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/18/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func appBackgroundColor() -> UIColor {
        return UIColor(fullRed: 247.0, fullGreen: 247.0, fullBlue: 247.0)
    }

    class func allSessionsBackgroungColor() -> UIColor {
        let image = UIImage(named: "allSessionsBackgroundPattern")
        return UIColor(patternImage: image!)
    }

    class func sessionBackgroungColor() -> UIColor {
        let image = UIImage(named: "sessionBackgroundPattern")
        return UIColor(patternImage: image!)
    }

    convenience init(fullRed: Float, fullGreen: Float, fullBlue: Float) {
        let divider: CGFloat = 255.0
        let red : CGFloat = CGFloat(fullRed) / divider
        let green : CGFloat = CGFloat(fullGreen) / divider
        let blue : CGFloat = CGFloat(fullBlue) / divider
        self.init(red: red, green: green, blue: blue, alpha: CGFloat(1.0))
    }
}
