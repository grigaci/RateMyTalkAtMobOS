//
//  UIFont+Aller.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/19/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import UIKit

enum UIFontAllerLight: String {
    case Regular = "Aller-Light"
    case LightItalic = "Aller-LightItalic"
}

enum UIFontAller: String {
    case Regular = "Aller"
    case Italic = "Aller-Italic"
    case Bold = "Aller-Bold"
    case BoldItalic = "Aller-BoldItalic"
}

extension UIFont {

    class func fontAllerLightRegular(size: Float) -> UIFont {
        return UIFont(name: UIFontAllerLight.Regular.toRaw(), size: CGFloat(size))
    }
    
    class func fontAllerLightItalic(size: Float) -> UIFont {
        return UIFont(name: UIFontAllerLight.LightItalic.toRaw(), size: CGFloat(size))
    }
    
    class func fontAllerRegular(size: Float) -> UIFont {
        return UIFont(name: UIFontAller.Regular.toRaw(), size: CGFloat(size))
    }

    class func fontAllerItalic(size: Float) -> UIFont {
        return UIFont(name: UIFontAller.Italic.toRaw(), size: CGFloat(size))
    }

    class func fontAllerBold(size: Float) -> UIFont {
        return UIFont(name: UIFontAller.Bold.toRaw(), size: CGFloat(size))
    }

    class func fontAllerBoldItalic(size: Float) -> UIFont {
        return UIFont(name: UIFontAller.BoldItalic.toRaw(), size: CGFloat(size))
    }
}
