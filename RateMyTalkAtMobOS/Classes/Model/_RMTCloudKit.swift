// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RMTCloudKit.swift instead.

import CoreData

enum RMTCloudKitAttributes: String {
    case ckRecordID = "ckRecordID"
}

@objc
class _RMTCloudKit: RMTParent {

    // MARK: - Class methods

    override class func entityName () -> String {
        return "RMTCloudKit"
    }

    override class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _RMTCloudKit.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged
    var ckRecordID: String?

    // func validateCkRecordID(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    // MARK: - Relationships

}

