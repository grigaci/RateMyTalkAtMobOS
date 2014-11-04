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
            self.textView.attributedText = NSAttributedString.ratingCategoryAttributedString(title!)
            self.updateRating()
        }
    }

    lazy var textView: UITextView = {
        let textView = UITextView(frame: CGRectZero)
        textView.setTranslatesAutoresizingMaskIntoConstraints(false)
        textView.userInteractionEnabled = false
        textView.backgroundColor = UIColor.clearColor()
        textView.contentInset = UIEdgeInsetsMake(-8.0, 0.0, 0.0, 0.0)
        return textView
    }()
    
    lazy var ratingView: RMTEditRatingView = {
        var ratingView = RMTEditRatingView(frame: CGRectZero)
        ratingView.valueChangedCallback = {
            if let myRating = self.ratingCategory!.myRating() {
                myRating.temporaryRating = $0
            }
        }

        return ratingView
    }()
    
    lazy var lineView: UIView = {
        let view = UIView(frame: CGRectZero)
        view.backgroundColor = UIColor(fullRed: 205.0, fullGreen: 205.0, fullBlue: 205.0)
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        return view
    }()

    lazy var spaceHorizontally: CGFloat = {
        let totalWidth = UIScreen.mainScreen().fixedScreenSize.width
        let devider = CGFloat(10.0)
        return  totalWidth / devider;
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.textView)
        self.contentView.addSubview(self.ratingView)
        self.contentView.addSubview(self.lineView)
        self.setupConstraints()
        self.registerListeners()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

     deinit {
        self.unregisterListeners()
    }

    func saveCurrentRating() {
/** Temporary workaround
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            if let myRating = self.ratingCategory?.myRating() {
                myRating.saveTemporaryRatingAsStars()
            }
        })
*/
    }

    private func setupConstraints() {
        let viewsDictionary = ["textView":self.textView,
                               "ratingView":self.ratingView,
                               "lineView":self.lineView]
        let screenSize = UIScreen.mainScreen().fixedScreenSize
        let ratingViewWidth = (screenSize.width - (2 * self.spaceHorizontally)) / 2.0
        let sizeDictionary = ["spaceH" : self.spaceHorizontally, "ratingViewWidth" : ratingViewWidth]

        var constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(spaceH)-[textView]-(spaceH)-|",
            options: NSLayoutFormatOptions(0), metrics: sizeDictionary, views: viewsDictionary)
        self.contentView.addConstraints(constraints)

        constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:[ratingView(==ratingViewWidth)]-(spaceH)-|",
            options: NSLayoutFormatOptions(0), metrics: sizeDictionary, views: viewsDictionary)
        self.contentView.addConstraints(constraints)

        constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(spaceH)-[lineView]-(spaceH)-|",
            options: NSLayoutFormatOptions(0), metrics: sizeDictionary, views: viewsDictionary)
        self.contentView.addConstraints(constraints)

        constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-(1@700)-[textView][ratingView]-[lineView(==1)]|",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.contentView.addConstraints(constraints)
    }

    private func updateRating() {
        var defaultStars: Float = 0.0
        
        if let myStars = self.ratingCategory?.myRating()?.temporaryRating {
            defaultStars = myStars
        }
        else if let myRating = self.ratingCategory?.myRating() {
            if let stars = myRating.stars?.floatValue {
                defaultStars = stars
                self.ratingCategory?.myRating()?.temporaryRating = defaultStars
            }
        }
        self.ratingView.highlightStars(defaultStars)
    }

    private func registerListeners() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "saveCurrentRating", name: kNotificationSessionSaveCurrentRatings, object: nil)
    }

    private func unregisterListeners() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
