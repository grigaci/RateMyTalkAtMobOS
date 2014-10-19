//
//  RMTAllSessionsCollectionViewCell.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/5/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import UIKit

class RMTAllSessionsCollectionViewCell: UICollectionViewCell {
    
    var session: RMTSession? {
        didSet{
            if let sessionObj = session {
                let topic = sessionObj.title
                let speaker = sessionObj.speaker?.name != nil ? session?.speaker?.name : ""
                self.speakerNameLabel.attributedText = NSAttributedString.speakerNameAttributedString(speaker!)
                self.topicNameTextView.attributedText = NSAttributedString.topicAttributedString(topic!)

                self.ratingView.highlightStars(sessionObj.generalRating!.floatValue)
                self.textSeparator.backgroundColor = sessionObj.speaker?.color()
            }
        }
    }

    lazy var spaceHorizontally: Float = {
        return 15.0
    }()

    lazy var speakerInfoLabel: UILabel = {
        let label = UILabel(frame: CGRectZero)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.attributedText = NSAttributedString.infoAttributedString("Speaker")
        label.textAlignment = NSTextAlignment.Right
        return label
    }()

    lazy var topicInfoLabel: UILabel = {
        let label = UILabel(frame: CGRectZero)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.attributedText = NSAttributedString.infoAttributedString("Topic")
        label.textAlignment = NSTextAlignment.Right
        return label
    }()

    lazy var speakerNameLabel: UILabel = {
        let label = UILabel(frame: CGRectZero)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        return label
    }()

    lazy var topicNameTextView: UITextView = {
        let textView = UITextView(frame: CGRectZero)
        textView.backgroundColor = UIColor.clearColor()
        textView.contentInset = UIEdgeInsetsMake(-5.0, -2.0, 0.0, 0.0)
        textView.userInteractionEnabled = false
        textView.setTranslatesAutoresizingMaskIntoConstraints(false)
        return textView
    }()

    lazy var textSeparator: UIView = {
        let view = UIView(frame: CGRectZero)
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.backgroundColor = UIColor.purpleColor()
        return view
    }()

    lazy var ratingTextLabel: UILabel = {
        let label = UILabel(frame: CGRectZero)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.attributedText = NSAttributedString.averageRatingAttributedString("Average rating")
        return label
    }()

    lazy var ratingView: RMTDisplayRatingView = {
        let ratingView = RMTDisplayRatingView(frame: CGRectZero)
        return ratingView
    }()

    lazy var arrowRightImageView : UIImageView = {
        let imageView = UIImageView(frame: CGRectZero)
        imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        let image = UIImage(named: "arrow_right")
        imageView.image = image
        return imageView
    }()
    
    lazy var cellSeparator: UIView = {
        let view = UIView(frame: CGRectZero)
        view.backgroundColor = UIColor(fullRed: 205.0, fullGreen: 205.0, fullBlue: 205.0)
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.speakerInfoLabel)
        self.contentView.addSubview(self.topicInfoLabel)
        self.contentView.addSubview(self.textSeparator)
        self.contentView.addSubview(self.speakerNameLabel)
        self.contentView.addSubview(self.topicNameTextView)
        self.contentView.addSubview(self.arrowRightImageView)
        self.contentView.addSubview(self.ratingTextLabel)
        self.contentView.addSubview(self.ratingView)
        self.contentView.addSubview(self.cellSeparator)
        setupConstraints()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        self.setupConstraintsInfos()
        self.setupConstraintsSessionValues()
        self.setupConstraintsArrow()
        self.setupConstraintsRating()
        self.setupConstraintsCellSeparator()
    }

    private func setupConstraintsInfos() {
        let spaceV = 15.0
        let spaceDictionary = ["spaceV" : spaceV, "spaceH" : self.spaceHorizontally]
        let viewsDictionary = ["speaker": self.speakerInfoLabel, "topic":self.topicInfoLabel,
            "separator" : self.textSeparator]

        var constraint = NSLayoutConstraint(item: self.speakerInfoLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.speakerNameLabel, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: -1.0)
        self.contentView.addConstraint(constraint)

        constraint = NSLayoutConstraint(item: self.topicInfoLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.topicNameTextView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 5.0)
        self.contentView.addConstraint(constraint)

        constraint = NSLayoutConstraint(item: self.textSeparator, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.speakerInfoLabel, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: -5.0)
        self.contentView.addConstraint(constraint)

        constraint = NSLayoutConstraint(item: self.textSeparator, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.topicNameTextView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -5.0)
        self.contentView.addConstraint(constraint)

        var constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(spaceH)-[speaker]-[separator(==4)]",
            options: NSLayoutFormatOptions(0), metrics: spaceDictionary, views: viewsDictionary)
        self.contentView.addConstraints(constraints)

        constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(spaceH)-[topic]-[separator]",
            options: NSLayoutFormatOptions(0), metrics: spaceDictionary, views: viewsDictionary)
        self.contentView.addConstraints(constraints)
    }
    
    private func setupConstraintsSessionValues() {
        let spaceV = 8.0
        let spaceDictionary = ["spaceV" : spaceV, "spaceH" : self.spaceHorizontally]
        let viewsDictionary = ["speakerName": self.speakerNameLabel, "topicName":self.topicNameTextView]
        var constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-(spaceV)-[speakerName(>=20)][topicName(>=20)]",
            options: NSLayoutFormatOptions(0), metrics: spaceDictionary, views: viewsDictionary)
        self.contentView.addConstraints(constraints)
        
        var constraint = NSLayoutConstraint(item: self.speakerNameLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.textSeparator, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: CGFloat(self.spaceHorizontally))
        self.contentView.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: self.topicNameTextView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.speakerNameLabel, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0.0)
        self.contentView.addConstraint(constraint)        
    }
    
    private func setupConstraintsArrow() {
        let spaceDictionary = ["spaceH" : self.spaceHorizontally]
        let viewsDictionary = ["arrowRight": self.arrowRightImageView, "speakerName": self.speakerNameLabel, "topicName":self.topicNameTextView]
        var constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:[speakerName]-[arrowRight]",
            options: NSLayoutFormatOptions(0), metrics: spaceDictionary, views: viewsDictionary)
        self.contentView.addConstraints(constraints)
        
        constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:[topicName][arrowRight]-|",
            options: NSLayoutFormatOptions(0), metrics: spaceDictionary, views: viewsDictionary)
        self.contentView.addConstraints(constraints)
        
        var constraint = NSLayoutConstraint(item: self.arrowRightImageView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0)
        self.contentView.addConstraint(constraint)

        constraint = NSLayoutConstraint(item: self.arrowRightImageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.arrowRightImageView, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0.0)
        self.contentView.addConstraint(constraint)
    }

    private func setupConstraintsRating() {
        let spaceV = 15.0
        let spaceDictionary = ["spaceV" : spaceV, "spaceH" : self.spaceHorizontally]
        let viewsDictionary = ["ratingLabel": self.ratingTextLabel, "ratingView":self.ratingView, "topicName" : self.topicNameTextView]
        var constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[topicName][ratingView(==20)]",
            options: NSLayoutFormatOptions(0), metrics: spaceDictionary, views: viewsDictionary)
        self.contentView.addConstraints(constraints)
        
        var constraint = NSLayoutConstraint(item: self.ratingTextLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.ratingView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0)
        self.contentView.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: self.ratingTextLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.topicNameTextView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0.0)
        self.contentView.addConstraint(constraint)
        
        constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:[ratingLabel]-[ratingView]",
            options: NSLayoutFormatOptions(0), metrics: spaceDictionary, views: viewsDictionary)
        self.contentView.addConstraints(constraints)
    }
    
    private func setupConstraintsCellSeparator() {
        let spaceDictionary = ["spaceH" : self.spaceHorizontally]
        let viewsDictionary = ["cellSeparator": self.cellSeparator, "ratingView":self.ratingView]
        var constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[ratingView]-[cellSeparator(==1)]|",
            options: NSLayoutFormatOptions(0), metrics: spaceDictionary, views: viewsDictionary)
        self.contentView.addConstraints(constraints)
        
        constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(spaceH)-[cellSeparator]-(spaceH)-|",
            options: NSLayoutFormatOptions(0), metrics: spaceDictionary, views: viewsDictionary)
        self.contentView.addConstraints(constraints)
    }

}
