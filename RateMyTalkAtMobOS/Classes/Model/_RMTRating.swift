// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RMTRating.swift instead.

import CoreData

enum RMTRatingAttributes: String {
    case stars = "stars"
}

enum RMTRatingRelationships: String {
    case ratingCategory = "ratingCategory"
}

@objc
class _RMTRating: RMTParent {

    // MARK: - Class methods

    override class func entityName () -> String {
        return "RMTRating"
    }

    override class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _RMTRating.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged
    var stars: NSNumber?

    // func validateStars(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    // MARK: - Relationships

    @NSManaged
    var ratingCategory: RMTRatingCategory?

    // func validateRatingCategory(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

}

