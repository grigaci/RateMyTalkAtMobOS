// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RMTSession.swift instead.

import CoreData

enum RMTSessionAttributes: String {
    case title = "title"
}

enum RMTSessionRelationships: String {
    case ratingCategories = "ratingCategories"
    case speaker = "speaker"
}

@objc
class _RMTSession: RMTCloudKit {

    // MARK: - Class methods

    override class func entityName () -> String {
        return "RMTSession"
    }

    override class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _RMTSession.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged
    var title: String?

    // func validateTitle(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    // MARK: - Relationships

    @NSManaged
    var ratingCategories: NSOrderedSet

    @NSManaged
    var speaker: RMTSpeaker?

    // func validateSpeaker(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

}

extension _RMTSession {

    func addRatingCategories(objects: NSOrderedSet) {
        let mutable = self.ratingCategories.mutableCopy() as NSMutableOrderedSet
        mutable.unionOrderedSet(objects)
        self.ratingCategories = mutable.copy() as NSOrderedSet
    }

    func removeRatingCategories(objects: NSOrderedSet) {
        let mutable = self.ratingCategories.mutableCopy() as NSMutableOrderedSet
        mutable.minusOrderedSet(objects)
        self.ratingCategories = mutable.copy() as NSOrderedSet
    }

    func addRatingCategoriesObject(value: RMTRatingCategory!) {
        let mutable = self.ratingCategories.mutableCopy() as NSMutableOrderedSet
        mutable.addObject(value)
        self.ratingCategories = mutable.copy() as NSOrderedSet
    }

    func removeRatingCategoriesObject(value: RMTRatingCategory!) {
        let mutable = self.ratingCategories.mutableCopy() as NSMutableOrderedSet
        mutable.removeObject(value)
        self.ratingCategories = mutable.copy() as NSOrderedSet
    }

}
