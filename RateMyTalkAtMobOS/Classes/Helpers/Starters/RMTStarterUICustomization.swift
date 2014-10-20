//
//  RMTStarterUICustomization.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/20/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import UIKit

@objc(RMTStarterUICustomization)
class RMTStarterUICustomization: NSObject, RMTStarterItem {
    
    func start() {
        let font = UIFont.fontAllerRegular(20.0)
        let textAttributes = [NSFontAttributeName : font]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
    }
}
