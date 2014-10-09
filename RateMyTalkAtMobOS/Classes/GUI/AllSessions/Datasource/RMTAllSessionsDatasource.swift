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
    lazy var objectChanges: [NSMutableDictionary] = {
        return [NSMutableDictionary]()
    }()

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
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        var change: NSMutableDictionary = NSMutableDictionary()
        let typeNumber: NSNumber = NSNumber(unsignedLong: type.toRaw())
        switch type {
        case .Insert:
            change.setObject([newIndexPath!], forKey: typeNumber)
        case .Delete:
            change.setObject([indexPath!], forKey: typeNumber)
        case .Update:
            change.setObject([indexPath!], forKey: typeNumber)
        case .Move:
            change.setObject([indexPath!, newIndexPath!], forKey: typeNumber)
        default:
            println("error in didChangeObject")
        }

        self.objectChanges.append(change)
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        if self.objectChanges.count != 0 {
            self.insertChangesIntoCollectionView()
        }
    }

    func insertChangesIntoCollectionView() {
        self.collectionView.performBatchUpdates({ () -> Void in
            for changeObj in self.objectChanges {
                let change: NSMutableDictionary = changeObj as NSMutableDictionary
                let allKeys = change.allKeys as [UInt]
                for numberObj in allKeys {
                    let key: NSFetchedResultsChangeType = NSFetchedResultsChangeType.fromRaw(numberObj) as NSFetchedResultsChangeType!
                    let indexPaths = change.objectForKey(numberObj) as [NSIndexPath]
                    switch key {
                    case .Insert:
                        self.collectionView.insertItemsAtIndexPaths(indexPaths)
                    case .Delete:
                        self.collectionView.deleteItemsAtIndexPaths(indexPaths)
                    case .Update:
                        self.collectionView.reloadItemsAtIndexPaths(indexPaths)
                    case .Move:
                        self.collectionView.moveItemAtIndexPath(indexPaths[0], toIndexPath: indexPaths[1])
                    default:
                        println("error in insertChangesIntoCollectionView")
                    }
                }
                
            }
            
            self.resetFetchedResultControllerChanges()
            }, completion: { (finished: Bool) -> Void in
                self.resetFetchedResultControllerChanges()
        })
    }

    func resetFetchedResultControllerChanges() {
        self.objectChanges.removeAll(keepCapacity: true)
    }
}
