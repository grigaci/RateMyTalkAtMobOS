//
//  RMTSessionDatasource.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/10/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import Foundation

class RMTSessionDatasource: RMTBaseCollectionViewDatasource {
 
    init(collectionView: UICollectionView, session: RMTSession) {
        let predicate = NSPredicate(format: "self.%K == %@", RMTRatingCategoryRelationships.session.rawValue, session)
        let fetchedResultsController = RMTRatingCategory.MR_fetchAllGroupedBy(nil, withPredicate: predicate,
            sortedBy: RMTParentAttributes.createdAt.rawValue, ascending: true)
        super.init(collectionView: collectionView, fetchedResultsController: fetchedResultsController)
    }

    override func cellClass() -> AnyClass? {
        return RMTSessionCollectionViewCell.self;
    }
    
    override func configureCell(cell: UICollectionViewCell, indexPath: NSIndexPath) {
        let cellRatingCategory = cell as RMTSessionCollectionViewCell
        let ratingCategory = self.fetchedResultsController.objectAtIndexPath(indexPath) as RMTRatingCategory
        cellRatingCategory.ratingCategory = ratingCategory
    }

}
