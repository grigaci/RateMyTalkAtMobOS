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
    case DownloadingData
    case UploadingData
    case DownloadedOrUploadedData
    case NoData
}

class RMTAllSessionsViewController: UICollectionViewController {
    let flowLayout: UICollectionViewFlowLayout
    var sessionDatasource : RMTAllSessionsDatasource?

    var state: RMTAllSessionsViewControllerState {
        didSet {
            switch state {
            case .DownloadingData:
                self.handleStateDownloadingData()
            case .UploadingData:
                self.handleStateUploadingData()
            case .DownloadedOrUploadedData:
                self.handleStateDownloadedOrUploadedData()
            case .NoData:
                self.handleStateNoData()
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

    lazy var noConnectionTextView: UITextView = {
        let textView = UITextView(frame: CGRectZero)
        textView.setTranslatesAutoresizingMaskIntoConstraints(false)
        textView.attributedText = NSAttributedString.noConnectionAttributedString()
        textView.userInteractionEnabled = false
        textView.backgroundColor = UIColor.clearColor()
        return textView
    }()

    lazy var noContentViewConstraints: [NSLayoutConstraint] = {
        let constraintV = NSLayoutConstraint(item: self.noConnectionTextView, attribute: .CenterY, relatedBy: .Equal, toItem: self.collectionView, attribute: .CenterY, multiplier: 1.0, constant: -50.0)
        let constraintH = NSLayoutConstraint(item: self.noConnectionTextView, attribute: .CenterX, relatedBy: .Equal, toItem: self.collectionView, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        let constraintWidth = NSLayoutConstraint(item: self.noConnectionTextView, attribute: .Width, relatedBy: .Equal, toItem: self.collectionView, attribute: .Width, multiplier: 1.0, constant: -40.0)
        let constraintHeight = NSLayoutConstraint(item: self.noConnectionTextView, attribute: .Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: .Height, multiplier: 0.0, constant: 100.0)
        let constraints = [constraintV, constraintH, constraintWidth, constraintHeight]
        return constraints
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
    
    deinit {
        self.unregisterListeners()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = UIColor.allSessionsBackgroungColor()
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.addSubview(self.refreshControl)
        self.sessionDatasource = RMTAllSessionsDatasource(collectionView: self.collectionView)
        self.registerListeners()
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

    func appDidBecomeActive() {
        self.downloadAllSesssionsIfNeeded()
    }

    private func downloadAllSesssionsIfNeeded() {
        if NSUserDefaults.standardUserDefaults().iCloudDataDownloaded {
            return
        }

        self.state = .DownloadingData
        RMTCloudKitManager.sharedInstance.downloadAll { (error) -> Void in
            self.cloudOperationsDidFinish(error)
        }
    }

    func handlePullToRefresh() {
        if !NSUserDefaults.standardUserDefaults().iCloudDataDownloaded {
            self.downloadAllSesssionsIfNeeded()
            return
        }

        self.state = .UploadingData
        RMTSession.saveAllMyRatings()
        RMTCloudKitManager.sharedInstance.syncRatings { (error) -> Void in
            self.cloudOperationsDidFinish(error)
        }
    }

    private func cloudOperationsDidFinish(error: NSError?) {
        if error != nil {
            UIAlertView.showAppError(error!)
        }
        if NSUserDefaults.standardUserDefaults().iCloudDataDownloaded {
            self.state = .DownloadedOrUploadedData
        } else {
            self.state = .NoData
        }
    }

    private func registerListeners() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "appDidBecomeActive", name: UIApplicationDidBecomeActiveNotification, object: nil)
    }
    
    private func unregisterListeners() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    private func handleStateDownloadingData() {
        self.removeNoContentTextView()
        self.sessionDatasource?.sectionHeader?.hidden = false
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        self.refreshControl.endRefreshing()
    }

    private func handleStateUploadingData() {
        self.removeNoContentTextView()
    }

    private func handleStateDownloadedOrUploadedData() {
        self.removeNoContentTextView()
        self.sessionDatasource?.sectionHeader?.hidden = false
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        self.refreshControl.endRefreshing()
    }

    private func handleStateNoData() {
        self.addNoContentTextView()
        self.sessionDatasource?.sectionHeader?.hidden = true
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        self.refreshControl.endRefreshing()
    }
    private func handleStateNone() {
        // Nothing at this point
    }

    private func addNoContentTextView() {
        if self.noConnectionTextView.superview != nil {
            return
        }

        self.collectionView.addSubview(self.noConnectionTextView)
        self.collectionView.addConstraints(self.noContentViewConstraints)
    }

    private func removeNoContentTextView() {
        if self.noConnectionTextView.superview == nil {
            return
        }

        self.noConnectionTextView.removeFromSuperview()
        self.collectionView.removeConstraints(self.noContentViewConstraints)
    }
}
