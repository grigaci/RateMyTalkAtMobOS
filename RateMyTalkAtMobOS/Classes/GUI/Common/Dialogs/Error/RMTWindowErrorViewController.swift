//
//  RMTWindowErrorViewController.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/17/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import UIKit

class RMTWindowErrorViewController: UIViewController {
    
    lazy var viewContent: RMTWindowErrorViewContent = {
        let view = RMTWindowErrorViewContent(frame: CGRectZero)
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        return view
    }()

    var buttonTapped: (() -> ())?

    var error: NSError? {
        didSet {
            self.updateContentTitleText()
            self.updateContentDescriptionText()
        }
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clearColor()
        self.view.addSubview(self.viewContent)
        
        self.updateContentButtonText()
        self.setupActions()
        self.setupConstraints()
    }
    
    private func setupActions() {
        self.viewContent.button.addTarget(self, action: "handleButtonTap", forControlEvents: UIControlEvents.TouchDown)
    }
    
    private func setupConstraints() {
        let viewsDictionary = ["content" : self.viewContent]
        let constraintsH = NSLayoutConstraint.constraintsWithVisualFormat("H:|[content]|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.view.addConstraints(constraintsH)
        let constraintsV = NSLayoutConstraint.constraintsWithVisualFormat("V:|[content]|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        self.view.addConstraints(constraintsV)
    }
    
    func handleButtonTap() {
        if let buttonClose = self.buttonTapped {
            buttonClose()
        }
    }

    private func updateContentTitleText() {
        if let displayError = self.error {
            if let title = displayError.titleText {
                self.viewContent.titleTextView.text = title
            }
        }
    }
    
    private func updateContentDescriptionText() {
        if let displayError = self.error {
            if let description = displayError.descriptionText {
                self.viewContent.descriptionTextView.text = description
            }
        }
    }

    private func updateContentButtonText() {
        self.viewContent.button.setTitle("OK", forState: UIControlState.Normal)
    }
}
