// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RMTRatingCategory.swift instead.

import CoreData

enum RMTRatingCategoryAttributes: String {
    case detail = "detail"
    case myLocalRating = "myLocalRating"
    case title = "title"
}

enum RMTRatingCategoryRelationships: String {
    case ratings = "ratings"
    case session = "session"
}

@objc
class _RMTRatingCategory: RMTCloudKit {

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
    var myLocalRating: NSNumber?

    // func validateMyLocalRating(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var title: String?

    // func validateTitle(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    // MARK: - Relationships

    @NSManaged
    var ratings: NSOrderedSet

    @NSManaged
    var session: RMTSession?

    // func validateSession(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

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
