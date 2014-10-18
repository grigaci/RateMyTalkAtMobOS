//
//  RMTWindowBase.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/13/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import UIKit

class RMTWindowBase: UIWindow {
    var lastWindow: UIWindow?

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewController: UIViewController) {
        super.init(frame: UIScreen.mainScreen().bounds)
        self.rootViewController = viewController
        self.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
    }

    func show() {
        self.lastWindow = UIApplication.sharedApplication().keyWindow
        self.windowLevel = self.lastWindow!.windowLevel + 1.0
        self.makeKeyAndVisible()
        
        RMTWindowBase.registerWindow(self)
    }
    
    func hide() {
        self.windowLevel = self.lastWindow!.windowLevel - 1.0
        self.lastWindow?.makeKeyAndVisible()
        RMTWindowBase.unregisterWindow(self)
    }

     class var aliveWindows: NSMutableArray {
     struct Static {
        static var onceToken : dispatch_once_t = 0
        static var array : NSMutableArray? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.array = NSMutableArray()
        }
        return Static.array!
    }

    class func registerWindow(window: UIWindow) {
        RMTWindowBase.aliveWindows.addObject(window)
    }

    class func unregisterWindow(window: UIWindow) {
        RMTWindowBase.aliveWindows.removeObject(window)
    }
}
