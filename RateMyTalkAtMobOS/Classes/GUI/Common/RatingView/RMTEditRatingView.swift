//
//  RMTEditRatingView.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/11/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import UIKit

class RMTEditRatingView: RMTDisplayRatingView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTapGestures()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func handleTapGesture(tapGesture:UITapGestureRecognizer) {
        let tappedImageView = tapGesture.view
        let index = self.imageViews.find {$0 == tappedImageView}
        if index != nil {
            let highlightValue = Float(index! + 1)
            self.highlightStars(highlightValue)
        }
    }

    private func addTapGestures() {
        for imageView in self.imageViews {
            self.addTapGestureImageView(imageView)
        }
    }

    private func addTapGestureImageView(imageView: UIImageView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: "handleTapGesture:")
        imageView.addGestureRecognizer(tapGesture)
    }

}
