//
//  NSAttributedString+Session.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/19/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

extension NSAttributedString {
    class func ratingCategoryAttributedString(string: String) -> NSAttributedString {
        let font = UIFont.fontLatoRegular(16.0)
        let color = UIColor(fullRed: 94.0, fullGreen: 94.0, fullBlue: 94.0)
        let dictionary = [NSForegroundColorAttributeName : color, NSFontAttributeName : font]
        let attributedString = NSAttributedString(string: string, attributes: dictionary)
        return attributedString
    }
}
