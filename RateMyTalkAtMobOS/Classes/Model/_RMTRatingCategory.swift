// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RMTRatingCategory.swift instead.

import CoreData

enum RMTRatingCategoryAttributes: String {
    case detail = "detail"
    case title = "title"
}

enum RMTRatingCategoryRelationships: String {
    case ratings = "ratings"
    case sessions = "sessions"
}

@objc
class _RMTRatingCategory: RMTParent {

    // MARK: - Class methods

    override class func entityName () -> String {
        return "RMTRatingCategory"
    }

    override class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _RMTRatingCategory.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged
    var detail: String?

    // func validateDetail(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var title: String?

    // func validateTitle(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    // MARK: - Relationships

    @NSManaged
    var ratings: NSOrderedSet

    @NSManaged
    var sessions: NSOrderedSet

}

extension _RMTRatingCategory {

    func addRatings(objects: NSOrderedSet) {
        let mutable = self.ratings.mutableCopy() as NSMutableOrderedSet
        mutable.unionOrderedSet(objects)
        self.ratings = mutable.copy() as NSOrderedSet
    }

    func removeRatings(objects: NSOrderedSet) {
        let mutable = self.ratings.mutableCopy() as NSMutableOrderedSet
        mutable.minusOrderedSet(objects)
        self.ratings = mutable.copy() as NSOrderedSet
    }

    func addRatingsObject(value: RMTRating!) {
        let mutable = self.ratings.mutableCopy() as NSMutableOrderedSet
        mutable.addObject(value)
        self.ratings = mutable.copy() as NSOrderedSet
    }

    func removeRatingsObject(value: RMTRating!) {
        let mutable = self.ratings.mutableCopy() as NSMutableOrderedSet
        mutable.removeObject(value)
        self.ratings = mutable.copy() as NSOrderedSet
    }

}

extension _RMTRatingCategory {

    func addSessions(objects: NSOrderedSet) {
        let mutable = self.sessions.mutableCopy() as NSMutableOrderedSet
        mutable.unionOrderedSet(objects)
        self.sessions = mutable.copy() as NSOrderedSet
    }

    func removeSessions(objects: NSOrderedSet) {
        let mutable = self.sessions.mutableCopy() as NSMutableOrderedSet
        mutable.minusOrderedSet(objects)
        self.sessions = mutable.copy() as NSOrderedSet
    }

    func addSessionsObject(value: RMTSession!) {
        let mutable = self.sessions.mutableCopy() as NSMutableOrderedSet
        mutable.addObject(value)
        self.sessions = mutable.copy() as NSOrderedSet
    }

    func removeSessionsObject(value: RMTSession!) {
        let mutable = self.sessions.mutableCopy() as NSMutableOrderedSet
        mutable.removeObject(value)
        self.sessions = mutable.copy() as NSOrderedSet
    }

}
