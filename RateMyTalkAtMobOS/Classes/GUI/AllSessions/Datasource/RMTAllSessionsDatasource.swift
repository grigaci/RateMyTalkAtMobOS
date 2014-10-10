//
//  RMTAllSessionsDatasource.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/5/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import UIKit

class RMTAllSessionsDatasource: RMTBaseCollectionViewDatasource {
    init(collectionView: UICollectionView) {
        let fetchedResultsController = RMTSession.MR_fetchAllGroupedBy(nil, withPredicate: nil, sortedBy: RMTSessionAttributes.title.toRaw(), ascending: true)
        super.init(collectionView: collectionView, fetchedResultsController: fetchedResultsController)
    }

    override func cellClass() -> AnyClass? {
        return RMTAllSessionsCollectionViewCell.self;
    }

    override func configureCell(cell: UICollectionViewCell, indexPath: NSIndexPath) {
        let cellSession = cell as RMTAllSessionsCollectionViewCell
        let session = self.fetchedResultsController.objectAtIndexPath(indexPath) as RMTSession
        cellSession.session = session
    }

}
