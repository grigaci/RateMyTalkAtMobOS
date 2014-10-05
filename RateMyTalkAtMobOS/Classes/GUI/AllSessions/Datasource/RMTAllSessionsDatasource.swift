//
//  RMTAllSessionsDatasource.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/5/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import UIKit

class RMTAllSessionsDatasource: NSObject, NSFetchedResultsControllerDelegate, UICollectionViewDataSource {
    let fetchedResultsController: NSFetchedResultsController
    let collectionView: UICollectionView

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.fetchedResultsController = RMTSession.MR_fetchAllGroupedBy(nil, withPredicate: nil, sortedBy: RMTSessionAttributes.title.toRaw(), ascending: true)
        super.init()
        self.collectionView.dataSource = self
        self.collectionView.registerClass(RMTAllSessionsCollectionViewCell.self, forCellWithReuseIdentifier: self.cellIdentifier)

        self.fetchedResultsController.delegate = self
        self.fetchedResultsController.performFetch(nil)
    }

    lazy var cellIdentifier: String = {
        let id = NSStringFromClass(RMTAllSessionsDatasource.self)
        return id
    }()

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let allObjects: [AnyObject] = self.fetchedResultsController.fetchedObjects!
        return allObjects.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.cellIdentifier, forIndexPath: indexPath) as RMTAllSessionsCollectionViewCell
        
        let session = self.fetchedResultsController.objectAtIndexPath(indexPath) as RMTSession
        cell.session = session

        return cell
    }
}
