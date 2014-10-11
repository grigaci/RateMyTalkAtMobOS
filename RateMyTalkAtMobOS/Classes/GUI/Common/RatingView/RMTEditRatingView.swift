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
        self.addPanGesture()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func handleTapGesture(tapGesture:UITapGestureRecognizer) {
        let tappedImageView = tapGesture.view as? UIImageView
        self.tapOnImageView(tappedImageView)
    }

    func handlePanGesture(panGesture: UIPanGestureRecognizer) {
        switch panGesture.state {
        case .Began, .Changed, .Ended:
            self.handlePanGestureHighlight(panGesture)
        default: ()
        }
    }

    private func handlePanGestureHighlight(panGesture: UIPanGestureRecognizer) {
        let point = panGesture.locationInView(self)
        var touchedImageView: UIImageView? = nil
        for imageView in self.imageViews {
            let pointInView = imageView.convertPoint(point, fromView: self)
            if imageView.pointInside(pointInView, withEvent: nil) {
                touchedImageView = imageView
                break
            }
        }
        if touchedImageView != nil {
            self.tapOnImageView(touchedImageView)
        }
    }

    private func tapOnImageView(imageView: UIImageView?) {
        let index = self.imageViews.find {$0 == imageView}
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

    private func addPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        self.addGestureRecognizer(panGesture)
    }
}
