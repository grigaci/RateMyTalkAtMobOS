//
//  RMTAllSessionsViewController.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/5/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import Foundation

class RMTAllSessionsViewController: UICollectionViewController {
    let flowLayout: UICollectionViewFlowLayout
    var sessionDatasource : RMTAllSessionsDatasource?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        let layout = UICollectionViewFlowLayout()
        self.flowLayout = layout
        super.init(collectionViewLayout: layout)
        self.title = "MOBOS"
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        self.sessionDatasource = RMTAllSessionsDatasource(collectionView: self.collectionView!)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        downloadDataIfNeeded()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame), 100.0)
    }
    
    private func downloadDataIfNeeded() {
        var allSession = RMTSession.MR_findAll().count
        if allSession != 0 {
            return
        }
        
        MBProgressHUD.showHUDAddedTo(self.collectionView!, animated: true)
        RMTCloudKitManager.sharedInstance.downloadAll { () -> Void in
            // Need to catch the result, otherwise we get an error
            let result = MBProgressHUD.hideAllHUDsForView(self.collectionView!, animated: true)
        }
    }
}
