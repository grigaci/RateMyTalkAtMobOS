//
//  RMTAllSessionsCollectionViewHeader.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/18/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import UIKit

class RMTAllSessionsCollectionViewHeader: UICollectionReusableView {

    var tappedCallback: (() -> ())?
    lazy var syncImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRectZero)
        imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        imageView.image = UIImage(named: "sync")
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        return imageView
    }()
    
    lazy var syncTextLabel: UILabel = {
        let label = UILabel(frame: CGRectZero)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.attributedText = NSAttributedString.syncTextAttributedString("Pull down to sync your ratings")
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.syncImageView)
        self.addSubview(self.syncTextLabel)
        self.setupConstraints()
        self.addTapGesture()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func handleTapGesture(gesture: UITapGestureRecognizer) {
        if let callback = self.tappedCallback {
            callback()
        }
    }

    private func setupConstraints() {
        let viewsDictionary = ["imageview": self.syncImageView, "label": self.syncTextLabel]
        var constraintH = NSLayoutConstraint(item: self.syncImageView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        self.addConstraint(constraintH)

        constraintH = NSLayoutConstraint(item: self.syncTextLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.syncImageView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        self.addConstraint(constraintH)

        let constraintsV = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[imageview]-[label]-|",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.addConstraints(constraintsV)
    }

    private func addTapGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: "handleTapGesture:")
        self.addGestureRecognizer(gesture)
    }
}