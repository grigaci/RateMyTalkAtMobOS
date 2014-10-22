//
//  RMTDisplayRatingView.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/11/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import UIKit

class RMTDisplayRatingView: UIView {
    
    var highlightedStars: Float
    lazy var imageViews: [UIImageView] = {
        return [UIImageView]()
    }()

    override init(frame: CGRect) {
        self.highlightedStars = 0.0
        super.init(frame: frame)
        self.addImageViews()
        self.setupConstraints()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func highlightStars(countHighlightedStars: Float) {
        self.highlightedStars = countHighlightedStars
        let countHighlightedStarsInt = Int(countHighlightedStars)
        let countAllStars = self.imageViews.count
        assert(countHighlightedStars > 0 || countHighlightedStarsInt >= 0, "Should be >= 0")
        assert(countHighlightedStars < Float(countAllStars) || countHighlightedStarsInt <= countAllStars, "Should be <= \(countAllStars)")

        let countFullStars = countHighlightedStarsInt > 0 ? countHighlightedStarsInt - 1 : 0
        for index in 0...countFullStars {
            self.updateStarImage(self.imageViews[index], imageName: "star_full")
        }
        
        let pointValue = countHighlightedStars - Float(countHighlightedStarsInt)
        var unhighlightedStarsIndex = countHighlightedStarsInt
        if pointValue > 0 {
            self.updateStarImage(self.imageViews[countHighlightedStarsInt], imageName: "star_half")
            unhighlightedStarsIndex += 1
        }

        if unhighlightedStarsIndex < countAllStars {
            let countEmptyStars = countAllStars - 1
            for index in unhighlightedStarsIndex...countEmptyStars {
                self.updateStarImage(self.imageViews[index], imageName: "star_none")
            }
        }
    }

    private func addImageViews() {
        let count = 4
        for _ in 1...count {
            let imageView = UIImageView(image: UIImage(named: "star_none"))
            imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            imageView.userInteractionEnabled = true
            self.addSubview(imageView)

            self.imageViews += [imageView]
        }
    }
    
    private func setupConstraints() {
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        let count = self.imageViews.count
        for index in 0...count - 1 {
            let imageView = self.imageViews[index]
            self.addVerticalConstraintsForImageView(imageView)
            self.addSizeConstraintsForImageView(imageView)
        
            if index != 0 {
                self.addHorizontalConstraintsBetweenImageViews(self.imageViews[index - 1], secondImageView: imageView)
            }
        }

        if let firstImageView = self.imageViews.first {
            self.addHorizontalConstraintsForFirstImageView(firstImageView)
        }
        
        if let lastImageView = self.imageViews.last {
            self.addHorizontalConstraintsForLastImageView(lastImageView)
        }
    }
    
    private func addVerticalConstraintsForImageView(imageView: UIImageView) {
        let viewsDictionary = ["imageView":imageView]
        var constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[imageView]|",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.addConstraints(constraints)
    }

    private func addHorizontalConstraintsForFirstImageView(imageView: UIImageView) {
        let viewsDictionary = ["imageView":imageView]
        var constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[imageView]",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.addConstraints(constraints)
    }

    private func addHorizontalConstraintsForLastImageView(imageView: UIImageView) {
        let viewsDictionary = ["imageView":imageView]
        var constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:[imageView]|",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.addConstraints(constraints)
    }

    private func addHorizontalConstraintsBetweenImageViews(firstImageView: UIImageView, secondImageView: UIImageView) {
        let viewsDictionary = ["firstImageView" : firstImageView,
                               "secondImageView" : secondImageView]
        var constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:[firstImageView]-5-[secondImageView]",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.addConstraints(constraints)
    }

    private func addSizeConstraintsForImageView(imageView: UIImageView) {
        var constraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: imageView, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0.0);
        self.addConstraint(constraint)
    }
    
    private func updateStarImage(imageView: UIImageView, imageName: String) {
        let image = UIImage(named: imageName)
        imageView.image = image
    }
}
