// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RMTSession.swift instead.

import CoreData

enum RMTSessionAttributes: String {
    case title = "title"
}

@objc
class _RMTSession: RMTParent {

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

}

