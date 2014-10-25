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

enum UIFontLato: String {
    case Regular = "Lato-Regular"
    case Black = "Lato-Black"
    case BlackItalic = "Lato-BlackItalic"
    case Bold = "Lato-Bold"
    case BoldItalic = "Lato-BoldItalic"
    case Hairline = "Lato-Hairline"
    case HairlineItalic = "Lato-HairlineItalic"
    case Italic = "Lato-Italic"
    case Light = "Lato-Light"
    case LightItalic = "Lato-LightItalic"
}

extension UIFont {

    class func printAll() {
        let familyNames = UIFont.familyNames()
        for familyName in familyNames {
            let fontNames = UIFont.fontNamesForFamilyName(familyName as String)
            for fontName in fontNames {
                println("\(fontName)")
            }
        }
    }

    class func fontAllerLightRegular(size: Float) -> UIFont {
        return UIFont(name: UIFontAllerLight.Regular.rawValue, size: CGFloat(size))!
    }
    
    class func fontAllerLightItalic(size: Float) -> UIFont {
        return UIFont(name: UIFontAllerLight.LightItalic.rawValue, size: CGFloat(size))!
    }
    
    class func fontAllerRegular(size: Float) -> UIFont {
        return UIFont(name: UIFontAller.Regular.rawValue, size: CGFloat(size))!
    }

    class func fontAllerItalic(size: Float) -> UIFont {
        return UIFont(name: UIFontAller.Italic.rawValue, size: CGFloat(size))!
    }

    class func fontAllerBold(size: Float) -> UIFont {
        return UIFont(name: UIFontAller.Bold.rawValue, size: CGFloat(size))!
    }

    class func fontAllerBoldItalic(size: Float) -> UIFont {
        return UIFont(name: UIFontAller.BoldItalic.rawValue, size: CGFloat(size))!
    }
    
    class func fontLatoRegular(size: Float) -> UIFont {
        return UIFont(name: UIFontLato.Regular.rawValue, size: CGFloat(size))!
    }

    class func fontLatoBlack(size: Float) -> UIFont {
        return UIFont(name: UIFontLato.Black.rawValue, size: CGFloat(size))!
    }
    
    class func fontLatoBlackItalic(size: Float) -> UIFont {
        return UIFont(name: UIFontLato.BlackItalic.rawValue, size: CGFloat(size))!
    }
    
    class func fontLatoBold(size: Float) -> UIFont {
        return UIFont(name: UIFontLato.Bold.rawValue, size: CGFloat(size))!
    }
    
    class func fontLatoBoldItalic(size: Float) -> UIFont {
        return UIFont(name: UIFontLato.BoldItalic.rawValue, size: CGFloat(size))!
    }

    class func fontLatoHairline(size: Float) -> UIFont {
        return UIFont(name: UIFontLato.Hairline.rawValue, size: CGFloat(size))!
    }
    
    class func fontLatoHairlineItalic(size: Float) -> UIFont {
        return UIFont(name: UIFontLato.HairlineItalic.rawValue, size: CGFloat(size))!
    }

    class func fontLatoItalic(size: Float) -> UIFont {
        return UIFont(name: UIFontLato.Italic.rawValue, size: CGFloat(size))!
    }

    class func fontLatoLight(size: Float) -> UIFont {
        return UIFont(name: UIFontLato.Light.rawValue, size: CGFloat(size))!
    }

    class func fontLatoLightItalic(size: Float) -> UIFont {
        return UIFont(name: UIFontLato.LightItalic.rawValue, size: CGFloat(size))!
    }

}
