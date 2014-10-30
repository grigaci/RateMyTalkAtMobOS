//
//  RMTAppDelegate.swift
//  RateMyTalkAtMobOS
//
//  Created by bogdan on 02/10/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class RMTAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.runStarters()

        // Create window
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.makeKeyAndVisible()

        // Set root view controller
        RMTGUIManager.sharedInstance.window = window

        return true
    }

    private func runStarters() {
        var starterFactory: RMTStarterFactory = RMTStarterFactory()
        starterFactory.runStarters()
    }
}
