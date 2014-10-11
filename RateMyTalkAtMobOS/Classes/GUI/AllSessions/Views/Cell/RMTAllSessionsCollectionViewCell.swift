//
//  RMTAllSessionsCollectionViewCell.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/5/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import UIKit

class RMTAllSessionsCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(speakerLabel)
        self.contentView.addSubview(ratingView)
        self.contentView.addSubview(lineView)
        setupConstraints()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var session: RMTSession? {
        didSet{
            let title = (session?.title != nil) ? session?.title : ""
            let speaker = session?.speaker?.name != nil ? session?.speaker?.name : ""
            titleLabel.text = "Title: \(title!)"
            speakerLabel.text = "Speaker: \(speaker!)"
        }
    }

    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRectZero)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        return label
    }()
    
    lazy var speakerLabel: UILabel = {
        let label = UILabel(frame: CGRectZero)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        return label
    }()

    lazy var ratingView: RMTDisplayRatingView = {
        let ratingView = RMTDisplayRatingView(frame: CGRectZero)
        return ratingView
    }()

    lazy var lineView: UIView = {
        let view = UIView(frame: CGRectZero)
        view.backgroundColor = UIColor.blueColor()
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        return view
    }()

    func setupConstraints() {
        let viewsDictionary = ["titleLabel":titleLabel,
                             "speakerLabel":speakerLabel,
                               "ratingView":ratingView,
                                 "lineView":lineView]
        var constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[titleLabel]-|",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.contentView.addConstraints(constraints)

        constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[speakerLabel]-|",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.contentView.addConstraints(constraints)

        constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[lineView]|",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.contentView.addConstraints(constraints)

        constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:[ratingView]-10-|",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.contentView.addConstraints(constraints)
    
        constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[titleLabel]-[speakerLabel]-[ratingView(==40)]-[lineView(==1)]|",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.contentView.addConstraints(constraints)
    }

}
