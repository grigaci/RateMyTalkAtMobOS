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

    var sectionHeader: RMTAllSessionsCollectionViewHeader?

    init(collectionView: UICollectionView) {
        let fetchedResultsController = RMTSession.MR_fetchAllGroupedBy(nil, withPredicate: nil, sortedBy: RMTSessionAttributes.startDate.rawValue, ascending: true)
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
        
        if self.sectionHeader?.hidden == true {
           self.sectionHeader?.hidden = false
        }
    }

    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        self.sectionHeader = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: self.headerIdentifier, forIndexPath: indexPath) as? RMTAllSessionsCollectionViewHeader

        if self.collectionView.numberOfItemsInSection(indexPath.section) == 0 {
            self.sectionHeader?.hidden = true
        }

        return self.sectionHeader!
    }

}
