// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RMTSpeaker.swift instead.

import CoreData

enum RMTSpeakerAttributes: String {
    case name = "name"
}

enum RMTSpeakerRelationships: String {
    case sessions = "sessions"
}

@objc
class _RMTSpeaker: RMTParent {

    // MARK: - Class methods

    override class func entityName () -> String {
        return "RMTSpeaker"
    }

    override class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _RMTSpeaker.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged
    var name: String?

    // func validateName(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    // MARK: - Relationships

    @NSManaged
    var sessions: NSOrderedSet

}

extension _RMTSpeaker {

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
