//
//  RMTSessionViewController.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/10/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import UIKit

class RMTSessionViewController: UICollectionViewController {
    let flowLayout: UICollectionViewFlowLayout
    var sessionDatasource : RMTSessionDatasource?
    var session: RMTSession? {
        didSet {
            self.title = session?.title
        }
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(10.0, 0.0, 10.0, 0.0)
        self.flowLayout = layout
        super.init(collectionViewLayout: layout)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.sessionDatasource = RMTSessionDatasource(collectionView: self.collectionView, session: self.session!)
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.backgroundColor = UIColor.appBackgroundColor()
    }

    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        super.willRotateToInterfaceOrientation(toInterfaceOrientation, duration: duration)
        self.flowLayout.invalidateLayout()
    }

    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            let width = CGRectGetWidth(self.collectionView.bounds)
            return CGSizeMake(width, 100.0)
    }
}
