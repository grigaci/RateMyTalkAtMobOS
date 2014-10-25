//
//  NSAttributedString+AllSessions.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/18/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import Foundation

extension NSAttributedString {
    class func topicAttributedString(string: String) -> NSAttributedString {
        let font = UIFont.fontLatoItalic(14.0)
        let color = UIColor(fullRed: 94.0, fullGreen: 94.0, fullBlue: 94.0)
        let dictionary = [NSForegroundColorAttributeName : color, NSFontAttributeName : font]
        let newString: String = "\"\(string)\""
        let attributedString = NSAttributedString(string: newString, attributes: dictionary)
        return attributedString
    }
    
    class func speakerNameAttributedString(string: String) -> NSAttributedString {
        let font = UIFont.fontLatoBold(19.0)
        let color = UIColor(fullRed: 67.0, fullGreen: 67.0, fullBlue: 67.0)
        let dictionary = [NSForegroundColorAttributeName : color, NSFontAttributeName : font]
        let attributedString = NSAttributedString(string: string, attributes: dictionary)
        return attributedString
    }
    
    class func infoAttributedString(string: String) -> NSAttributedString {
        let font = UIFont.fontLatoRegular(12.0)
        let color = UIColor(fullRed: 158.0, fullGreen: 158.0, fullBlue: 158.0)
        let dictionary = [NSForegroundColorAttributeName : color, NSFontAttributeName : font]
        let attributedString = NSAttributedString(string: string, attributes: dictionary)
        return attributedString
    }

    class func averageRatingAttributedString(string: String) -> NSAttributedString {
        let font = UIFont.fontLatoRegular(11.0)
        let color = UIColor(fullRed: 158.0, fullGreen: 158.0, fullBlue: 158.0)
        let dictionary = [NSForegroundColorAttributeName : color, NSFontAttributeName : font]
        let attributedString = NSAttributedString(string: string, attributes: dictionary)
        return attributedString
    }

    class func syncTextAttributedString(string: String) -> NSAttributedString {
        let font = UIFont.fontLatoRegular(12.0)
        let color = UIColor(fullRed: 158.0, fullGreen: 158.0, fullBlue: 158.0)
        let dictionary = [NSForegroundColorAttributeName : color, NSFontAttributeName : font]
        let attributedString = NSAttributedString(string: string, attributes: dictionary)
        return attributedString
    }

    class func noConnectionAttributedString() -> NSAttributedString {
        let title = NSAttributedString.noConnectionTitleAttributedString()
        let detail = NSAttributedString.noConnectionDetailAttributedString()
        let mutableText = NSMutableAttributedString(attributedString: title)
        mutableText.appendAttributedString(detail)
        return NSAttributedString(attributedString: mutableText)
    }

    class func noConnectionTitleAttributedString() -> NSAttributedString {
        let string = "Cannot connect to iCloud\n\n"
        let font = UIFont.fontLatoBold(18.0)
        let color = UIColor(fullRed: 67.0, fullGreen: 67.0, fullBlue: 67.0)
        let dictionary = [NSForegroundColorAttributeName : color, NSFontAttributeName : font]
        let attributedString = NSAttributedString(string: string, attributes: dictionary)
        return attributedString
    }

    class func noConnectionDetailAttributedString() -> NSAttributedString {
        let string = "Please make sure that you have internet access and that you signed into your iCloud account."
        let font = UIFont.fontLatoRegular(14.0)
        let color = UIColor(fullRed: 67.0, fullGreen: 67.0, fullBlue: 67.0)
        let dictionary = [NSForegroundColorAttributeName : color, NSFontAttributeName : font]
        let attributedString = NSAttributedString(string: string, attributes: dictionary)
        return attributedString
    }

}
