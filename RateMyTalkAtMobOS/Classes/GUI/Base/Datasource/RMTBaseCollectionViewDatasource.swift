//
//  RMTBaseCollectionViewDatasource.swift
//  RateMyTalkAtMobOS
//
//  Created by Bogdan Iusco on 10/10/14.
//  Copyright (c) 2014 Grigaci. All rights reserved.
//

import UIKit

class RMTBaseCollectionViewDatasource: NSObject, NSFetchedResultsControllerDelegate, UICollectionViewDataSource {
    let fetchedResultsController: NSFetchedResultsController
    let collectionView: UICollectionView
    lazy var objectChanges: [NSMutableDictionary] = {
        return [NSMutableDictionary]()
        }()
    
    init(collectionView: UICollectionView, fetchedResultsController: NSFetchedResultsController) {
        self.collectionView = collectionView
        self.fetchedResultsController = fetchedResultsController;
        super.init()
        self.collectionView.dataSource = self
        self.collectionView.registerClass(self.cellClass(), forCellWithReuseIdentifier: self.cellIdentifier)
        
        self.fetchedResultsController.delegate = self
        self.fetchedResultsController.performFetch(nil)
    }
    
    lazy var cellIdentifier: String = {
        let id = NSStringFromClass(self.cellClass())
        return id
        }()
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let allObjects: [AnyObject] = self.fetchedResultsController.fetchedObjects!
        return allObjects.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(self.cellIdentifier, forIndexPath: indexPath) as UICollectionViewCell
        self.configureCell(cell, indexPath: indexPath)

        return cell
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        var change: NSMutableDictionary = NSMutableDictionary()
        let typeNumber: NSNumber = NSNumber(unsignedLong: type.rawValue)
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
            RMTLogError("default switch case", function: __FUNCTION__, line: __LINE__)
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
                    let key: NSFetchedResultsChangeType = NSFetchedResultsChangeType(rawValue: numberObj) as NSFetchedResultsChangeType!
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
                        RMTLogError("default switch case", function: __FUNCTION__, line: __LINE__)
                    }
                }
            }
            
            self.resetFetchedResultControllerChanges()
            }, completion: nil)
    }
    
    func resetFetchedResultControllerChanges() {
        self.objectChanges.removeAll(keepCapacity: true)
    }
    
    // Methods to override

    func cellClass() -> AnyClass? {
        return nil;
    }

    func configureCell(cell: UICollectionViewCell, indexPath: NSIndexPath) {
        // Base method
    }
}
