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

    lazy var refreshControl: UIRefreshControl? = {
       let view = UIRefreshControl(frame: CGRectZero)
        view.addTarget(self, action:"updateData", forControlEvents: .ValueChanged)
        return view
    }()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        let layout = UICollectionViewFlowLayout()
        self.flowLayout = layout
        self.session = nil
        super.init(collectionViewLayout: layout)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        self.collectionView?.alwaysBounceVertical = true
        self.sessionDatasource = RMTSessionDatasource(collectionView: self.collectionView!, session: self.session!)
        
        self.collectionView?.addSubview(self.refreshControl!)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame), 100.0)
    }

    func updateData() {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5000000000), dispatch_get_main_queue(), {
            let ret: Void? = self.refreshControl?.endRefreshing()
        })
    }

}
