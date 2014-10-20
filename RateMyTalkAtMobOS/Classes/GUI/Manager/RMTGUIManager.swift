//
//  RMTGUIManager.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/5/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import UIKit

class RMTGUIManager {
    
    class var sharedInstance : RMTGUIManager {
    struct Static {
        static var onceToken : dispatch_once_t = 0
        static var instance : RMTGUIManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = RMTGUIManager()
        }
        return Static.instance!
    }

    lazy var navigationController: UINavigationController = {
       let rootViewController = RMTAllSessionsViewController(nibName: nil, bundle: nil)
       let temp = UINavigationController(rootViewController: rootViewController)
       return temp
    }()

    var window: UIWindow? {
        didSet {
            window?.rootViewController = navigationController
            window?.tintColor = UIColor.blackColor()
        }
    }

    init () {
        self.window = nil
    }
}
