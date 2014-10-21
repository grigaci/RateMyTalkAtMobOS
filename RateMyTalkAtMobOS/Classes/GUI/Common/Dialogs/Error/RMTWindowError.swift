//
//  RMTWindowError.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/17/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import UIKit

class RMTWindowError : RMTWindowBase {
    
    class func ErrorWindow(error: NSError) -> RMTWindowError {
        let window = RMTWindowError()
        window.displayedError = error
        return window
    }

    private var errorViewController: RMTWindowErrorViewController {

        didSet {
            errorViewController.buttonTapped = {
                self.hide()
            }
        }
    }

    var displayedError: NSError? {
        didSet {
            if let error = displayedError {
                self.errorViewController.error = error
            }
        }
    }

    init() {
        var viewController = RMTWindowErrorViewController(nibName: nil, bundle: nil)
        self.errorViewController = viewController
        super.init(viewController:viewController)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
