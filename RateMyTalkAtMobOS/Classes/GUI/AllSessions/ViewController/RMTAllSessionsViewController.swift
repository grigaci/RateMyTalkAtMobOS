//
//  RMTAllSessionsViewController.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/5/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import UIKit

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
        self.collectionView?.backgroundColor = UIColor(fullRed: 243.0, fullGreen: 243.0, fullBlue: 243.0)
        self.collectionView?.alwaysBounceVertical = true
        self.sessionDatasource = RMTAllSessionsDatasource(collectionView: self.collectionView!)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        downloadDataIfNeeded()
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let session = self.sessionDatasource?.fetchedResultsController.objectAtIndexPath(indexPath) as RMTSession
        let viewController = RMTSessionViewController(nibName: nil, bundle: nil)
        viewController.session = session
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        super.willRotateToInterfaceOrientation(toInterfaceOrientation, duration: duration)
        self.flowLayout.invalidateLayout()
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            let width = CGRectGetWidth(self.collectionView!.bounds)
            return CGSizeMake(width, 130.0)
    }

    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int) -> CGSize {
            let width = CGRectGetWidth(self.collectionView!.bounds)
            return CGSizeMake(width, 60.0)
    }

    private func downloadDataIfNeeded() {
        var allSession = RMTSession.MR_findAll().count
        if allSession != 0 {
            return
        }

        MBProgressHUD.showHUDAddedTo(self.collectionView!, animated: true)
        RMTCloudKitManager.sharedInstance.downloadAll { (error) -> Void in
            if error != nil {
                RMTWindowError.ErrorWindow(error!).show()
            }
            MBProgressHUD.hideAllHUDsForView(self.collectionView!, animated: true)
        }
    }
}
