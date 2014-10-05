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
        self.contentView.addSubview(titleLabel!)
        self.contentView.addSubview(speakerLabel!)
        setupConstraints()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var session: RMTSession? {
        didSet{
            titleLabel?.text = "Title: \(session?.title)"
            speakerLabel?.text = "Speaker: \(session?.speaker?.name)"
        }
    }

    lazy var titleLabel: UILabel? = {
        let label = UILabel(frame: CGRectZero)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        return label
    }()
    
    lazy var speakerLabel: UILabel? = {
        let label = UILabel(frame: CGRectZero)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        return label
    }()
    
    func setupConstraints() {
        let viewsDictionary = ["titleLabel":titleLabel!,
                             "speakerLabel":speakerLabel!]
        var constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[titleLabel]|",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.contentView.addConstraints(constraints)

        constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[speakerLabel]|",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.contentView.addConstraints(constraints)
        
        constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[titleLabel]-[speakerLabel]-|",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.contentView.addConstraints(constraints)
    }

}
