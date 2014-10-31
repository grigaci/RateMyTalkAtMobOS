//
//  RMTWindowErrorViewContent.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/17/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import UIKit

class RMTWindowErrorViewContent: UIView {
    
    lazy var contentView: UIView = {
        let view = UIView(frame: self.bounds)
        view.backgroundColor = UIColor.whiteColor()
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
    
        view.addSubview(self.titleTextView)
        view.addSubview(self.descriptionTextView)
        view.addSubview(self.button)
        return view
    }()
    
    lazy var titleTextView: UITextView = {
        let textView = UITextView(frame: CGRectZero)
        textView.setTranslatesAutoresizingMaskIntoConstraints(false)
        textView.editable = false
        textView.scrollEnabled = false
        textView.selectable = false
        
        return textView
    }()

    lazy var descriptionTextView: UITextView = {
        let textView = UITextView(frame: CGRectZero)
        textView.setTranslatesAutoresizingMaskIntoConstraints(false)
        textView.editable = false
        textView.scrollEnabled = false
        textView.selectable = false
        
        return textView
    }()
    
    lazy var button: UIButton = {
       let buttonObj = UIButton(frame: CGRectZero)
        buttonObj.setTranslatesAutoresizingMaskIntoConstraints(false)
        buttonObj.backgroundColor = UIColor.grayColor()
        buttonObj.tintColor = UIColor.blackColor()
        
        return buttonObj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.contentView)
        self.setupConstraints()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        self.setupConstraintsContentView()
        self.setupConstraintsTitleView()
        self.setupConstraintsDescriptionView()
        self.setupConstraintsButton()
    }

    private func setupConstraintsContentView() {
        let viewsDictionary = ["contentView" : self.contentView]
        var constraint: NSLayoutConstraint
        
        let spacePercent: CGFloat = 8.2
        let screenSize = UIScreen.mainScreen().fixedScreenSize
        let space = screenSize.width * spacePercent / 100.0
        let contentWidth = screenSize.width - (2.0 * space)
        
        let sizeDictionary = ["width" : contentWidth]
        
        constraint = NSLayoutConstraint(item: self.contentView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        self.addConstraint(constraint)

        constraint = NSLayoutConstraint(item: self.contentView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0)
        self.addConstraint(constraint)

        let constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:[contentView(==width)]", options: NSLayoutFormatOptions(0), metrics: sizeDictionary, views: viewsDictionary)
        self.addConstraints(constraints)
    }
    
    func setupConstraintsTitleView() {
        let viewsDictionary = ["title" : self.titleTextView]
        let constraintsH = NSLayoutConstraint.constraintsWithVisualFormat("H:|-27-[title]-27-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.addConstraints(constraintsH)
        let constraintsV = NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[title]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.addConstraints(constraintsV)
    }
    
    func setupConstraintsDescriptionView() {
        let viewsDictionary = ["title" : self.titleTextView, "description" : self.descriptionTextView]
        var constraint: NSLayoutConstraint

        constraint = NSLayoutConstraint(item: self.titleTextView, attribute: .CenterX, relatedBy: .Equal, toItem: self.descriptionTextView, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        self.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: self.titleTextView, attribute: .Width, relatedBy: .Equal, toItem: self.descriptionTextView, attribute: .Width, multiplier: 1.0, constant: 0.0)
        self.addConstraint(constraint)

        let constraintsV = NSLayoutConstraint.constraintsWithVisualFormat("V:[title]-10-[description]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.addConstraints(constraintsV)
    }

    func setupConstraintsButton() {
        let viewsDictionary = ["button" : self.button, "description" : self.descriptionTextView]
        var constraint: NSLayoutConstraint
        
        constraint = NSLayoutConstraint(item: self.titleTextView, attribute: .CenterX, relatedBy: .Equal, toItem: self.button, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        self.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: self.titleTextView, attribute: .Width, relatedBy: .Equal, toItem: self.button, attribute: .Width, multiplier: 1.0, constant: 0.0)
        self.addConstraint(constraint)
        
        let constraintsV = NSLayoutConstraint.constraintsWithVisualFormat("V:[description]-20-[button]-25-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.addConstraints(constraintsV)
    }
}

