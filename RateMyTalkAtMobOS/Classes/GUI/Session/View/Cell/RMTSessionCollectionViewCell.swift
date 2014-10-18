//
//  RMTSessionCollectionViewCell.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/10/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import UIKit

class RMTSessionCollectionViewCell: UICollectionViewCell {

    var ratingCategory: RMTRatingCategory? {
        didSet{
            let title = (ratingCategory?.title != nil) ? ratingCategory?.title : ""
            self.titleLabel.text = title
            self.updateRating()
        }
    }

    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRectZero)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        return label
        }()
    
    lazy var ratingView: RMTEditRatingView = {
        let ratingView = RMTEditRatingView(frame: CGRectZero)
        return ratingView
        }()
    
    lazy var lineView: UIView = {
        let view = UIView(frame: CGRectZero)
        view.backgroundColor = UIColor(fullRed: 205.0, fullGreen: 205.0, fullBlue: 205.0)
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        return view
        }()

    lazy var spaceHorizontally: CGFloat = {
        let totalWidth = self.contentView.frame.size.width
        let devider = CGFloat(10.0)
        return  totalWidth / devider;
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.ratingView)
        self.contentView.addSubview(self.lineView)
        setupConstraints()
        setupRatingListener()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        let viewsDictionary = ["titleLabel":titleLabel,
                               "ratingView":self.ratingView,
                               "lineView":self.lineView]
        let screenSize = UIScreen.mainScreen().fixedScreenSize
        let ratingViewWidth = (screenSize.width - (2.0 * self.spaceHorizontally)) / 2.0
        let sizeDictionary = ["spaceH" : self.spaceHorizontally, "ratingViewWidth" : ratingViewWidth]

        var constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(spaceH)-[titleLabel]-[ratingView(==ratingViewWidth)]-(spaceH)-|",
            options: NSLayoutFormatOptions(0), metrics: sizeDictionary, views: viewsDictionary)
        self.contentView.addConstraints(constraints)

        constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(spaceH)-[lineView]-(spaceH)-|",
            options: NSLayoutFormatOptions(0), metrics: sizeDictionary, views: viewsDictionary)
        self.contentView.addConstraints(constraints)

        constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[titleLabel]-[lineView(==1)]|",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.contentView.addConstraints(constraints)

        let constraintRatingViewV = NSLayoutConstraint(item: self.titleLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.ratingView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0)
        self.contentView.addConstraint(constraintRatingViewV)
    }

    private func updateRating() {
        var defaultStars: Float = 0.0
        if let myStars = self.ratingCategory?.myLocalRating?.floatValue {
            defaultStars = myStars
        }
        else if let myRating = self.ratingCategory?.myRating() {
            if let stars = myRating.stars?.floatValue {
                defaultStars = stars
                self.ratingCategory?.myLocalRating = NSNumber(float: stars)
            }
        }
        
        self.ratingView.highlightStars(defaultStars)
    }

    private func setupRatingListener() {
        self.ratingView.valueChangedCallback = {(newValue: Float) -> () in
            if self.ratingCategory?.myLocalRating?.floatValue != newValue {
                self.ratingCategory?.myLocalRating = NSNumber(float: newValue)
                NSManagedObjectContext.MR_defaultContext().MR_saveOnlySelfAndWait()
            }
        }
    }
}
