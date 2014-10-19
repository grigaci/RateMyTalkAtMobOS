//
//  RMTAllSessionsDatasource.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/5/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import UIKit

class RMTAllSessionsDatasource: RMTBaseCollectionViewDatasource {
    lazy var headerIdentifier: String = {
        let id = NSStringFromClass(RMTAllSessionsCollectionViewHeader)
        return id
    }()

    init(collectionView: UICollectionView) {
        let fetchedResultsController = RMTSession.MR_fetchAllGroupedBy(nil, withPredicate: nil, sortedBy: RMTSessionAttributes.startDate.toRaw(), ascending: true)
        super.init(collectionView: collectionView, fetchedResultsController: fetchedResultsController)

        self.collectionView.registerClass(RMTAllSessionsCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: self.headerIdentifier)
    }

    override func cellClass() -> AnyClass? {
        return RMTAllSessionsCollectionViewCell.self;
    }

    override func configureCell(cell: UICollectionViewCell, indexPath: NSIndexPath) {
        let cellSession = cell as RMTAllSessionsCollectionViewCell
        let session = self.fetchedResultsController.objectAtIndexPath(indexPath) as RMTSession
        cellSession.session = session
    }

    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: self.headerIdentifier, forIndexPath: indexPath) as RMTAllSessionsCollectionViewHeader
        
        header.tappedCallback = {
            self.handletHeaderTap()
        }
        
        return header
    }

    private func handletHeaderTap() {
        MBProgressHUD.showHUDAddedTo(self.collectionView, animated: true)
        RMTSession.saveAllMyRatings()
        RMTCloudKitManager.sharedInstance.syncRatings { (error) -> Void in
            if error != nil {
                RMTWindowError.ErrorWindow(error!).show()
            }
            MBProgressHUD.hideAllHUDsForView(self.collectionView, animated: true)
        }
    }

}
