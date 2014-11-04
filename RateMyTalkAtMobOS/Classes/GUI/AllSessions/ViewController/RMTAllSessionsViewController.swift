//
//  RMTAllSessionsViewController.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/5/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import UIKit

enum RMTAllSessionsViewControllerState: Int {
    case None
    case UploadingData
    case UploadedData
}

class RMTAllSessionsViewController: UICollectionViewController {
    let flowLayout: UICollectionViewFlowLayout
    var sessionDatasource : RMTAllSessionsDatasource?

    var state: RMTAllSessionsViewControllerState {
        didSet {
            switch state {
            case .UploadingData:
                self.handleStateUploadingData()
            case .UploadedData:
                self.handleStateUploadedData()
            case .None:
                self.handleStateNone()
            }
        }
    }

    lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl(frame: CGRectZero)
        view.addTarget(self, action:"handlePullToRefresh", forControlEvents: .ValueChanged)
        return view
    }()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0.0, 0.0, 10.0, 0.0)
        self.flowLayout = layout
        self.state = .None
        super.init(collectionViewLayout: layout)
        self.title = "MOBOS"
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = UIColor.allSessionsBackgroundColor()
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.addSubview(self.refreshControl)
        self.sessionDatasource = RMTAllSessionsDatasource(collectionView: self.collectionView)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.flowLayout.invalidateLayout()
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
            let width = CGRectGetWidth(self.collectionView.bounds)
            return CGSizeMake(width, 130.0)
    }

    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int) -> CGSize {
            let width = CGRectGetWidth(self.collectionView.bounds)
            return CGSizeMake(width, 80.0)
    }

    func handlePullToRefresh() {
        self.state = .UploadingData
        RMTCloudKitManager.sharedInstance.syncRatings { (error) -> Void in
            self.cloudOperationsDidFinish(error)
        }
    }

    private func cloudOperationsDidFinish(error: NSError?) {
        if error != nil {
            UIAlertView.showAppError(error!)
        }
        self.state = .UploadedData
    }

    private func handleStateUploadingData() {
        // Nothing at this point
    }

    private func handleStateUploadedData() {
        self.sessionDatasource?.sectionHeader?.hidden = false
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        self.refreshControl.endRefreshing()
    }

    private func handleStateNoData() {
        self.sessionDatasource?.sectionHeader?.hidden = true
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        self.refreshControl.endRefreshing()
    }

    private func handleStateNone() {
        // Nothing at this point
    }

}
