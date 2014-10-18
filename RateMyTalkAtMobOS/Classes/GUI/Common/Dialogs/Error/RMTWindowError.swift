//
//  RMTWindowError.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/17/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import UIKit

class RMTWindowError : RMTWindowBase {
    
    private lazy var errorViewController: RMTWindowErrorViewController = {
        var viewController = RMTWindowErrorViewController(nibName: nil, bundle: nil)
        viewController.buttonTapped = {
            self.hide()
        }
       return viewController
    }()

    var displayedError: NSError? {
        didSet {
            if let error = displayedError {
                self.errorViewController.error = error
            }
        }
    }

    init() {
        super.init(viewController:self.errorViewController)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
