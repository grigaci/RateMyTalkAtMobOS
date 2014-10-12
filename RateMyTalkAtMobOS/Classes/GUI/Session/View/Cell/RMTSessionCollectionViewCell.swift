//
//  RMTSessionCollectionViewCell.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/10/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import UIKit

class RMTSessionCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(titleLabel!)
        self.contentView.addSubview(detailLabel!)
        self.contentView.addSubview(ratingView)
        self.contentView.addSubview(lineView!)
        setupConstraints()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var ratingCategory: RMTRatingCategory? {
        didSet{
            let title = (ratingCategory?.title != nil) ? ratingCategory?.title : ""
            let detail = ratingCategory?.detail != nil ? ratingCategory?.detail : ""
            titleLabel!.text = "Title: \(title!)"
            detailLabel!.text = "Detail: \(detail!)"
            self.updateRating()
        }
    }

    lazy var titleLabel: UILabel? = {
        let label = UILabel(frame: CGRectZero)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        return label
        }()
    
    lazy var detailLabel: UILabel? = {
        let label = UILabel(frame: CGRectZero)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        return label
        }()

    lazy var ratingView: RMTEditRatingView = {
        let ratingView = RMTEditRatingView(frame: CGRectZero)
        return ratingView
        }()

    lazy var lineView: UIView? = {
        let view = UIView(frame: CGRectZero)
        view.backgroundColor = UIColor.blueColor()
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        return view
        }()
    
    func setupConstraints() {
        let viewsDictionary = ["titleLabel":titleLabel!,
            "detailLabel":detailLabel!,
            "ratingView":ratingView,
            "lineView":lineView!]
        var constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[titleLabel]-|",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.contentView.addConstraints(constraints)
        
        constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[detailLabel]-|",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.contentView.addConstraints(constraints)

        constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:[ratingView]-10-|",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.contentView.addConstraints(constraints)

        constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[lineView]|",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.contentView.addConstraints(constraints)
        
        constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[titleLabel]-[detailLabel]-[ratingView(==40)]-[lineView(==1)]|",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.contentView.addConstraints(constraints)
    }
    
    private func updateRating() {
        if let myRating = self.ratingCategory?.myRating() {
            if let stars = myRating.stars?.floatValue {
                self.ratingView.highlightStars(stars)
            }
        }
    }
}
