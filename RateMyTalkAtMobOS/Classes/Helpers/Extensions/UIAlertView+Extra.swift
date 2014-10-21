//
//  UIAlertView+Extra.swift
//  RateMyTalkAtMobOS
//
//  Created by bogdan on 21/10/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import UIKit

extension UIAlertView {
    class func showAppError(error: NSError) {
        let alertView = UIAlertView(title: error.titleText,
                                  message: error.descriptionText,
                                 delegate: nil,
                        cancelButtonTitle: "OK")
        alertView.show()
    }
}
